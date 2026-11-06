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
    uv run build              # Compila todos os templates para dist/
    uv run build apostila     # Compila apenas o Guia Rápido (Apostila)
    uv run build flyer        # Compila apenas o Flyer A3
    uv run build onepage      # Compila apenas o OnePage LG
    uv run build check        # Valida compilador, fontes e integridade dos arquivos
    uv run build clean        # Remove arquivos temporários (.aux, .log, .toc, .ptc)
    ```
- **Nunca execute comandos manuais desnecessários:** O `build.py` já gerencia automaticamente a quantidade correta de passadas (2x para Apostila e OnePage, 1x para Flyer), o direcionamento do PDF para `dist/` e a limpeza de resíduos.

---

## 2. Padrão de Localização de Fontes (Global)

- **Localização:** Todas as fontes oficiais residem **exclusivamente na pasta raiz** [`fonts/`](../fonts):
  - `fonts/LGEIHeadlineTTF-*.ttf` (família de títulos e cabeçalhos)
  - `fonts/LGEITextTTF-*.ttf` (família de corpo de texto)
- **Não crie pastas de fontes locais:** Nunca recrie pastas `fonts/` dentro de `Apostila/`, `Flyer/` ou `One-page/`.
- **Como os pacotes `.sty` carregam as fontes:**
  Cada arquivo de estilo (`axacademy-guia.sty`, `axacademy-flyer.sty`, `onepagelg.sty`) possui a seguinte resolução:
  1. `Path=../fonts/` (quando executado a partir do diretório do template).
  2. `Path=fonts/` (caso executado a partir da raiz).
  3. Fallback com aviso para fontes do sistema operacional (`LG EI Text` e `LG EI Headline`).

---

## 3. Padrão de Saídas (Outputs) e Versionamento

- **Destino dos PDFs:** Todos os relatórios compilados são gravados em [`dist/`](../dist):
  - `dist/guia-rapido.pdf`
  - `dist/guia-flyer.pdf`
  - `dist/onepage-lg.pdf`
- **Não comitar PDFs gerados:** A pasta `dist/` e os arquivos `*/*.pdf` nas pastas de templates estão no `.gitignore`. Nunca force a adição de PDFs de saída ao Git (`git add -f ...`), pois são binários compilados derivados de código-fonte.
- **Assets Vetoriais em PDF:** Arquivos em `art/fundo/*.pdf` e `art/marca/*.pdf` são imagens vetoriais estáticas que **devem** ser mantidas no Git. O `.gitignore` está configurado para não bloqueá-las.

---

## 4. Arquitetura dos Templates

### A. Apostila (`Apostila/`)
- **Documento Raiz:** `Apostila/guia-rapido.tex`
- **Pacote de Estilo:** `Apostila/axacademy-guia.sty`
- **Capítulos:** Modularizados em `Apostila/caps/cap01.tex` e `Apostila/caps/cap02.tex`, carregados via `\include{caps/...}`.
- **Passadas:** Exige **2 passadas** para que o LaTeX resolva o sumário (`.toc`), referências cruzadas e contagem de páginas da classe `book`.
- **Assets:** Imagens em `Apostila/img/` e artes em `Apostila/art/`.

### B. Flyer A3 (`Flyer/`)
- **Documento Raiz:** `Flyer/guia-flyer.tex`
- **Pacote de Estilo:** `Flyer/axacademy-flyer.sty`
- **Estrutura:** Folha única A3 paisagem com canvas TikZ milimétrico. Grade de 4 colunas x 2 linhas de passos com o comando `\flyerpasso`.
- **Passadas:** 1 passada é suficiente.
- **Assets:** Capturas de tela em `Flyer/img/`.

### C. OnePage (`One-page/`)
- **Documento Raiz:** `One-page/onepage-lg.tex`
- **Pacote de Estilo:** `One-page/onepagelg.sty`
- **Estrutura:** Slide executivo corporativo no formato widescreen LGE (33.87 x 19.05 cm). Três colunas conceituais: *Antes* (`\tituloantes`), *Depois* (`\titulodepois`) e *Resultado* (`\tituloresultado`).
- **Passadas:** Exige **2 passadas**, pois o TikZ mede dinamicamente a altura das caixas de texto na primeira passada para distribuir os elementos na segunda.
- **Assets:** Ícones em `One-page/img/`.

---

## 5. Checklist para Agentes ao Modificar Código

Ao realizar qualquer alteração solicitada pelo usuário:
1. **Identificar o template correto** antes de modificar arquivos.
2. **Respeitar os pacotes já importados** e nunca reimportar `fontspec` ou pacotes de fontes conflitantes.
3. **Validar a compilação** executando `uv run build <template>`.
4. **Verificar os logs de erro:** Se a compilação falhar, o script exibirá o trecho exato do `.log` com a linha causadora do problema.
5. **Garantir a limpeza:** Ao finalizar, certifique-se de que nenhum arquivo `.aux`, `.log` ou `.toc` ficou solto no repositório executando `uv run build clean`.

