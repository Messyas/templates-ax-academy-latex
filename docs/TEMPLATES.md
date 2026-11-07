# Guia de Edição e Customização dos Modelos

Este documento explica como customizar o conteúdo de cada um dos modelos disponíveis na pasta [`modelos/`](../modelos).

---

## 1. Apostila (`modelos/Apostila/guia-rapido.tex`)

A Apostila é ideal para manuais de uso detalhados, apostilas de treinamento e guias técnicos completos.

### Metadados Principais (em `guia-rapido.tex`):
```latex
\guiatitulo{Guia Rápido\\de Uso}          % Título da capa (suporta quebra de linha)
\guiasubtitulo{}                          % Subtítulo (opcional)
\guiasistema{Hanaro}                      % Nome do sistema
\guiaequipe{equipe do Polo INOVA}         % Autoria institucional
\guiaano{2026}                            % Ano
\guiaversao{1.0}                          % Versão do documento
\guiacidade{Manaus, Amazonas --- Brasil}  % Localidade
\guiacliente{LG Electronics do Brasil}    % Cliente / Parceiro
\guiamarcatexto{hanaro-assinatura}        % Arquivo do logo em art/marca/ (sem extensão)
```

### Estrutura dos Passos com Capturas:
No arquivo `caps/cap02.tex`, cada passo combina a captura de tela com pontos de atenção numerados sobre a imagem:
```latex
\begin{passo}{img/01-login.png}{Entrar no sistema}
    \begin{elementos}
        \item \campo{Usuário}: nome cadastrado pelo administrador.
        \item \campo{Senha}: senha de acesso à rede.
        \item \botao{Entrar}: submete as credenciais.
    \end{elementos}
\end{passo}
```

---

## 2. Flyer A3 (`modelos/Flyer/guia-flyer.tex`)

O Flyer sintetiza os 8 passos operacionais em uma única folha A3 em paisagem.

### Dados da Folha:
```latex
\flyerchamada{PASSO A PASSO \textperiodcentered{} PERFIL GESTOR}
\flyertitulo{Guia Rápido de Uso}
\flyermarca{hanaro-assinatura}
\flyerautoria{Desenvolvido pela equipe do Polo INOVA \textperiodcentered{} AX Academy}
```

### Sintaxe do Comando `\flyerpasso`:
```latex
\flyerpasso[marcador_x/marcador_y, ...]{coluna}{linha}{arquivo_imagem}{Título do Passo}{
    Texto descritivo do passo.
    \begin{elementos}
        \item \campo{Campo}: descrição.
        \item \botao{Botão}: ação disparada.
    \end{elementos}
}
```
- `coluna`: de `0` a `3` (4 colunas no total).
- `linha`: `0` (topo) ou `1` (base).
- `marcador_x/marcador_y`: coordenadas normalizadas (0.0 a 1.0) dos círculos numerados sobre a imagem.

---

## 3. OnePage Sumarização (`modelos/OnePage-Sumarizacao/onepage-lg.tex`)

O OnePage condensa um projeto ou iniciativa em 3 colunas executivas: **Antes**, **Depois** e **Resultado**.

### Coluna 1 — Antes (Contexto e Problemas):
```latex
\tituloantes{Contexto / Problema}
\textoantes{Descrição sucinta do cenário anterior.}
\ponto[altura_icone]{icone.png}{Descrição do ponto de dor.}
\alerta{icone_alerta.png}{Mensagem de risco ou gargalo principal.}
\fluxo{De 1,5h a 2h/dia}{até 504 h/ano}
```

### Coluna 2 — Depois (Melhoria Proposta):
```latex
\titulodepois{Melhoria Esperada}
\textodepois{Como o sistema ou solução resolve o problema.}
\melhoria{Benefício chave 1.}
\melhoria{Benefício chave 2.}
\area{90}{Módulo 1}      % Distribui os raios do diagrama central
\area{45}{Módulo 2}
\ilustracoes{img1.png}{img2.png}{img3.png}
```

