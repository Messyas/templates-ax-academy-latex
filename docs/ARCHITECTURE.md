# Arquitetura Técnica do Repositório

Este documento detalha o mapa de componentes, convenções de caminhos, hierarquia tipográfica, segregação de saídas e o motor de automação do projeto.

---

## 1. Visão Geral dos Módulos

```text
templates-ax-academy-latex/
│
├── modelos/                             # Diretório centralizado de todos os modelos LaTeX
│   │
│   ├── fonts/                           # Repositório central de fontes TrueType (TTF)
│   │   ├── LGEIHeadlineTTF-*.ttf        # Variantes da fonte de destaque (Bold, Light, Regular, Semibold, Thin, VF)
│   │   └── LGEITextTTF-*.ttf            # Variantes de texto corrido (Bold, Light, Regular, SemiBold)
│   │
│   ├── Apostila/                        # 1. Guia Rápido multi-página (Book)
│   │   ├── axacademy-guia.sty           # Design system, fancyhdr, tcolorbox, titlesec
│   │   ├── guia-rapido.tex              # Ponto de entrada com metadados
│   │   ├── caps/                        # Conteúdo modularizado (cap01.tex, cap02.tex)
│   │   ├── art/                         # Identidade visual vetorial (art/fundo/, art/marca/)
│   │   └── img/                         # Capturas de tela (01-login.png, etc.)
│   │
│   ├── Flyer/                           # 2. Folha única A3 paisagem
│   │   ├── axacademy-flyer.sty          # Layout em grade TikZ de 4 colunas x 2 linhas
│   │   ├── guia-flyer.tex               # Declaração dos 8 passos via \flyerpasso
│   │   ├── art/                         # Marcas institucionais e logos
│   │   └── img/                         # Capturas de tela
│   │
│   ├── OnePage-Sumarizacao/              # 3. Slide executivo corporativo (PT)
│   │   ├── onepagelg.sty                # Canvas geométrico TikZ 33.87 x 19.05 cm
│   │   ├── onepage-lg.tex               # Antes / Depois / Resultado
│   │   └── img/                         # Ícones conceituais
│   │
│   ├── Status-Report/                   # 4. Status Report semanal de equipe
│   │   ├── status-report-equipe3.tex    # Slide 32 x 18 cm com equal height group
│   │   ├── exemplos/                    # Diagramas de arquitetura e fluxo
│   │   └── img/                         # Capturas e fotos
│   │
│   ├── OnePage-Evidencias/              # 5. OnePage de Evidências do Sprint
│   │   ├── onepage-evidencias-equipe3.tex # Folha A3 paisagem com 4 cartões de evidências
│   │   └── img/                         # Fotos e evidências tangíveis
│   │
│   ├── OnePage-Corporativo-LGE/         # 6. OnePage executivo corporativo original (EN)
│   │   ├── onepagelg.sty                # Estilo corporativo com layout widescreen
│   │   ├── onepage-lg.tex               # AI Deep Dive / AI Core
│   │   └── img/                         # Ícones corporativos
│   │
│   ├── Guia-Usuario-Hanaro/             # 7. Guia do Usuário do Hanaro (Book; Arquitetura e IA)
│   │   ├── axacademy-guia.sty           # Cópia do design system da Apostila
│   │   ├── guia-usuario.tex             # Ponto de entrada com metadados
│   │   ├── caps/                        # cap01.tex (Arquitetura) e cap02.tex (IA)
│   │   ├── art/                         # Identidade visual vetorial
│   │   └── img/                         # Telas do Assistente e da tradução
│   │
│   └── referencias/                     # Apresentações e materiais visuais de referência
│       └── Layout de Report - One Page.pptx
│
├── dist/                                # Diretório central de saídas segregadas por template
│   ├── Apostila/guia-rapido.pdf
│   ├── Guia-Usuario-Hanaro/guia-usuario-hanaro.pdf
│   ├── Flyer/guia-flyer.pdf
│   ├── OnePage-Sumarizacao/onepage-lg.pdf
│   ├── Status-Report/status-report-equipe3.pdf
│   ├── OnePage-Evidencias/onepage-evidencias-equipe3.pdf
│   └── OnePage-Corporativo-LGE/onepage-corporativo-lg.pdf
│
├── build.py                             # CLI de compilação, diagnóstico e limpeza
├── templates.config.json                # Configuração de rotas, passadas e subpastas de saída
├── pyproject.toml                       # Dependências do ambiente Python gerenciadas pelo uv
└── .gitignore                           # Exclusão estrita de artefatos temporários e binários compilados
```

---

## 2. Resolução de Fontes e Tipografia

A identidade visual utiliza a família corporativa **LG EI**.

Todas as fontes residem exclusivamente na pasta central `modelos/fonts/`. Os modelos em `modelos/<Template>` acessam as fontes através do seguinte mecanismo:

1. **Acesso Direto (`Path=../fonts/`)**:
   Por estarem todos no mesmo nível hierárquico dentro de `modelos/`, cada template localiza as fontes subindo exatamente 1 nível de diretório (`../fonts/`). Isso elimina qualquer necessidade de travessia profunda (`../../`), sendo 100% suportado por qualquer versão do LuaLaTeX e MiKTeX sem requerer permissões adicionais.

2. **Fallback Local e de Sistema Operacional**:
   - Se uma pasta de template for isolada do repositório, ela procura uma pasta local `fonts/`.
   - Se nenhum arquivo TTF for localizado, o estilo recorre com aviso (`PackageWarning`) às fontes instaladas no sistema operacional (`LG EI Text` e `LG EI Headline`).

---

## 3. Segregação de Saídas (`dist/`)

Para evitar sobrescritas acidentais (por exemplo, múltiplos templates que gerem arquivos com nomes similares como `onepage-lg.pdf`), cada template possui uma subpasta própria dentro de `dist/`:

- `dist/Apostila/`
- `dist/Guia-Usuario-Hanaro/`
- `dist/Flyer/`
- `dist/OnePage-Sumarizacao/`
- `dist/Status-Report/`
- `dist/OnePage-Evidencias/`
- `dist/OnePage-Corporativo-LGE/`

O script `build.py` cria essas subpastas dinamicamente e direciona os PDFs finais, garantindo total isolamento dos artefatos.

---

## 4. Resolução de Compilador (LuaLaTeX)

O utilitário `build.py` localiza o compilador `lualatex` na seguinte ordem de prioridade:

1. **Configuração explícita:** Campo `"compiler_path"` em `templates.config.json`.
2. **Variável de Ambiente:** `LUALATEX_PATH` ou `MIKTEX_BIN`.
3. **PATH do Sistema Operacional:** Comando `lualatex` registrado no PATH.
4. **Disco Principal (C:):**
   - `C:\Program Files\MiKTeX\miktex\bin\x64\lualatex.exe`
   - `%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64\lualatex.exe`
   - `C:\texlive\2026\bin\windows\lualatex.exe` (e anos anteriores)
5. **Discos Opcionais/Secundários (D:, E:, etc.):**
   - `D:\MiKTeX\miktex\bin\x64\lualatex.exe`
   - `D:\texlive\2026\bin\windows\lualatex.exe`
   - `E:\MiKTeX\miktex\bin\x64\lualatex.exe`

Isso assegura que o projeto rode imediatamente tanto na máquina de desenvolvedores que instalam no `C:` padrão quanto nos que optam por partições secundárias (`D:`).
