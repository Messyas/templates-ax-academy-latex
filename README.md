# Templates LaTeX — AX Academy / IFAM

Repositório centralizado de templates de relatórios e documentos em LaTeX para os projetos da **AX Academy** e do **Polo de Inovação IFAM**, padronizados com a identidade visual da **LG Electronics (LGE)** e geridos localmente com ambiente **`uv`**.

---

## Sumário

1. [Visão Geral dos Templates](#1-visão-geral-dos-templates)
2. [Estrutura do Projeto](#2-estrutura-do-projeto)
3. [Fontes Compartilhadas (Global)](#3-fontes-compartilhadas-global)
4. [Configuração de Saídas (Outputs)](#4-configuração-de-saídas-outputs)
5. [Pré-requisitos do Sistema](#5-pré-requisitos-do-sistema)
6. [Instalação e Ambiente (`uv`)](#6-instalação-e-ambiente-uv)
7. [Como Compilar e Gerar os PDFs](#7-como-compilar-e-gerar-os-pdfs)
   - [Modo 1: Automatizado via `uv` (Recomendado)](#modo-1-automatizado-via-uv-recomendado)
   - [Modo 2: Compilação Manual Direta via Terminal](#modo-2-compilação-manual-direta-via-terminal)
8. [Personalização e Configurações (`templates.config.json`)](#8-personalização-e-configurações-templatesconfigjson)
9. [Solução de Problemas (Troubleshooting)](#9-solução-de-problemas-troubleshooting)

---

## 1. Visão Geral dos Templates

O repositório contém três formatos de documentos, cada um adaptado para uma finalidade específica:

| Template | Diretório | Arquivo Principal | Saída Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| **Apostila** | `Apostila/` | `guia-rapido.tex` | `dist/guia-rapido.pdf` | Guia Rápido de Uso multi-página (classe `book`, capa composta, sumário, capítulos modulares em `caps/`, marcas em `art/`, capturas em `img/`). Requer 2 passadas para sumário e paginação. |
| **Flyer** | `Flyer/` | `guia-flyer.tex` | `dist/guia-flyer.pdf` | Folha única em formato **A3 paisagem** com grade 4x2 de cartões. Ideal para guias rápidos plastificados ou afixados ao lado do posto de trabalho. |
| **OnePage** | `One-page/` | `onepage-lg.tex` | `dist/onepage-lg.pdf` | Slide executivo corporativo de alto impacto no padrão LGE (33.87 x 19.05 cm), estruturado em **Antes / Depois / Resultado**. |

---

## 2. Estrutura do Projeto

```text
templates-ax-academy-latex/
├── fonts/                       # 🌟 Pasta global de fontes compartilhadas (raiz)
│   ├── LGEIHeadlineTTF-*.ttf   # Família de títulos LG EI Headline
│   └── LGEITextTTF-*.ttf       # Família de texto LG EI Text
├── Apostila/                    # Template de Guia Rápido multi-página
│   ├── caps/                    # Capítulos modulares (\include)
│   ├── art/                     # Marcas e fundos institucionais
│   ├── img/                     # Capturas de tela do sistema
│   ├── axacademy-guia.sty       # Pacote de estilos e diagramação
│   └── guia-rapido.tex          # Documento raiz
├── Flyer/                       # Template de Folha Única A3 Paisagem
│   ├── art/                     # Marcas e fundos
│   ├── img/                     # Capturas de tela dos passos
│   ├── axacademy-flyer.sty      # Estilos do grid TikZ
│   └── guia-flyer.tex           # Documento raiz
├── One-page/                    # Template OnePage corporativo (PPTX-style)
│   ├── img/                     # Ícones e diagramas
│   ├── onepagelg.sty            # Motor de layout geométrico
│   └── onepage-lg.tex           # Conteúdo executivo
├── dist/                        # 📂 Diretório de saída dos PDFs finais (gerado no build)
├── build.py                     # Script Python de build, validação e limpeza
├── pyproject.toml               # Configuração do ambiente e dependências uv
├── templates.config.json        # Configuração das rotas de saída e parâmetros dos templates
├── .gitignore                   # Ignora .venv, dist/ e arquivos temporários do LaTeX
└── README.md                    # Esta documentação
```

---

## 3. Fontes Compartilhadas (Global)

Para evitar duplicatas de arquivos pesados em cada subpasta, todas as fontes foram centralizadas na pasta raiz:

```text
fonts/
├── LGEIHeadlineTTF-Bold.ttf
├── LGEIHeadlineTTF-Light.ttf
├── LGEIHeadlineTTF-Regular.ttf
├── LGEIHeadlineTTF-Semibold.ttf
├── LGEIHeadlineTTF-Thin.ttf
├── LGEIHeadlineVF.ttf
├── LGEITextTTF-Bold.ttf
├── LGEITextTTF-Light.ttf
├── LGEITextTTF-Regular.ttf
└── LGEITextTTF-SemiBold.ttf
```

### Como os templates encontram as fontes

Os arquivos de estilo (`axacademy-guia.sty`, `axacademy-flyer.sty`, `onepagelg.sty`) estão configurados com resolução inteligente e segura:

1. Buscam na pasta global compartilhada: `../fonts/` (quando compilados a partir da pasta do template).
2. Se não encontrarem, buscam na pasta local `fonts/` (caso o template seja copiado isoladamente).
3. Se nenhum arquivo TTF for localizado, fazem fallback automático para a fonte instalada no sistema operacional (`LG EI Text` / `LG EI Headline`), emitindo um aviso explicativo.

---

## 4. Configuração de Saídas (Outputs)

Ao compilar documentos LaTeX, o motor gera diversos arquivos intermediários (`.aux`, `.log`, `.toc`, `.out`, `.fls`). 

Para manter o projeto organizado:
- **PDFs Finais:** São direcionados automaticamente para a pasta **`dist/`** na raiz:
  - `dist/guia-rapido.pdf`
  - `dist/guia-flyer.pdf`
  - `dist/onepage-lg.pdf`
- **Limpeza Automática:** O script de compilação remove os arquivos auxiliares após o build, mantendo as pastas de código limpas.
- **Customização:** A pasta de destino e os nomes dos PDFs podem ser alterados via parâmetro `--out-dir` ou no arquivo `templates.config.json`.

---

## 5. Pré-requisitos do Sistema

Para compilar os relatórios localmente, você precisa de:

1. **Python 3.12+** e o gerenciador **`uv`** instalados.
2. Uma distribuição **LaTeX com `lualatex`**:
   > [!IMPORTANT]
   > Os templates utilizam o pacote `fontspec` para carregar fontes TrueType (`.ttf`) diretamente por caminho relativo. **Não use `pdflatex`**. Utilize exclusivamente **`lualatex`**.

### Instalação do compilador no Windows

Se ainda não tiver o `lualatex` instalado, escolha uma das opções:

#### Opção A: TeX Live (Recomendado via Windows Terminal)
```powershell
winget install --id TeXLive.TeXLive
```

#### Opção B: MiKTeX (Alternativa mais leve com download sob demanda)
```powershell
winget install MiKTeX.MiKTeX
```

*Após a instalação, feche e abra o terminal novamente para que o comando `lualatex` passe a constar no seu `PATH`.*

---

## 6. Instalação e Ambiente (`uv`)

Com o `uv` instalado em sua máquina, inicialize as dependências e o ambiente virtual:

```powershell
# 1. Clone ou entre na pasta do projeto
cd d:\templates-ax-academy-latex

# 2. Sincronize o ambiente e instale as ferramentas necessárias
uv sync
```

O comando criará automaticamente o ambiente virtual isolado em `.venv` com as ferramentas de compilação prontas para uso.

---

## 7. Como Compilar e Gerar os PDFs

### Modo 1: Automatizado via `uv` (Recomendado)

O script integrado gerencia a ordem das passadas, a movimentação do PDF para `dist/` e a limpeza de arquivos temporários.

#### Diagnóstico do ambiente
Antes de compilar, verifique se seu ambiente está 100% pronto:
```powershell
uv run build check
```

#### Listar templates disponíveis
```powershell
uv run build list
```

#### Compilar TODOS os relatórios
Gera os PDFs de todos os templates em `dist/`:
```powershell
uv run build
# ou
uv run build all
```

#### Compilar um template específico
```powershell
# Compilar somente a Apostila (Guia Rápido multi-página):
uv run build apostila

# Compilar somente o Flyer A3:
uv run build flyer

# Compilar somente o OnePage:
uv run build onepage
```

#### Opções úteis de compilação
```powershell
# Definir uma pasta de saída diferente de dist/ (ex: pasta de entrega):
uv run build -o "C:\Entregas\PDFs"

# Manter os arquivos auxiliares para depuração (não apagar .log / .aux):
uv run build apostila --no-clean

# Ver logs detalhados de cada etapa:
uv run build --verbose
```

#### Limpeza manual de arquivos temporários
```powershell
# Limpa arquivos .aux, .log, .toc de todos os templates:
uv run build clean

# Limpa temporários e também esvazia a pasta dist/:
uv run build clean-all
```

---

### Modo 2: Compilação Manual Direta via Terminal

Se preferir não usar o Python e compilar diretamente com o compilador `lualatex`, você pode navegar até a pasta desejada:

#### 1. Apostila (Guia Rápido)
*A Apostila requer **duas passadas** para que o LaTeX calcule o sumário e o total de páginas corretamente:*
```powershell
cd Apostila
lualatex guia-rapido.tex
lualatex guia-rapido.tex
```
O arquivo gerado será `Apostila\guia-rapido.pdf`.

#### 2. Flyer A3
*O Flyer precisa de apenas **uma passada**:*
```powershell
cd Flyer
lualatex guia-flyer.tex
```
O arquivo gerado será `Flyer\guia-flyer.pdf`.

#### 3. OnePage
*O OnePage requer **duas passadas** para posicionamento milimétrico e medições de blocos no TikZ:*
```powershell
cd One-page
lualatex onepage-lg.tex
lualatex onepage-lg.tex
```
O arquivo gerado será `One-page\onepage-lg.pdf`.

---

## 8. Personalização e Configurações (`templates.config.json`)

Você pode configurar caminhos e nomes de saída no arquivo `templates.config.json` sem precisar alterar os arquivos `.tex` ou o script de build:

```json
{
  "output_dir": "dist",
  "fonts_dir": "fonts",
  "clean_aux_after_build": true,
  "templates": {
    "apostila": {
      "name": "Apostila",
      "directory": "Apostila",
      "entrypoint": "guia-rapido.tex",
      "output_name": "guia-rapido.pdf",
      "passes": 2
    },
    "flyer": {
      "name": "Flyer",
      "directory": "Flyer",
      "entrypoint": "guia-flyer.tex",
      "output_name": "guia-flyer.pdf",
      "passes": 1
    },
    "onepage": {
      "name": "OnePage",
      "directory": "One-page",
      "entrypoint": "onepage-lg.tex",
      "output_name": "onepage-lg.pdf",
      "passes": 2
    }
  }
}
```

---

## 9. Solução de Problemas (Troubleshooting)

### O comando `uv run build check` acusa `Compilador (lualatex): NÃO ENCONTRADO`
- Verifique se a distribuição TeX foi instalada (`winget install --id TeXLive.TeXLive` ou `winget install MiKTeX.MiKTeX`).
- Reinicie o terminal do Windows para que as novas variáveis de ambiente do `PATH` tenham efeito.
- Teste executando `lualatex --version` diretamente no terminal.

### O sumário ou número de páginas da Apostila aparecem como `??` ou vazios
- O LaTeX precisa de uma segunda passada para registrar as referências cruzadas no arquivo `.aux` e desenhar o sumário no `.toc`. O comando `uv run build apostila` já executa 2 passadas automaticamente. Na compilação manual, execute o comando duas vezes seguidas.

### Adicionar novas imagens ou logotipos
- Para a **Apostila**: adicione imagens em `Apostila/img/` e artes/marcas em `Apostila/art/marca/` ou `Apostila/art/fundo/`.
- Para o **Flyer**: adicione capturas em `Flyer/img/`.
- Para o **OnePage**: adicione os ícones em `One-page/img/`.
