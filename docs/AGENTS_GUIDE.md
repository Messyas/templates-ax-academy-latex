# Guia de Automação e Instruções para Agentes de IA
(OpenAI Codex, Anthropic Claude, Google Antigravity e outros)

Este documento fornece as diretrizes operacionais, restrições e padrões arquiteturais que qualquer agente autônomo de IA deve seguir estritamente ao inspecionar, modificar, adicionar conteúdo ou compilar relatórios neste repositório.

---

## 1. Regra de Ouro: Compilação e Execução

- **Ambiente:** O projeto é gerenciado exclusivamente via **`uv`** (Python 3.12+).
- **Nunca tente compilar com `pdflatex`:** Todos os templates utilizam `fontspec` para carregar fontes TrueType (`.ttf`) diretamente de disco. O uso de `pdflatex` gerará erro imediato e fatal.
- **Compilador Obrigatório:** O único motor suportado é o **`lualatex`**.
- **Comando Padrão de Build:**
  - Sempre utilize a CLI automatizada pelo `uv`:
    ```bash
    uv run build                          # Compila todos os 6 templates para dist/
    uv run build apostila                 # Compila o Guia Rápido (Apostila)
    uv run build flyer                    # Compila o Flyer A3
    uv run build onepage-sumarizacao      # Compila o OnePage LG Sumarização (alias: onepage)
    uv run build status-report            # Compila o Status Report Semanal
    uv run build onepage-evidencias       # Compila o OnePage de Evidências
    uv run build onepage-corporativo      # Compila o OnePage Corporativo LGE (EN)
    uv run build check                    # Valida compilador, fontes e integridade dos arquivos
    uv run build clean                    # Remove arquivos temporários (.aux, .log, .toc, .ptc)
    uv run build clean-all                # Remove temporários e limpa a pasta dist/
    uv run build list                     # Lista templates e rotas de saída configuradas
    ```
- **Nunca execute comandos manuais desnecessários:** O `build.py` já gerencia automaticamente a quantidade correta de passadas (2x para Apostila, OnePage-Sumarizacao, Status-Report, OnePage-Evidencias, OnePage-Corporativo e 1x para Flyer), o direcionamento do PDF para as subpastas em `dist/` e a limpeza de resíduos.

---

## 2. Padrão de Localização de Fontes (Centralizado em `modelos/fonts/`)

- **Localização:** Todas as fontes oficiais residem **exclusivamente na pasta** [`modelos/fonts/`](../modelos/fonts):
  - `modelos/fonts/LGEIHeadlineTTF-*.ttf` (família de títulos e cabeçalhos)
  - `modelos/fonts/LGEITextTTF-*.ttf` (família de corpo de texto)
- **Não crie pastas de fontes locais:** Nunca recrie pastas `fonts/` dentro de subdiretórios individuais dos templates.
- **Como a compilação carrega as fontes:**
  - Como todos os modelos estão em `modelos/<Template>/`, o acesso ocorre de forma nativa e segura através de `Path=../fonts/`.
  - Não são necessários links simbólicos nem travessias de múltiplos níveis (`../../`), garantindo compatibilidade total com o motor TeX em qualquer sistema operacional.

---

## 3. Padrão de Saídas (Outputs Segregados) e Versionamento

- **Destino dos PDFs:** Todos os relatórios compilados são gravados em subpastas isoladas dentro de [`dist/`](../dist):
  - `dist/Apostila/guia-rapido.pdf`
  - `dist/Flyer/guia-flyer.pdf`
  - `dist/OnePage-Sumarizacao/onepage-lg.pdf`
  - `dist/Status-Report/status-report-equipe3.pdf`
  - `dist/OnePage-Evidencias/onepage-evidencias-equipe3.pdf`
  - `dist/OnePage-Corporativo-LGE/onepage-corporativo-lg.pdf`
- **Não comitar PDFs gerados:** A pasta `dist/` e os arquivos `modelos/**/*.pdf` estão no `.gitignore`. Nunca force a adição de PDFs de saída ao Git (`git add -f ...`), pois são binários compilados derivados de código-fonte.
- **Assets Vetoriais em PDF:** Arquivos em `modelos/**/art/fundo/*.pdf` e `modelos/**/art/marca/*.pdf` são imagens vetoriais estáticas que **devem** ser mantidas no Git. O `.gitignore` está configurado para não bloqueá-las.

