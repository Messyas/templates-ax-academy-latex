# AGENTS.md — Instruções de Operação para Agentes de IA
(OpenAI Codex, Google Antigravity, Cursor e outros agentes autônomos)

Este repositório contém templates LaTeX institucionais (AX Academy / IFAM / LGE) gerenciados localmente com Python e `uv`. Siga rigorosamente os padrões abaixo ao operar neste projeto.

---

## 1. Comandos Essenciais (Execução via `uv`)

Nunca adivinhe comandos shell de compilação ou flags do LaTeX. Utilize exclusivamente:

```bash
# Diagnóstico de integridade (compilador LuaLaTeX, fontes e templates)
uv run build check

# Compilação para PDF (saídas organizadas em dist/<Template>/)
uv run build                          # Compila todos os 9 relatórios/apresentações
uv run build apostila                 # Compila a Apostila / Guia Rápido multi-página
uv run build guia-usuario             # Compila a Documentação Técnica completa do Hanaro (Partes I, II e III)
uv run build guia-arquitetura         # Compila o Guia de Arquitetura do Hanaro (Partes I e II)
uv run build flyer                    # Compila o Flyer A3 em folha única
uv run build onepage-sumarizacao      # Compila o OnePage LG Sumarização (alias: onepage)
uv run build status-report            # Compila o Status Report semanal de equipe
uv run build onepage-evidencias       # Compila o OnePage de Evidências do Sprint
uv run build onepage-corporativo      # Compila o OnePage corporativo LGE (EN)
uv run build demoday                  # Compila a Apresentação Demo Day / Kick-off (Beamer 16:9)

# Versionamento e histórico de entregas recorrentes
uv run build versions                 # Lista todas as versões arquivadas em dist/*/versoes/
uv run build status-report -t sprint02 # Compila e arquiva com tag manual (ex: sprint02, w36)
uv run build demoday -t v2            # Compila e arquiva apresentação tagged

# Limpeza de arquivos auxiliares de compilação
uv run build clean                    # Remove .aux, .log, .toc, .ptc, etc.
uv run build clean-all                # Remove temporários e limpa a pasta dist/

# Listar configurações e rotas dos templates
uv run build list
```

---

## 2. Restrições do Compilador LaTeX

- **Motor Obrigatório:** **`lualatex`**.
- **Motor Proibido:** **`pdflatex`**. Todos os estilos utilizam `fontspec` para carregar fontes `.ttf` por arquivo. O `pdflatex` causará erro imediato e irrecuperável.
- **Passadas:**
  - `Guia-Usuario-Hanaro` (alvos `guia-usuario` e `guia-arquitetura`): **2 passadas** (sumário, referências e mapa de partes da classe `book`).
  - `Apostila`: **2 passadas** (exigido para sumário e cálculo de páginas da classe `book`).
  - `Flyer`: **1 passada** (renderização única do canvas TikZ).
  - `OnePage-Sumarizacao`: **2 passadas** (medição dinâmica de altura dos blocos TikZ).
  - `Status-Report`: **2 passadas** (cálculo de altura de caixas `equal height group`).
  - `OnePage-Evidencias`: **2 passadas** (alinhamento de cartões de evidência).
  - `OnePage-Corporativo-LGE`: **2 passadas** (medição de caixas de texto corporativas).
  - `DemoDay`: **2 passadas** (cálculo de referências TikZ `remember picture` e navegação Beamer).
  *O script `build.py` já executa o número exato de passadas automaticamente.*

---

## 3. Fontes Compartilhadas (Global)

- Todas as fontes oficiais residem de forma centralizada em: **`modelos/fonts/`**.
  - Fontes de título LGE: `modelos/fonts/LGEIHeadlineTTF-*.ttf`
  - Fontes de texto LGE: `modelos/fonts/LGEITextTTF-*.ttf`
  - Fontes Demo Day (Kick-off): `modelos/fonts/Montserrat-*.ttf` e `modelos/fonts/Urbanist-*.ttf`
- **Não crie pastas de fontes duplicadas** dentro das subpastas individuais dos templates.
- Cada template em `modelos/<Template>/` acessa as fontes diretamente através de `Path=../fonts/`.

---

## 4. Estrutura e Gestão de Saídas

- **Organização dos Modelos:** Todos os templates ficam centralizados em subpastas de `modelos/`:
  - `modelos/Apostila`
  - `modelos/Guia-Usuario-Hanaro`
  - `modelos/Flyer`
  - `modelos/OnePage-Sumarizacao`
  - `modelos/Status-Report`
  - `modelos/OnePage-Evidencias`
  - `modelos/OnePage-Corporativo-LGE`
  - `modelos/DemoDay` (apresentação de slides Beamer 16:9)
  - `modelos/referencias` (apresentações e referências visuais)
- **Saída Oficial Segregada e Versionamento:**
  - **Modelos Estruturais / Fixos** (`Apostila`, `Guia-Usuario-Hanaro`, `Flyer`): mantêm a saída canônica única em `dist/<Template>/<output_name>` (ex: `dist/Apostila/guia-rapido.pdf`).
  - **Entregas Recorrentes** (`DemoDay`, `Status-Report`, `OnePage-Evidencias`, `OnePage-Sumarizacao`, `OnePage-Corporativo-LGE`): geram sempre o PDF canônico mais recente na raiz de `dist/<Template>/` E, simultaneamente, gravam uma cópia imutável rastreável e seu preview PNG em `dist/<Template>/versoes/<stem>-<tag>.pdf` (ex: `dist/Status-Report/versoes/status-report-equipe3-sprint02.pdf`). A tag é detectada automaticamente do `.tex` ou fornecida via `-t <tag>`.
- **Arquivos no Git:** Nunca force a inclusão de PDFs gerados no Git (`dist/` e `modelos/**/*.pdf` estão no `.gitignore`). Apenas arquivos vetoriais de arte em `art/marca/*.pdf` e `art/fundo/*.pdf` são rastreados.

---

## 5. Documentação Complementar

Consulte a pasta [`docs/`](./docs) para especificações detalhadas:
- [`docs/AGENTS_GUIDE.md`](./docs/AGENTS_GUIDE.md): Diretrizes operacionais e checklist completo para agentes.
- [`docs/ARCHITECTURE.md`](./docs/ARCHITECTURE.md): Diagrama de fluxo de fontes, arquitetura e convenções técnicas.
- [`docs/TEMPLATES.md`](./docs/TEMPLATES.md): Guia de sintaxe e customização de cada template (`\passo`, `\flyerpasso`, `\tituloantes`, etc.).