### Coluna 3 — Resultado (Impacto e Métricas):
```latex
\tituloresultado{Efeito da Melhoria}
\efeito{Impacto positivo gerado 1.}
\efeito{Impacto positivo gerado 2.}
\graficobarra{Antes}{Manual}{1.04}      % Gráfico comparativo de barras
\graficobarra{Depois}{Integrado}{2.42}
\resultado{Meta M3}{Módulo validado}
```

---

## 4. Status Report de Sprint (`modelos/Status-Report/status-report-equipe3.tex`)

Página de 32 × 18 cm (proporção 16:9 de tela cheia). Cartões organizados com `equal height group` do `tcolorbox`.

### O que preencher toda semana:
- **Sprint Progress:** Percentual do sprint com semana (`W32`) e datas.
- **Main Tasks:** 6 tarefas principais com barra de progresso `\barra{progresso}{cor}`.
- **Impedimentos:** O que bloqueia as entregas e ferramentas de apoio.
- **Indicadores:** Métricas com valor medido, fonte e data.
- **Cronograma / Marcos:** Linha do tempo com M1..Mn.
- **Retratos da Equipe:** Imagens circulares em `img/circ_XX.png` (chamadas pelas iniciais dos membros).

---

## 5. OnePage de Evidências (`modelos/OnePage-Evidencias/onepage-evidencias-equipe3.tex`)

Folha única em **A3 Paisagem** com cartões temáticos de evidências geradas durante o sprint.

### Blocos de Evidência:
```latex
\begin{card}{Título do Bloco}
  Texto e lista de entregas.
  \evimg{arquivo.png}{\linewidth}    % Imagem emoldurada na largura do cartão
  \evphoto{foto.jpg}{3.2cm}          % Foto com altura máxima proporcional
\end{card}
```

---

## 6. OnePage Corporativo LGE (`modelos/OnePage-Corporativo-LGE/onepage-lg.tex`)

O template corporativo padrão em inglês da LGE ("AI Deep Dive" / "AI Core"), fiel ao slide `Layout de Report - One Page.pptx` original. Possui a mesma API semântica do `OnePage-Sumarizacao`, mas com termos e indicadores em inglês.

---

## 7. Guia do Usuário do Hanaro (`modelos/Guia-Usuario-Hanaro/guia-usuario.tex`)

Guia do Usuário do Hanaro no modelo da Apostila (classe `book`, mesmo `axacademy-guia.sty`). A fase 1 tem duas partes, cada uma com um capítulo em `caps/`:

- **Parte I, Arquitetura** (`caps/cap01.tex`): peças do sistema, caminho do dado do GERP ao Dashboard, perfis, implantação, registro e falhas comuns, com 3 diagramas TikZ e caixas "Para TI".
- **Parte II, Inteligência Artificial** (`caps/cap02.tex`): assistente de pré-análise, Consulta, Memória, Desempenho e tradução, com fluxo BPMN e 6 passos (`\passo`).

Comando: `uv run build guia-usuario` (2 passadas) gera `dist/Guia-Usuario-Hanaro/guia-usuario-hanaro.pdf`.

Pontos de atenção:

- As telas de `img/` são esquemas provisórios (rodapé "CAPTURA PENDENTE"). Troque pelas capturas reais, na mesma resolução (1440×900), e recalibre os marcadores `x/y` de cada `\passo`.
- Os diagramas usam os estilos `arq ...` definidos no início de `caps/cap01.tex`, além dos estilos `bpmn ...` do `.sty`.
- O `.sty` desta pasta é uma cópia da Apostila com um ajuste: `\endgraf` no lugar de `\par` após o filete do `\titleformat{\part}`, para o mini-sumário da parte compilar também em TeX Live 2023.
- As próximas partes (Dashboard, Base de Scrap, Relatórios etc.) entram como novos `\part` e capítulos.
