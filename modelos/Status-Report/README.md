# Status Report (One Page) — modelo

**A versão canônica é a das equipes, não o esqueleto genérico.** O modelo
original (`status-report-onepage`, de 05/08) nunca recebeu as correções que
saíram do uso; as quatro entregas do Sprint 00 · W32, feitas entre 12 e 13/08,
receberam. O que está aqui é a mais recente delas.

Base: **Equipe 3 (Hanaro)** — `status-report-equipe3.tex`. Os outros três estão
em `exemplos/`. Mesma escolha do Kick-off, cuja base também é o deck da Equipe 3.

## Compilar

```
lualatex status-report-equipe3.tex     # duas vezes
lualatex status-report-equipe3.tex
```

**Duas passadas, sempre.** É uma página só, mas os cartões usam
`equal height group` do tcolorbox: a altura máxima de cada grupo é gravada no
`.aux` e só é aplicada na passada seguinte. Com uma passada, cada cartão sai com
a altura do próprio conteúdo e a linha fica desalinhada — foi exatamente esse o
defeito nas primeiras versões, e ele não dá erro nenhum no log.

Três grupos são equalizados: `hdr` (time e duração, no cabeçalho), `row1`
(Sprint Progress, Main Tasks e Impedimentos) e `kpi` (os três indicadores).
Ao acrescentar um cartão a uma dessas linhas, passe o mesmo
`equal height group` — senão ele fica com a própria altura e quebra a fileira.

Página de 32 × 18 cm, deitada: é feita para caber inteira na tela, não para
imprimir em A4.

## Pastas

```
status-report-equipe3.tex   base — troque o conteúdo por cima dela
fonts/                      LG EI (11 MB) — uma cópia só, compartilhada
img/                        logo, robô e os retratos da equipe
exemplos/Equipe 1|2|4/      as outras três entregas, cada uma com seus retratos
```

Os exemplos apontam para `../../fonts` e `../../img`, então **compile-os de
dentro da própria pasta** e mantenha a árvore inteira junta ao subir para o
Prism. Mover uma pasta de exemplo para fora quebra o caminho da fonte.

## Retratos

Um PNG circular por pessoa em `img/`, no padrão `circ_XX.png`, onde `XX` são as
iniciais. O `.tex` chama pelas iniciais — trocar a foto é sobrescrever o arquivo,
sem mexer no código. Os recortes vêm do gerador em
`../04-KickOff/ferramentas/gerar-cards.py`.

## O que preencher

| Bloco | Regra |
|---|---|
| Sprint Progress | percentual único do sprint, com a semana e a janela de datas |
| Main Tasks | 6 tarefas, cada uma com percentual e uma linha do que é o artefato |
| Impedimentos | o que **bloqueia**, não o que incomoda — e as ferramentas em uso |
| Indicadores | número medido, com a fonte e a data; se ainda não há, escreva *A estimar* |
| Cronograma | os marcos M1..Mn com data, e o que cada um entrega |
| Descrição | um parágrafo que explique o projeto a quem nunca ouviu falar dele |

Indicador sem data e sem fonte é o erro mais comum aqui: seis semanas depois
ninguém sabe se o número era medido ou chutado.
