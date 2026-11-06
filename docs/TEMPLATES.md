# Guia de Edição e Customização dos Templates

Este documento explica como customizar o conteúdo de cada um dos templates disponíveis no repositório.

---

## 1. Apostila (`Apostila/guia-rapido.tex`)

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

## 2. Flyer A3 (`Flyer/guia-flyer.tex`)

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

## 3. OnePage (`One-page/onepage-lg.tex`)

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

