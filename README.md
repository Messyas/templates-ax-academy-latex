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

## 1. Visão Geral dos Modelos

O repositório unifica todos os modelos oficiais de relatórios e apresentações institucionais dentro da pasta **[`modelos/`](./modelos)**. Cada modelo possui sua pasta dedicada e gera seu PDF correspondente em uma subpasta específica dentro de **`dist/`** para evitar colisões e perda de arquivos:

| Modelo | Diretório | Arquivo Principal | Saída Oficial (PDF) | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| **Apostila** | `modelos/Apostila/` | `guia-rapido.tex` | `dist/Apostila/guia-rapido.pdf` | Guia Rápido de Uso multi-página (classe `book`, capa composta, sumário, capítulos em `caps/`, marcas em `art/`, telas em `img/`). Requer 2 passadas. |
| **Flyer A3** | `modelos/Flyer/` | `guia-flyer.tex` | `dist/Flyer/guia-flyer.pdf` | Folha única em formato **A3 paisagem** com grade 4x2 de cartões. Ideal para guias rápidos afixados no posto de trabalho. Requer 1 passada. |
| **OnePage Sumarização** | `modelos/OnePage-Sumarizacao/` | `onepage-lg.tex` | `dist/OnePage-Sumarizacao/onepage-lg.pdf` | Slide executivo Antes/Depois/Resultado (33.87 x 19.05 cm) adaptado para o sistema Hanaro. Requer 2 passadas. |
| **Status Report** | `modelos/Status-Report/` | `status-report-equipe3.tex` | `dist/Status-Report/status-report-equipe3.pdf` | Relatório semanal de sprint (32 x 18 cm) com cartões equalizados via `tcolorbox` e retratos da equipe. Requer 2 passadas. |
| **OnePage Evidências** | `modelos/OnePage-Evidencias/` | `onepage-evidencias-equipe3.tex` | `dist/OnePage-Evidencias/onepage-evidencias-equipe3.pdf` | Folha A3 paisagem com cartões de evidências de entrega, telas e fotos do sprint. Requer 2 passadas. |
| **OnePage Corporativo LGE** | `modelos/OnePage-Corporativo-LGE/` | `onepage-lg.tex` | `dist/OnePage-Corporativo-LGE/onepage-corporativo-lg.pdf` | Template original em inglês corporativo LGE (AI Deep Dive / AI Core / 40K hours saved). Requer 2 passadas. |

---

## 2. Estrutura do Projeto

```text
templates-ax-academy-latex/
├── modelos/                           # 📂 Todos os modelos consolidados + fontes compartilhadas
│   ├── fonts/                         # 🌟 Pasta central de fontes compartilhadas
│   │   ├── LGEIHeadlineTTF-*.ttf      # Família de títulos LG EI Headline
│   │   └── LGEITextTTF-*.ttf          # Família de texto LG EI Text
│   ├── Apostila/                      # Guia Rápido multi-página (Book)
│   ├── Flyer/                         # Folha única A3 Paisagem
│   ├── OnePage-Sumarizacao/           # Slide Antes / Depois / Resultado (Hanaro)
│   ├── Status-Report/                 # Status Report de Sprint com fotos da equipe
│   │   └── exemplos/                  # Decks de exemplo das outras equipes (1, 2, 4)
│   ├── OnePage-Evidencias/            # Evidências de Sprint em A3 Paisagem
│   ├── OnePage-Corporativo-LGE/       # Template original corporativo LGE (inglês)
│   └── referencias/                   # Layout de Report - One Page.pptx original
├── dist/                              # 🎯 Diretório de saída organizado por modelo
│   ├── Apostila/                      # -> guia-rapido.pdf
│   ├── Flyer/                         # -> guia-flyer.pdf
│   ├── OnePage-Sumarizacao/           # -> onepage-lg.pdf
│   ├── Status-Report/                 # -> status-report-equipe3.pdf
│   ├── OnePage-Evidencias/            # -> onepage-evidencias-equipe3.pdf
│   └── OnePage-Corporativo-LGE/       # -> onepage-corporativo-lg.pdf
├── docs/                              # Manuais técnicos e guias de arquitetura
├── AGENTS.md                          # Instruções para Codex, Antigravity e Cursor
├── CLAUDE.md                          # Diretrizes para Claude Code
├── build.py                           # CLI de compilação, diagnóstico e limpeza
├── pyproject.toml                     # Configuração do ambiente e dependências uv
├── templates.config.json              # Configuração das rotas de saída e parâmetros dos modelos
├── .gitignore                         # Ignora .venv, dist/ e arquivos temporários do LaTeX
└── README.md                          # Esta documentação
```

