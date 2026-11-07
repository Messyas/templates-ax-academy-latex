# CLAUDE.md — Diretrizes para Claude Code

Orientações para o Claude ao trabalhar no repositório de templates LaTeX da AX Academy / IFAM.

## Build and Compilation Commands
- Sempre use o ambiente `uv` para executar comandos de compilação.
- `uv run build check`: Diagnostica a presença do compilador LuaLaTeX e das fontes TTF.
- `uv run build`: Compila todos os 9 relatórios/apresentações gerando os PDFs em `dist/<Template>/`.
- `uv run build apostila`: Compila o Guia Rápido multi-página (`dist/Apostila/guia-rapido.pdf`).
- `uv run build guia-usuario`: Compila a Documentação Técnica completa do Hanaro, Partes I, II e III (`dist/Guia-Usuario-Hanaro/guia-usuario-hanaro.pdf`).
- `uv run build guia-arquitetura`: Compila o Guia de Arquitetura do Hanaro, Partes I e II (`dist/Guia-Usuario-Hanaro/guia-arquitetura-hanaro.pdf`).
- `uv run build flyer`: Compila o Flyer A3 paisagem (`dist/Flyer/guia-flyer.pdf`).
- `uv run build onepage-sumarizacao`: Compila o OnePage LG Sumarização (`dist/OnePage-Sumarizacao/onepage-lg.pdf`).
- `uv run build status-report`: Compila o Status Report semanal (`dist/Status-Report/status-report-equipe3.pdf`).
- `uv run build onepage-evidencias`: Compila o OnePage Evidências (`dist/OnePage-Evidencias/onepage-evidencias-equipe3.pdf`).
- `uv run build onepage-corporativo`: Compila o OnePage Corporativo LGE (`dist/OnePage-Corporativo-LGE/onepage-corporativo-lg.pdf`).
- `uv run build demoday`: Compila a Apresentação Demo Day / Kick-off (`dist/DemoDay/demoday-hanaro.pdf`).
- `uv run build versions`: Lista o histórico de versões arquivadas em `dist/*/versoes/`.
- `uv run build <template> -t <tag>`: Compila e arquiva entrega recorrente com tag manual (ex: `sprint02`, `v2`, `w36`).
- `uv run build clean`: Limpa resíduos de compilação (`.aux`, `.log`, `.toc`, `.ptc`, etc.).
- `uv run build clean-all`: Limpa resíduos e remove a pasta `dist/`.
- `uv run build list`: Exibe os templates cadastrados e suas saídas.

## Engine and LaTeX Guidelines
- **Compilador:** Use exclusivamente **`lualatex`**. Nunca use `pdflatex` (o pacote `fontspec` quebra no pdflatex com arquivos TTF).
- **Passadas:** Apostila, Guia-Usuario-Hanaro (os dois alvos), OnePage-Sumarizacao, Status-Report, OnePage-Evidencias, OnePage-Corporativo e DemoDay requerem 2 passadas; Flyer requer 1 passada. O script `build.py` gerencia isso automaticamente.

## Fonts and Assets
- As fontes compartilhadas estão em `modelos/fonts/`. Não crie pastas de fontes locais nos subdiretórios individuais dos templates.
- Cada template em `modelos/<Template>/` acessa as fontes diretamente via `Path=../fonts/`.
- `modelos/Apostila/axacademy-guia.sty` e `modelos/Guia-Usuario-Hanaro/axacademy-guia.sty` devem permanecer idênticos: aplique qualquer mudança de estilo nas duas pastas e compile os dois guias. Apostila (Guia Rápido de telas) e Guia-Usuario-Hanaro (manual de arquitetura, IA e referência técnica) são documentos distintos; o texto específico de cada um fica no seu `.tex`, não no `.sty`.
- PDFs finais pertencem unicamente a `dist/<Template>/` e não devem ser rastreados no Git.

## Detailed Docs
- Consulte a pasta `docs/` para especificações aprofundadas:
  - `docs/AGENTS_GUIDE.md`: Diretrizes e checklist para agentes de IA.
  - `docs/ARCHITECTURE.md`: Arquitetura do repositório, fluxo de fontes e subpastas de saída.
  - `docs/TEMPLATES.md`: Sintaxe dos comandos de cada template.
