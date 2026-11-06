# CLAUDE.md — Diretrizes para Claude Code

Orientações para o Claude ao trabalhar no repositório de templates LaTeX da AX Academy / IFAM.

## Build and Compilation Commands
- Sempre use o ambiente `uv` para executar comandos de compilação.
- `uv run build check`: Diagnostica a presença do compilador LuaLaTeX e das fontes TTF.
- `uv run build`: Compila todos os relatórios (`Apostila`, `Flyer`, `OnePage`) gerando os PDFs em `dist/`.
- `uv run build apostila`: Compila o Guia Rápido multi-página (`dist/guia-rapido.pdf`).
- `uv run build flyer`: Compila o Flyer A3 paisagem (`dist/guia-flyer.pdf`).
- `uv run build onepage`: Compila o OnePage corporativo (`dist/onepage-lg.pdf`).
- `uv run build clean`: Limpa resíduos de compilação (`.aux`, `.log`, `.toc`, `.ptc`, etc.).

## Engine and LaTeX Guidelines
- **Compilador:** Use exclusivamente **`lualatex`**. Nunca use `pdflatex` (o pacote `fontspec` quebra no pdflatex com arquivos TTF).
- **Passadas:** Apostila e OnePage requerem 2 passadas; Flyer requer 1 passada. O script `build.py` já gerencia isso automaticamente.

## Fonts and Assets
- As fontes globais estão na pasta raiz `fonts/`. Não crie pastas de fontes locais em subdiretórios.
- Os pacotes `.sty` (`axacademy-guia.sty`, `axacademy-flyer.sty`, `onepagelg.sty`) acessam as fontes via `Path=../fonts/`.
- PDFs finais pertencem unicamente a `dist/` e não devem ser rastreados no Git.

## Detailed Docs
- Consulte a pasta `docs/` para especificações aprofundadas:
  - `docs/AGENTS_GUIDE.md`: Diretrizes e checklist para agentes de IA.
  - `docs/ARCHITECTURE.md`: Arquitetura do repositório e resolução de compiladores/fontes.
  - `docs/TEMPLATES.md`: Sintaxe dos comandos de cada template.

