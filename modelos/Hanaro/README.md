# Guia do Usuário Hanaro

O guia segue a estrutura do Guia Rápido de Uso (`modelos/Apostila/guia-rapido.tex`).
Os capítulos 1 e 2 preservam a versão do guia rápido usada como base na adaptação
(commit `20bda03`), com seus textos, diagramas, imagens, tabelas e oito passos originais.
A Apostila do remoto recebeu ampliações posteriores; elas não substituem esses capítulos
preservados. Este modelo reúne o guia operacional completo, enquanto
`modelos/Guia-Usuario-Hanaro/` contém a documentação técnica de arquitetura e IA.

## Compilar

Na raiz do repositório:

```powershell
uv run build check
uv run build hanaro
```

Saída: `dist/Hanaro/guia-usuario-hanaro.pdf`. A compilação usa LuaLaTeX, três passadas
e as fontes compartilhadas em `modelos/fonts/`. PDFs gerados ficam fora do Git.

## Estrutura e edição

`main.tex` contém os dados editoriais e a ordem dos capítulos.

| Parte | Capítulos em `caps/` |
| --- | --- |
| I — Visão Geral | `cap01.tex`: Antes de Começar (original preservado) |
| II — Passo a Passo | `cap02.tex`: Uso Básico do Hanaro (original preservado) |
| III — Consulta Detalhada | `cap03.tex`: acesso, perfis e conta; `cap04.tex`: configurações; `cap05.tex`: execuções e GERP; `cap06.tex`: Base de Scrap; `cap07.tex`: Dashboard; `cap08.tex`: relatórios e tarefas |
| IV — Administração e Recursos Complementares | `cap09.tex`: alertas e Teams; `cap10.tex`: suporte, usuários e uso; `cap11.tex`: Assistente de IA e Consulta |

Os passos 1 a 8 continuam sendo os do guia rápido. A consulta detalhada contém
somente procedimentos complementares, numerados de 9 a 64. As rotinas de login,
execuções, envio GERP, consulta básica da base e do Dashboard, aplicação em lote e
Modo TV remetem aos passos originais. As regras e mensagens adicionais permanecem
nas seções correspondentes, sem repetir os procedimentos.

As oito continuações foram unidas aos respectivos passos. O cadastro de modelo
favorito, a seleção de análises, o preenchimento de responsável/prazo/economia e o
cadastro de destino no Teams também foram consolidados. Cada passo tem um único
selo, título e imagem. Os capítulos 1 e 2 permanecem idênticos aos originais.

As capturas originais ficam em `img/`; as capturas da consulta detalhada ficam em
`img/completo/`. Essa separação preserva inclusive a imagem de login usada no guia
rápido. O estilo institucional é `axacademy-guia.sty`. Os ajustes de blocos extensos
em `guia-completo.sty` são carregados somente depois do capítulo 2.

O Markdown em `conteudo/` é referência de conteúdo e não atualiza os capítulos
LaTeX automaticamente. Preserve os capítulos 1 e 2 ao fazer novas ampliações.

## Marcadores e recortes — versão 1.4

Nos capítulos 3 a 11, cada número da imagem corresponde ao mesmo número da lista
de instruções. As chamadas usam quatro coordenadas normalizadas por ponto:
`alvo-x/alvo-y/rótulo-x/rótulo-y`, com origem no canto superior esquerdo do recorte.
As linhas de chamada mantêm os números afastados de controles muito próximos.
Os recortes são vetoriais no LaTeX: os arquivos de captura originais permanecem íntegros.

O passo 37 documenta a criação rápida; o 38 documenta a validação pelo gestor.
O passo 42 apresenta a consulta de resultados, conforme o estado mostrado na captura.
Campos fora das imagens são identificados nas orientações de rolagem, sem pontos
colocados sobre áreas que não aparecem. A revisão usa somente as imagens disponíveis,
incluindo os recortes parciais das metas, do KPI e das seções inferiores da análise.

## Versão 1.5

Revisão editorial e visual com 59 passos únicos, 51 capturas complementares e
265 marcadores nesses capítulos. A revisão esclarece os indicadores financeiros,
os campos opcionais e o caráter informativo da prontidão do relatório.
O PDF de referência tem 83 páginas. Compile com `uv run build hanaro`.


## Consolidação — versão 1.6

O manual incorpora as orientações operacionais de Configurações e do Assistente
da Documentação Técnica existente (`de705b5`), com créditos a Messyas e André
Filipe Aloise (`aaloise`, PR #1). Há 64 passos ilustrados: 59 capturas reais e
cinco esquemas do Assistente. A tradução amplia o passo 45, sem criar outra rotina
de exportação. O capítulo 11 reúne o Assistente, a Consulta, a Memória e o Desempenho.
O PDF desta edição tem 93 páginas e é gerado com `uv run build hanaro`.

A referência funcional escolhida é a versão das capturas e do manual existente,
com IA conforme disponibilidade no ambiente. A cotação é editável somente nas
versões que exibem o lápis. Não se presume que o código local de outra branch
exponha os mesmos menus. O cadastro de Configurações atende Analistas e Gestores;
Admin e a permissão de superusuário são descritos separadamente das rotinas da planta.

Os PNGs de IA são esquemas reaproveitados sem edição dos arquivos. O recorte LaTeX
retira o rodapé provisório e as legendas os identificam explicitamente como
ilustrações, sem apresentá-los como capturas reais.