---

## 4. Arquitetura dos Templates em `modelos/`

### A. Apostila (`modelos/Apostila/`)
- **Documento Raiz:** `modelos/Apostila/guia-rapido.tex`
- **Pacote de Estilo:** `modelos/Apostila/axacademy-guia.sty`
- **Capítulos:** Modularizados em `caps/cap01.tex` e `caps/cap02.tex`, carregados via `\include{caps/...}`.
- **Passadas:** Exige **2 passadas** para que o LaTeX resolva o sumário (`.toc`), referências cruzadas e contagem de páginas da classe `book`.
- **Assets:** Imagens em `img/` e artes em `art/`.

### B. Flyer A3 (`modelos/Flyer/`)
- **Documento Raiz:** `modelos/Flyer/guia-flyer.tex`
- **Pacote de Estilo:** `modelos/Flyer/axacademy-flyer.sty`
- **Estrutura:** Folha única A3 paisagem com canvas TikZ milimétrico. Grade de 4 colunas x 2 linhas de passos com o comando `\flyerpasso`.
- **Passadas:** 1 passada é suficiente.
- **Assets:** Capturas de tela em `img/` e marcas em `art/`.

### C. OnePage Sumarização (`modelos/OnePage-Sumarizacao/`)
- **Documento Raiz:** `modelos/OnePage-Sumarizacao/onepage-lg.tex`
- **Pacote de Estilo:** `modelos/OnePage-Sumarizacao/onepagelg.sty`
- **Estrutura:** Slide executivo corporativo no formato widescreen LGE (33.87 x 19.05 cm). Três colunas conceituais: *Antes* (`\tituloantes`), *Depois* (`\titulodepois`) e *Resultado* (`\tituloresultado`).
- **Passadas:** Exige **2 passadas**, pois o TikZ mede dinamicamente a altura das caixas de texto.
- **Assets:** Ícones conceituais em `img/`.

### D. Status Report Semanal (`modelos/Status-Report/`)
- **Documento Raiz:** `modelos/Status-Report/status-report-equipe3.tex`
- **Estrutura:** Slide de acompanhamento semanal no formato widescreen LGE (32 x 18 cm). Duas colunas dinâmicas via `tcolorbox` com `equal height group` para alinhamento simétrico.
- **Passadas:** Exige **2 passadas** para equalização correta das caixas.
- **Assets:** Diagramas e capturas em `exemplos/` e `img/`.

### E. OnePage Evidências (`modelos/OnePage-Evidencias/`)
- **Documento Raiz:** `modelos/OnePage-Evidencias/onepage-evidencias-equipe3.tex`
- **Estrutura:** Folha única A3 paisagem voltada à apresentação de resultados tangíveis de sprints. Quatro cartões com fotos, capturas e descrições técnicas de impacto.
- **Passadas:** Exige **2 passadas**.
- **Assets:** Telas e fotos do sprint em `img/`.

### F. OnePage Corporativo LGE (`modelos/OnePage-Corporativo-LGE/`)
- **Documento Raiz:** `modelos/OnePage-Corporativo-LGE/onepage-lg.tex`
- **Pacote de Estilo:** `modelos/OnePage-Corporativo-LGE/onepagelg.sty`
- **Estrutura:** Template executivo corporativo original em inglês da LGE (AI Deep Dive / AI Core / AI Developers).
- **Passadas:** Exige **2 passadas**.
- **Assets:** Ícones em `img/`.

---

## 5. Checklist para Agentes ao Modificar Código

Ao realizar qualquer alteração solicitada pelo usuário:
1. **Identificar o template correto em `modelos/`** antes de modificar arquivos.
2. **Respeitar os pacotes já importados** e nunca reimportar `fontspec` ou pacotes de fontes conflitantes.
3. **Validar a compilação** executando `uv run build <template>`.
4. **Verificar os logs de erro:** Se a compilação falhar, o script exibirá o trecho exato do `.log` com a linha causadora do problema.
5. **Garantir a integridade das saídas:** Verifique se o PDF gerado foi salvo na subpasta correspondente em `dist/<Template>/`.
6. **Garantir a limpeza:** Ao finalizar, certifique-se de que nenhum arquivo `.aux`, `.log` ou `.toc` ficou solto no repositório executando `uv run build clean`.
