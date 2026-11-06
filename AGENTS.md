# AGENTS.md — Instruções de Operação para Agentes de IA
(OpenAI Codex, Google Antigravity, Cursor e outros agentes autônomos)

Este repositório contém templates LaTeX institucionais (AX Academy / IFAM / LGE) gerenciados localmente com Python e `uv`. Siga rigorosamente os padrões abaixo ao operar neste projeto.

---

## 1. Comandos Essenciais (Execução via `uv`)

Nunca adivinhe comandos shell de compilação ou flags do LaTeX. Utilize exclusivamente:

```bash
# Diagnóstico de integridade (compilador LuaLaTeX, fontes e templates)
uv run build check

# Compilação para PDF (saídas salvas em dist/)
uv run build              # Compila todos os relatórios
uv run build apostila     # Compila a Apostila / Guia Rápido multi-página
uv run build flyer        # Compila o Flyer A3 em folha única
uv run build onepage      # Compila o OnePage corporativo Antes/Depois/Resultado

# Limpeza de arquivos auxiliares de compilação
uv run build clean        # Remove .aux, .log, .toc, .ptc, etc.
uv run build clean-all    # Remove temporários e limpa a pasta dist/

# Listar configurações e rotas dos templates
uv run build list
```

---

## 2. Restrições do Compilador LaTeX

- **Motor Obrigatório:** **`lualatex`**.
- **Motor Proibido:** **`pdflatex`**. Todos os estilos utilizam `fontspec` para carregar fontes `.ttf` por arquivo. O `pdflatex` causará erro imediato e irrecuperável.
- **Passadas:**
  - `Apostila`: **2 passadas** (exigido para sumário e cálculo de páginas da classe `book`).
  - `Flyer`: **1 passada** (renderização única do canvas TikZ).
  - `OnePage`: **2 passadas** (medição dinâmica de altura dos blocos TikZ).
  *O script `build.py` já executa o número exato de passadas automaticamente.*

---

## 3. Fontes Compartilhadas (Global)

- Todas as fontes oficiais residem na pasta raiz: **`fonts/`**.
  - Fontes de título: `fonts/LGEIHeadlineTTF-*.ttf`
  - Fontes de texto: `fonts/LGEITextTTF-*.ttf`
- **Não crie pastas de fontes duplicadas** dentro de `Apostila/`, `Flyer/` ou `One-page/`.
- Os arquivos `.sty` buscam primeiramente em `Path=../fonts/` (em relação à pasta do template).

---

## 4. Gestão de Saídas e Git

- **Saída Oficial:** Todos os PDFs compilados finais devem ser gerados em **`dist/`**.
- **Arquivos no Git:** Nunca force a inclusão de PDFs gerados no Git (`dist/` e `*/*.pdf` estão no `.gitignore`). Apenas arquivos vetoriais de arte em `art/marca/*.pdf` e `art/fundo/*.pdf` são rastreados.

---

## 5. Documentação Complementar

Consulte a pasta [`docs/`](./docs) para especificações detalhadas:
- [`docs/AGENTS_GUIDE.md`](./docs/AGENTS_GUIDE.md): Diretrizes operacionais e checklist completo para agentes.
- [`docs/ARCHITECTURE.md`](./docs/ARCHITECTURE.md): Diagrama de fluxo de fontes, arquitetura e convenções técnicas.
- [`docs/TEMPLATES.md`](./docs/TEMPLATES.md): Guia de sintaxe e customização de cada template (`\passo`, `\flyerpasso`, `\tituloantes`, etc.).