---

## 3. Fontes Compartilhadas (`modelos/fonts/`)

Para evitar duplicatas de arquivos pesados em cada subpasta, todas as fontes foram centralizadas em `modelos/fonts/`:

```text
modelos/fonts/
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

1. Buscam na pasta compartilhada: `../fonts/` (quando compilados a partir de `modelos/<Template>/`).
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

## 5. Guia de Instalação para Novos Colaboradores

Para novos membros e colaboradores começarem a gerar os relatórios em menos de 5 minutos, siga os 3 passos abaixo no Windows PowerShell:

### Passo 1: Instalar o compilador LaTeX (MiKTeX)

> [!TIP]
> O **MiKTeX** é a opção mais rápida e leve: ele baixa apenas o núcleo essencial (~200 MB) e faz o download automático de pacotes adicionais em segundo plano conforme os relatórios exigirem.

Abra o PowerShell como Administrador e execute:

```powershell
# Opção Padrão (Recomendada): Instalação no disco principal da máquina (C:)
winget install MiKTeX.MiKTeX --accept-source-agreements --accept-package-agreements --silent --custom "--auto-install=yes"

# Opção Alternativa: Caso deseje instalar em outro disco (ex: partição D:)
winget install MiKTeX.MiKTeX --location "D:\MiKTeX" --accept-source-agreements --accept-package-agreements --silent --custom "--auto-install=yes"
```

*Após a conclusão da instalação, feche e abra o terminal para recarregar as variáveis de ambiente (`PATH`). O script de build reconhece automaticamente tanto o disco principal (C:) quanto o secundário (D:), ou qualquer caminho configurado em `templates.config.json`.*

### Passo 2: Instalar o gerenciador `uv` (se ainda não possuir)

O projeto utiliza o `uv` da Astral para gerenciar o Python e o ambiente virtual:
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### Passo 3: Sincronizar o projeto e validar

Dentro da pasta do projeto, execute:
```powershell
# 1. Sincroniza as dependências Python e cria o ambiente .venv
uv sync

# 2. Executa o diagnóstico automático do ambiente
uv run build check

# 3. Compila todos os relatórios para a pasta dist/
uv run build
```

---

## 6. Configuração e Dependências do Ambiente (`uv`)

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

---

## 10. Suporte a Agentes de IA (Codex, Claude, Antigravity)

O projeto está totalmente preparado para ser operado por agentes de IA e desenvolvedores assistidos por IA:

- [`AGENTS.md`](./AGENTS.md): Regras de operação rápida e restrições para Codex, Antigravity e Cursor.
- [`CLAUDE.md`](./CLAUDE.md): Instruções nativas para o Claude Code.
- [`docs/`](./docs/):
  - [`docs/AGENTS_GUIDE.md`](./docs/AGENTS_GUIDE.md): Checklist e guia profundo de navegação e compilação para agentes autônomos.
  - [`docs/ARCHITECTURE.md`](./docs/ARCHITECTURE.md): Diagrama do fluxo de fontes e arquitetura técnica.
  - [`docs/TEMPLATES.md`](./docs/TEMPLATES.md): Manual dos comandos específicos de cada template.

