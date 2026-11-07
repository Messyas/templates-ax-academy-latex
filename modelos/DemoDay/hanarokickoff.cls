%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hanarokickoff.cls -- Kick-off do projeto Hanaro (Equipe 3, AX Academy)
%%
%% Derivada de dxikickoff.cls (porte do "Kickoff template.pptx"), com a marca
%% AX Academy no lugar da DXi e a paleta alinhada ao Design System Hanaro.
%%
%% Palco: 33,87 cm x 19,05 cm = 960 pt x 540 pt = 16:9
%% Motor: LuaLaTeX (usa fontspec + as TTF de assets/fonts/)
%% Compilar 2x (o posicionamento absoluto usa "remember picture").
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hanarokickoff}[2026/08/15 v1.0 Hanaro -- Kick-off Equipe 3 16:9]

%% ------------------------------------------------------------------ opcoes --
\newif\ifdxi@rodape \dxi@rodapefalse   % numero de slide no rodape
\newif\ifdxi@grade  \dxi@gradefalse    % grade de diagramacao (debug de layout)
\DeclareOption{rodape}{\dxi@rodapetrue}
\DeclareOption{grade}{\dxi@gradetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\LoadClass[aspectratio=169,t,10pt]{beamer}

%% ------------------------------------------------ palco 33,87 x 19,05 cm ----
\geometry{papersize={33.87cm,19.05cm}}
\newcommand*{\dxiW}{33.87}
\newcommand*{\dxiH}{19.05}

%% ---------------------------------------------------------------- pacotes ---
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\usetikzlibrary{calc,positioning}
\RequirePackage{ragged2e}
%% Hifenizacao em portugues do Brasil. Para outro idioma, passe a opcao de
%% lingua ao documento (ex.: \documentclass[english]{dxikickoff}).
\RequirePackage[brazil]{babel}
\frenchspacing

%% Compila tanto da raiz do modelo quanto de uma subpasta (ex.: build/).
\graphicspath{{assets/}{../assets/}{./}}

%% ------------------------------------------------------------------ cores ---
%% Amostradas do PPTX e dos PNGs originais.
\definecolor{dxinavy}   {HTML}{0F172A}  % texto/titulo escuro
\definecolor{dxinavyfig}{HTML}{1F232E}  % octogono escuro (asset)
\definecolor{dxired}    {HTML}{E7194A}  % Crimson Red -- primaria do tema escuro
\definecolor{lgred}     {HTML}{A50034}  % LG Heritage Red -- primaria do tema claro
\definecolor{hanaroverde}{HTML}{059669} % --app-success
\definecolor{hanaroamb} {HTML}{F59E0B}  % --app-warning
\definecolor{hanaroazul}{HTML}{2563EB}  % --app-blue
\definecolor{dxired2}   {HTML}{E7194B}  % vermelho chapado alternativo
\definecolor{dxiredline}{HTML}{C41230}  % vermelho do octogono vazado
\definecolor{dxigelo}   {HTML}{E8ECF4}  % texto claro sobre fundo escuro
\definecolor{dxicinza}  {HTML}{CAD1D3}  % octogono cinza (asset)
\definecolor{dxigrafite}{HTML}{878787}  % "eyebrow" cinza
\definecolor{dxivinho}  {HTML}{520E1A}  % nome dos membros do time
\definecolor{dxiteal}   {HTML}{2DD4BF}  % acento do cronograma
\definecolor{dxitealesc}{HTML}{134F5C}  % contorno/rotulo do cronograma

%% ----------------------------------------------------------------- fontes ---
%% Montserrat -> titulos, rotulos, nomes    (Google Fonts, OFL)
%% Urbanist   -> corpo de texto e capa      (Google Fonts, OFL)
\IfFileExists{../fonts/Montserrat-Regular.ttf}
  {\def\dxi@fp{../fonts/}}
  {\IfFileExists{assets/fonts/Montserrat-Regular.ttf}
     {\def\dxi@fp{assets/fonts/}}
     {\IfFileExists{../assets/fonts/Montserrat-Regular.ttf}
        {\def\dxi@fp{../assets/fonts/}}
        {\def\dxi@fp{}}}}

\ifdefempty{\dxi@fp}{%
  \ClassWarningNoLine{dxikickoff}{Fontes nao encontradas em assets/fonts/;
    usando fontes do sistema (o visual pode divergir do PPTX)}%
  \IfFontExistsTF{Montserrat}%
    {\setsansfont{Montserrat}\newfontfamily\dximont{Montserrat}}%
    {\let\dximont\sffamily}%
  \IfFontExistsTF{Urbanist}%
    {\newfontfamily\dxiurb{Urbanist}\newfontfamily\dxiurblight{Urbanist Light}}%
    {\let\dxiurb\sffamily \let\dxiurblight\sffamily}%
}{%
  \setsansfont{Montserrat}[Ligatures=TeX,Path=\dxi@fp,Extension=.ttf,
    UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
  \newfontfamily\dximont{Montserrat}[Ligatures=TeX,Path=\dxi@fp,Extension=.ttf,
    UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
  \newfontfamily\dximontsb{Montserrat}[Ligatures=TeX,Path=\dxi@fp,Extension=.ttf,
    UprightFont=*-SemiBold,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
  \newfontfamily\dxiurb{Urbanist}[Ligatures=TeX,Path=\dxi@fp,Extension=.ttf,
    UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
  \newfontfamily\dxiurblight{Urbanist}[Ligatures=TeX,Path=\dxi@fp,Extension=.ttf,
    UprightFont=*-Light,BoldFont=*-SemiBold,
    ItalicFont=*-LightItalic,BoldItalicFont=*-Italic]%
}
\providecommand{\dximontsb}{\dximont}

%% Hangul (하나로) -- Montserrat/Urbanist nao tem os glifos coreanos.
\IfFontExistsTF{Malgun Gothic}
  {\newfontfamily\dxihangul{Malgun Gothic}[BoldFont={Malgun Gothic Bold}]}
  {\let\dxihangul\dxiurb
   \ClassWarningNoLine{hanarokickoff}{Fonte coreana (Malgun Gothic) nao
     encontrada; o texto em hangul pode nao renderizar}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ESTILOS TIPOGRAFICOS  (tamanhos em pt, iguais aos do PPTX)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\dxiEyebrow}     {\dximont\fontsize{16}{21}\selectfont}
\newcommand{\dxiTituloCapa}  {\dxiurb\bfseries\fontsize{70}{76}\selectfont}
\newcommand{\dxiTituloGrande}{\dximont\bfseries\fontsize{60}{66}\selectfont}
\newcommand{\dxiTituloMedio} {\dximont\bfseries\fontsize{46}{52}\selectfont}
\newcommand{\dxiTituloSecao} {\dximont\bfseries\fontsize{30}{36}\selectfont}
\newcommand{\dxiSubtitulo}   {\dxiurblight\fontsize{20}{28}\selectfont}
\newcommand{\dxiCorpo}       {\dxiurb\fontsize{16}{23}\selectfont}
\newcommand{\dxiCorpoP}      {\dxiurb\fontsize{14}{20}\selectfont}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRIMITIVAS DE DIAGRAMACAO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tela absoluta: origem no canto superior esquerdo, 1 unidade = 1 cm,
%% eixo Y crescendo PARA BAIXO -- exatamente como as coordenadas do PPTX.
\newenvironment{dxicanvas}{%
  \begin{tikzpicture}[remember picture,overlay,
      shift={(current page.north west)},x=1cm,y=-1cm,
      inner sep=0pt,outer sep=0pt,line width=0.4pt]%
  \ifdxi@grade
    \draw[dxicinza,line width=0.15pt,step=1] (0,0) grid (\dxiW,\dxiH);
    \draw[dxired!35,line width=0.4pt]
      (2.25,0) -- (2.25,\dxiH) (\dxiW-2.25,0) -- (\dxiW-2.25,\dxiH);
  \fi
}{\end{tikzpicture}}

%% \dxitxt[<opcoes tikz>]{<x>}{<y>}{<largura cm>}{<conteudo>}
%% NOTA: use sempre "align=flush left/center" (ragged2e) nos nos com
%% "text width". O "align=left" do TikZ zera o \spaceskip e o espaco entre
%% palavras colapsa -- visivel sobretudo em corpos grandes (titulos).
\newcommand{\dxitxt}[5][]{%
  \node[anchor=north west,text width=#4 cm,align=flush left,#1] at ({#2},{#3}) {#5};}

%% \dxioct{<arquivo em assets/formas>}{<x>}{<y>}{<largura cm>}
\newcommand{\dxioct}[4]{%
  \node[anchor=north west] at ({#2},{#3}) {\includegraphics[width=#4 cm]{formas/#1}};}

%% Grade decorativa de octogonos (duas colunas, lateral direita).
%% \dxigradeoct{<x col.A>}{<y inicial>}{<vazado col.A>}{<vazado col.B>}
\newcommand{\dxigradeoct}[4]{%
  \dxioct{oct-navy}    {#1}{#2}       {3.37}%
  \dxioct{#3}          {#1}{#2+4.14}  {3.40}%
  \dxioct{oct-cinza}   {#1}{#2+8.28}  {3.37}%
  \dxioct{oct-navy}    {#1}{#2+12.42} {3.37}%
  \dxioct{#3}          {#1}{#2+16.56} {3.40}%
  \dxioct{oct-vermelho}{#1+3.98}{#2+1.40} {3.37}%
  \dxioct{oct-cinza}   {#1+3.98}{#2+5.54} {3.37}%
  \dxioct{#4}          {#1+3.98}{#2+9.68} {3.40}%
  \dxioct{oct-vermelho}{#1+3.98}{#2+13.82}{3.37}%
  \dxioct{oct-cinza}   {#1+3.98}{#2+17.96}{3.37}%
}

%% Selo: octogono escuro + logo AX Academy branca centralizada.
%% Octogono 3,37 x 3,17 cm; logo 1,80 x 1,32 cm -> folga 0,785 e 0,925.
%% \dxiselo{<x>}{<y>}
\newcommand{\dxiselo}[2]{%
  \dxioct{oct-navy}{#1}{#2}{3.37}%
  \node[anchor=center] at ({#1+1.685},{#2+1.585})
    {\includegraphics[width=1.80cm]{logo/ax-logo-branco}};}

%% Selo: octogono escuro + marca do IFAM centralizada. \dxiselifam{<x>}{<y>}
\newcommand{\dxiselifam}[2]{%
  \dxioct{oct-navy}{#1}{#2}{3.37}%
  %% o octogono tem chanfro no canto superior esquerdo e no inferior direito,
  %% entao o centro optico fica um pouco abaixo e a direita do geometrico
  \node[anchor=center] at ({#1+1.75},{#2+1.68})
    {\includegraphics[width=2.34cm]{logo/ifam-vertical-branco}};}

%% Selo do canto superior direito com a paginacao: numero atual em cima a
%% esquerda, total embaixo a direita, separados por uma barra diagonal branca.
%% \dxinumslide{<x>}{<y>}{<largura cm>}
\newcommand{\dxinumslide}[3]{%
  \dxioct{oct-vermelho}{#1}{#2}{#3}%
  \begin{scope}
    \pgfmathsetmacro{\dxinsH}{#3*0.9407}%
    \draw[white,line width={#3*0.045 cm}]
      ({#1+#3*0.17},{#2+\dxinsH*0.83}) -- ({#1+#3*0.83},{#2+\dxinsH*0.17});
    \node[text=white,inner sep=0pt,anchor=center,
          font=\dximont\bfseries\fontsize{14}{14}\selectfont]
      at ({#1+#3*0.30},{#2+\dxinsH*0.31}) {\insertframenumber};
    \node[text=white,inner sep=0pt,anchor=center,
          font=\dximont\bfseries\fontsize{14}{14}\selectfont]
      at ({#1+#3*0.70},{#2+\dxinsH*0.70}) {\inserttotalframenumber};
  \end{scope}}

%% Moldura de celular (estilo iPhone) em volta de um print de tela.
%% \dxicelular{<altura da tela em cm>}{<arquivo>}
\newcommand{\dxicelular}[2]{%
  \begingroup
  \pgfmathsetmacro{\dxiscrh}{#1}%
  \pgfmathsetmacro{\dxiscrw}{#1*0.4621}%      1170/2532 (iPhone 17)
  \pgfmathsetmacro{\dxibez}{#1*0.0115}%       moldura interna
  \pgfmathsetmacro{\dxirim}{#1*0.0230}%       aro externo
  \begin{tikzpicture}[x=1cm,y=1cm,inner sep=0pt,outer sep=0pt]
    %% aro externo (titanio) e corpo
    \fill[dxinavy!55,rounded corners={\dxiscrw*0.135 cm}]
      (-\dxirim,-\dxirim) rectangle (\dxiscrw+\dxirim,\dxiscrh+\dxirim);
    \fill[black,rounded corners={\dxiscrw*0.125 cm}]
      (-\dxibez,-\dxibez) rectangle (\dxiscrw+\dxibez,\dxiscrh+\dxibez);
    %% botoes laterais
    \fill[dxinavy!55,rounded corners=0.03cm]
      (-\dxirim,\dxiscrh*0.76) rectangle (-\dxirim*0.2,\dxiscrh*0.84);
    \fill[dxinavy!55,rounded corners=0.03cm]
      (-\dxirim,\dxiscrh*0.62) rectangle (-\dxirim*0.2,\dxiscrh*0.70);
    \fill[dxinavy!55,rounded corners=0.03cm]
      (\dxiscrw+\dxirim*0.2,\dxiscrh*0.63) rectangle (\dxiscrw+\dxirim,\dxiscrh*0.77);
    %% tela
    \begin{scope}
      \clip[rounded corners={\dxiscrw*0.105 cm}]
        (0,0) rectangle (\dxiscrw,\dxiscrh);
      \node[anchor=south west] at (0,0)
        {\includegraphics[width=\dxiscrw cm,height=\dxiscrh cm]{#2}};
    \end{scope}
    %% dynamic island
    \fill[black,rounded corners={\dxiscrh*0.011 cm}]
      (\dxiscrw*0.335,\dxiscrh*0.955) rectangle (\dxiscrw*0.665,\dxiscrh*0.983);
  \end{tikzpicture}%
  \endgroup}

%% Marca d'agua institucional no rodape direito: AX Academy | IFAM.
%% Usada nos slides de conteudo. \dximarcadagua
\newcommand{\dximarcadagua}{%
  \begin{scope}[opacity=0.28]
    \node[anchor=south east] at (32.35,18.10)
      {\includegraphics[height=0.58cm]{logo/ax-logo-color}%
       \hspace{0.32cm}\raisebox{0.05cm}{\color{dxinavy}\rule{0.6pt}{0.46cm}}%
       \hspace{0.32cm}\includegraphics[height=0.58cm]{logo/ifam-horz}};
  \end{scope}}

%% Barra vermelha vertical do titulo de secao. \dxibarra{<x>}{<y>}{<altura>}
\newcommand{\dxibarra}[3]{\fill[dxired] ({#1},{#2}) rectangle ++(0.20,#3);}

%% Regua vermelha horizontal (divisores). \dxiregua{<x>}{<y>}
\newcommand{\dxiregua}[2]{\fill[dxired] ({#1},{#2}) rectangle ++(2.65,0.16);}

%% "Check" duplo -- icone do cronograma e marcador de itemize.
\newcommand{\dxicheck}[1]{%
  \raisebox{-0.12ex}{\begin{tikzpicture}[baseline=0pt,x=1ex,y=1ex]
    \draw[#1,line width=0.34ex,line cap=round,line join=round]
      (0,0.62) -- (0.50,0.12) -- (1.42,1.30);
    \draw[#1,line width=0.34ex,line cap=round,line join=round]
      (0.62,0.62) -- (1.12,0.12) -- (2.04,1.30);
  \end{tikzpicture}}}

%% Retangulo com canto superior direito chanfrado ("snip1Rect" do PPTX).
%% \dxi@snip{<x>}{<y>}{<larg>}{<alt>}{<chanfro>}
\newcommand{\dxi@snip}[5]{%
  ({#1},{#2}) -- ({#1+#3-#5},{#2}) -- ({#1+#3},{#2+#5})
  -- ({#1+#3},{#2+#4}) -- ({#1},{#2+#4}) -- cycle}

%% --------------------------------------------------------- beamer enxuto ----
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{headline}{}
\setbeamercolor{background canvas}{bg=white}
\setbeamercolor{normal text}{fg=dxinavy}
\usebeamercolor[fg]{normal text}
\setbeamersize{text margin left=2.45cm,text margin right=2.45cm}
\setbeamertemplate{itemize item}{\dxicheck{dxired}}
\setbeamertemplate{itemize subitem}{%
  \raisebox{0.2ex}{\scriptsize\color{dxired}$\blacksquare$}}
\setbeamertemplate{itemize subsubitem}{%
  \raisebox{0.2ex}{\tiny\color{dxicinza}$\blacksquare$}}
\setbeamercolor{itemize item}{fg=dxired}
\setbeamercolor{itemize subitem}{fg=dxired}
\setlength{\leftmargini}{1.05cm}
\setlength{\leftmarginii}{0.85cm}

\newcommand*{\dxi@projeto}{}
\newcommand{\dxiprojeto}[1]{\renewcommand*{\dxi@projeto}{#1}}

%% linha de assinatura da capa
\newcommand*{\dxi@powered}{\textit{Powered by} \textbf{AX Academy}
  $\cdot$ Digital Transformation}
\newcommand{\dxipowered}[1]{\renewcommand*{\dxi@powered}{#1}}

%% O numero do slide vive no selo do canto superior direito; o rodape fica
%% so com o nome do projeto, a esquerda, para nao brigar com a marca d'agua.
\ifdxi@rodape
  \setbeamertemplate{footline}{%
    \hbox{}\vskip-1.25cm\hspace*{2.45cm}%
    {\dximont\fontsize{9}{11}\selectfont\color{dxigrafite}\dxi@projeto}\hfill
    \hspace*{2.45cm}\vskip0.60cm}
\else
  \setbeamertemplate{footline}{}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDE 1 -- CAPA
%% \dxicapa[<imagem de fundo>]{<parceiro>}{<titulo>}{<subtitulo>}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\dxicapa}[4][fundo/capa-fundo]{%
\begin{frame}[plain]
\begin{dxicanvas}
  \fill[black] (0,0) rectangle (\dxiW,\dxiH);
  \node[anchor=north west] at (0,0)
    {\includegraphics[width=\dxiW cm,height=\dxiH cm]{#1}};
  \dxigradeoct{25.88}{2.26}{oct-linha-vermelha}{oct-linha-vermelha}
  \dxiselo{25.88}{2.26}
  %% mesma casa do 4o octogono escuro da grade (y0 + 12,42), senao o selo
  %% desalinha e parece um retangulo maior
  \dxiselifam{25.88}{14.68}
  \dxitxt{2.25}{1.74}{17.0}{\dxiEyebrow\color{dxigelo}#2}
  \dxitxt{2.25}{2.70}{17.0}{\dxiEyebrow\color{dxigelo}\dxi@powered}
  \node[anchor=south west,text width=21.5cm,align=flush left] at (2.25,11.55)
    {\dxiTituloCapa\color{white}#3};
  \dxitxt{2.25}{12.45}{22.5}{\dxiSubtitulo\color{dxigelo}#4}
\end{dxicanvas}
\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDE 2 -- SEU TIME (ate 6 pessoas)
%%
%%   \dxiequipe[<titulo>]{%
%%     \dximembro[<foto>]{<cargo>}{<nome>}
%%     ... ate 6 ...
%%   }
%%
%% Sem o argumento opcional da foto entra um marcador de posicao.
%% Fotos: recorte vertical (retrato); a arte corta pelo topo do cartao.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{dxi@nmemb}
\newcommand{\dximembro}[3][]{%
  \ifnum\value{dxi@nmemb}<6\relax
    \stepcounter{dxi@nmemb}%
    \expandafter\gdef\csname dxi@m@foto@\the\value{dxi@nmemb}\endcsname{#1}%
    \expandafter\gdef\csname dxi@m@cargo@\the\value{dxi@nmemb}\endcsname{#2}%
    \expandafter\gdef\csname dxi@m@nome@\the\value{dxi@nmemb}\endcsname{#3}%
  \else
    \ClassWarning{dxikickoff}{"Seu time" comporta no maximo 6 pessoas;
      "#3" foi ignorado}%
  \fi}

%% \dxi@cartao{<x>}{<y>}{<larg>}{<alt>}{<indice>}
%% A faixa de cargo/nome ATRAVESSA o cartao (mais larga que ele), como no
%% PPTX original: no deck da DXi a caixa de texto tinha 4,5 cm sobre um cartao
%% de 3,52 cm, comecando a 70% da altura.
\newcommand{\dxi@cartao}[5]{%
  \pgfmathsetmacro{\dxisn}{0.20*#3}%
  \pgfmathsetmacro{\dxibw}{1.28*#3}%          largura da faixa
  \def\dxibh{1.26}%                           altura fixa: casa com as 2 linhas
  \pgfmathsetmacro{\dxibx}{#1+#3/2-\dxibw/2}% canto esquerdo da faixa
  %  A faixa e' ancorada pela BASE do cartao, nao por uma fracao da altura:
  %  com topo em 0,782*#4 e altura fixa de 1,26 cm sobrava cartao por baixo
  %  dela e a foto reaparecia como uma tira sob o nome, nos tres ramos.
  \pgfmathsetmacro{\dxiby}{#2+#4-\dxibh}%   topo da faixa
  \fill[dxired] \dxi@snip{#1}{#2}{#3}{#4}{\dxisn};
  \begin{scope}
    \clip \dxi@snip{#1}{#2}{#3}{#4}{\dxisn};
    \ifcsempty{dxi@m@foto@#5}{%
      \fill[white,opacity=0.32] ({#1+#3/2},{#2+#4*0.40}) circle ({#3*0.21});
      \fill[white,opacity=0.32] ({#1+#3/2},{#2+#4*0.98})
        ellipse ({#3*0.40} and {#4*0.40});
      \node[anchor=north,align=flush center] at ({#1+#3/2},{#2+#4*0.06})
        {\dximont\fontsize{8}{10}\selectfont\color{white}FOTO};
    }{%
      \node[anchor=south] at ({#1+#3/2},{#2+#4})
        {\includegraphics[height=#4 cm]{\csname dxi@m@foto@#5\endcsname}};
    }%
  \end{scope}
  %% faixa branca por cima da foto, transbordando o cartao dos dois lados
  \fill[white] (\dxibx,\dxiby) rectangle ++(\dxibw,\dxibh);
  \node[anchor=center,align=flush center,text width=\dxibw cm]
    at ({#1+#3/2},{\dxiby+\dxibh/2})
    {{\dximont\bfseries\fontsize{12}{15}\selectfont\color{dxired}%
      \csname dxi@m@cargo@#5\endcsname}\\[0.18em]
     {\dximont\fontsize{11}{14}\selectfont\color{dxivinho}%
      \csname dxi@m@nome@#5\endcsname}};}

\newcommand{\dxiequipe}[2][Seu time]{%
\setcounter{dxi@nmemb}{0}%
#2%
\begin{frame}[plain]
\begin{dxicanvas}
  \dxioct{oct-linha-vermelha}{0.79}{-1.18}{3.42}
  \dxioct{oct-vermelho}      {0.79}{2.21} {1.91}
  \dxioct{oct-vermelho}      {30.91}{15.49}{2.20}
  \dxioct{oct-vermelho}      {29.80}{17.36}{0.76}
  \dxitxt{5.89}{1.10}{21.0}{\dximont\fontsize{36}{42}\selectfont\color{dxired}#1}
  \ifnum\value{dxi@nmemb}>0\relax
    \pgfmathsetmacro{\dxin}{\thedxi@nmemb}%
    %% com o cargo/nome DENTRO do cartao, sobra altura: cartoes maiores
    %% RAMO DE 4 (acrescentado para o Demo Day, onde o P.O. da DXi nao entra e
    %% as equipes ficam com quatro pessoas). Sem ele o \dxincol=3 joga o quarto
    %% cartao sozinho numa segunda fileira. Quatro cabem numa linha so:
    %%   4 x 5,90 + 3 x 2,00 = 29,60 cm, dentro dos 33,87 do canvas.
    %% A proporcao do cartao (1,335) e' a mesma do ramo de tres.
    \ifnum\value{dxi@nmemb}=4\relax
      \def\dxincol{4}\def\dxicw{5.90}\def\dxich{7.88}\def\dxigap{2.00}%
      \def\dxiya{5.50}\def\dxiyb{5.50}%
    \else
    \ifnum\value{dxi@nmemb}>3\relax
      \def\dxincol{3}\def\dxicw{5.32}\def\dxich{7.10}\def\dxigap{2.40}%
      \def\dxiya{3.30}\def\dxiyb{11.05}%
    \else
      \edef\dxincol{\thedxi@nmemb}%
      \def\dxicw{6.60}\def\dxich{8.81}\def\dxigap{2.60}%
      \def\dxiya{5.00}\def\dxiyb{5.00}%
    \fi\fi
    \foreach \dxik in {1,...,\thedxi@nmemb}{%
      \pgfmathsetmacro{\dxirow}{int(ceil(\dxik/\dxincol))}%
      \pgfmathsetmacro{\dxicol}{\dxik-(\dxirow-1)*\dxincol}%
      \pgfmathsetmacro{\dxircnt}{(\dxirow==1) ? min(\dxin,\dxincol)
                                             : (\dxin-\dxincol)}%
      \pgfmathsetmacro{\dxix}{(\dxiW-(\dxircnt*\dxicw+(\dxircnt-1)*\dxigap))/2
                              +(\dxicol-1)*(\dxicw+\dxigap)}%
      \pgfmathsetmacro{\dxiy}{(\dxirow==1) ? \dxiya : \dxiyb}%
      \dxi@cartao{\dxix}{\dxiy}{\dxicw}{\dxich}{\dxik}%
    }%
  \fi
\end{dxicanvas}
\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDES 3 e 4 -- CONTEUDO COM TITULO
%%   \begin{dxiconteudo}[semdeco]{<TITULO>} ...corpo LaTeX normal... \end{...}
%% O corpo aceita itemize, tabular, tikz, includegraphics, \pause etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{dxiconteudo}[2][deco]{%
  \begin{frame}[plain,environment=dxiconteudo]%
  \begin{dxicanvas}
    \dxibarra{1.59}{1.21}{1.32}
    \dxitxt{2.12}{1.16}{26.5}{\dxiTituloSecao\color{dxinavy}#2}
    %% o numero do slide aparece sempre; "semdeco" so tira o octogono cinza
    \dxinumslide{30.02}{1.06}{1.90}%
    \ifstrequal{#1}{deco}{\dxioct{oct-cinza}{31.75}{2.58}{0.88}}{}%
    \dximarcadagua
  \end{dxicanvas}\par
  \vspace*{3.50cm}%
  \dxiCorpo\color{dxinavy}\RaggedRight
  \setlength{\parskip}{0.5em}%
}{\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDE 5 -- DIVISOR CLARO COM LOGO
%% \dxidivisor[<chamada/link>]{<TITULO>}{<subtitulo>}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\dxidivisor}[3][]{%
\begin{frame}[plain]
\begin{dxicanvas}
  %% assinatura institucional: AX Academy | IFAM, no mesmo arranjo da marca
  %% d'agua dos slides de conteudo
  \node[anchor=north west] at (1.92,1.72)
    {\includegraphics[height=1.10cm]{logo/ax-logo-color}%
     \hspace{0.55cm}\raisebox{0.10cm}{\color{dxinavy!45}\rule{0.8pt}{0.86cm}}%
     \hspace{0.55cm}\includegraphics[height=1.10cm]{logo/ifam-horz}};
  \dxiregua{1.92}{3.42}
  \node[anchor=south west,text width=28.0cm,align=flush left] at (1.92,9.90)
    {\dxiTituloGrande\color{dxinavy}#2};
  \dxitxt{1.92}{10.70}{21.0}{\dxiurb\fontsize{18}{28}\selectfont\color{dxinavy}#3}
  \ifstrempty{#1}{}{%
    \dxitxt{1.92}{13.10}{23.0}%
      {\dxiurb\bfseries\fontsize{18}{24}\selectfont\color{dxinavy}#1}}%
\end{dxicanvas}
\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDE 6 -- DESTAQUE (grade de octogonos a direita)
%% \dxidestaque{<eyebrow>}{<TITULO>}{<paragrafo>}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\dxidestaque}[3]{%
\begin{frame}[plain]
\begin{dxicanvas}
  \dxigradeoct{24.72}{0.25}{oct-linha-vermelha}{oct-linha-navy}
  \dxiselo{24.72}{0.25}
  \dxiselifam{24.72}{12.67}
  \dxitxt{2.25}{2.70}{18.0}{\dxiEyebrow\bfseries\color{dxigrafite}#1}
  \dxiregua{2.25}{9.60}
  \node[anchor=north west,text width=21.8cm,align=flush left] at (2.25,10.30)
    {\dxiTituloMedio\color{dxinavy}#2};
  \dxitxt{2.25}{14.60}{19.0}{\dxiSubtitulo\color{dxinavy}#3}
\end{dxicanvas}
\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLIDE 7 -- CRONOGRAMA (linha do tempo, 2 a 4 marcos)
%%
%%   \dxicronograma[<TITULO>]{%
%%     \dximarco{<rotulo>}{\begin{dxilista}\item ...\end{dxilista}}
%%     ... ate 4 ...
%%   }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{dxi@nmarco}
\newcommand{\dximarco}[2]{%
  \ifnum\value{dxi@nmarco}<4\relax
    \stepcounter{dxi@nmarco}%
    \expandafter\gdef\csname dxi@k@rot@\the\value{dxi@nmarco}\endcsname{#1}%
    \expandafter\gdef\csname dxi@k@txt@\the\value{dxi@nmarco}\endcsname{#2}%
  \else
    \ClassWarning{dxikickoff}{O cronograma comporta no maximo 4 marcos;
      "#1" foi ignorado}%
  \fi}

\newcommand{\dxicronograma}[2][CRONOGRAMA]{%
\setcounter{dxi@nmarco}{0}%
#2%
\begin{frame}[plain]
\begin{dxicanvas}
  \dxibarra{1.59}{1.21}{1.32}
  \dxitxt{2.12}{1.16}{26.5}{\dxiTituloSecao\color{dxinavy}#1}
  \ifnum\value{dxi@nmarco}>0\relax
    \pgfmathsetmacro{\dxinm}{\thedxi@nmarco}%
    \def\dxikgap{2.60}\def\dxikx{1.50}\def\dxikband{8.49}%
    \pgfmathsetmacro{\dxikw}{(\dxiW-2*\dxikx-(\dxinm-1)*\dxikgap)/\dxinm}%
    \pgfmathsetmacro{\dxitwk}{\dxikw-1.40}%
    \pgfmathsetmacro{\dxifst}{\dxikx+\dxikw/2}%
    \pgfmathsetmacro{\dxilst}{\dxikx+(\dxinm-1)*(\dxikw+\dxikgap)+\dxikw/2}%
    \draw[dxiteal,line width=2.2pt,dash pattern=on 7pt off 7pt]
      (\dxifst,\dxikband) -- (\dxilst,\dxikband);
    \foreach \dxik in {1,...,\thedxi@nmarco}{%
      \pgfmathsetmacro{\dxibx}{\dxikx+(\dxik-1)*(\dxikw+\dxikgap)}%
      \pgfmathsetmacro{\dxicx}{\dxibx+\dxikw/2}%
      \begin{scope}[opacity=0.16]
        \node[anchor=south] at (\dxicx,8.02)
          {\includegraphics[width=1.04cm]{icones/relogio}};
      \end{scope}
      \fill[dxiteal,rounded corners=0.32cm]
        ({\dxicx-0.52},{\dxikband-0.32}) rectangle ++(1.04,0.64);
      \node[anchor=north,align=flush center,text width=\dxikw cm] at (\dxicx,9.50)
        {\dximont\bfseries\fontsize{15}{19}\selectfont\color{dxitealesc}%
         \csname dxi@k@rot@\dxik\endcsname};
      \draw[dxitealesc,line width=1.5pt,rounded corners=0.55cm]
        (\dxibx,10.76) rectangle ++(\dxikw,6.60);
      \node[anchor=north west,text width=\dxitwk cm,align=flush left]
        at ({\dxibx+0.70},11.30)
        {\dxiurb\fontsize{15}{21}\selectfont\color{dxinavy}%
         \csname dxi@k@txt@\dxik\endcsname};
    }%
  \fi
\end{dxicanvas}
\end{frame}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BLOCOS AUXILIARES DE CONTEUDO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Lista com o "check" duplo. \begin{dxilista}[<cor>] \item ... \end{dxilista}
\newenvironment{dxilista}[1][dxiteal]{%
  \begin{list}{\dxicheck{#1}}{%
    \setlength{\leftmargin}{1.05cm}\setlength{\labelwidth}{0.75cm}%
    \setlength{\labelsep}{0.30cm}\setlength{\itemsep}{0.45em}%
    \setlength{\parsep}{0pt}\setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}\setlength{\rightmargin}{0pt}}%
}{\end{list}}

%% Cartao de numero/KPI. \dxinum[<cor>]{<valor>}{<rotulo>}
%% Use varios em sequencia para formar uma fileira de indicadores.
\newcommand{\dxinum}[3][dxired]{%
  \begin{minipage}[t]{8.63cm}\RaggedRight\hyphenpenalty=10000
    {\dximont\bfseries\fontsize{44}{48}\selectfont\color{#1}\mbox{#2}}\\[0.35em]
    {\dxiurb\fontsize{14}{19}\selectfont\color{dxinavy}#3}%
  \end{minipage}\hspace{1.5cm}\ignorespaces}

%% Colunas dentro do corpo:
%%   \dxicol{12}{...}\dxicol{14}{...}   (largura em cm)
%% O \vspace{0pt} alinha as colunas pelo TOPO da caixa; sem ele o minipage[t]
%% alinha pela primeira linha de base e uma coluna que comeca com imagem
%% empurra a vizinha para baixo.
\newcommand{\dxicol}[2]{%
  \begin{minipage}[t]{#1 cm}\vspace{0pt}\RaggedRight #2\end{minipage}%
  \hspace{0.9cm}\ignorespaces}

%% Item numerado (objetivos especificos, etapas).
%% \dxiobj{<numero>}{<titulo>}{<texto>}
\newcommand{\dxiobj}[3]{%
  \begin{minipage}[t]{28.0cm}\RaggedRight
  \begin{tikzpicture}
    \node[anchor=north west,text width=26.0cm,align=flush left]
      (t) at (1.35,0)
      {{\dximont\bfseries\fontsize{14}{18}\selectfont\color{dxinavy}#2}\\[0.10em]
       {\dxiurb\fontsize{13}{17}\selectfont\color{dxinavy!85}#3}};
    \node[circle,fill=dxired,text=white,minimum size=0.86cm,inner sep=0pt,
          anchor=north west,
          font=\dximont\bfseries\fontsize{14}{14}\selectfont] at (0,-0.03) {#1};
  \end{tikzpicture}
  \end{minipage}\par\vspace{0.16cm}}

%% Cartao de frente de trabalho.
%% \dxifrente[<cor>]{<rotulo>}{<titulo>}{<texto>}
%% O conteudo vai num minipage de ALTURA FIXA: assim todos os cartoes ficam
%% do mesmo tamanho, independentemente do tamanho do texto.
\newcommand{\dxifrente}[4][dxired]{%
  \begin{tikzpicture}[baseline=(c.north)]
    \node[draw=dxicinza,line width=1pt,rounded corners=0.32cm,
          inner sep=0.48cm,anchor=north west] (c) at (0,0) {%
      \begin{minipage}[t][5.25cm][t]{5.85cm}\RaggedRight
      \hyphenpenalty=10000 \exhyphenpenalty=10000
      {\dximont\bfseries\fontsize{11}{13}\selectfont\color{#1}#2}\\[0.35em]
      {\dximont\bfseries\fontsize{13.5}{17}\selectfont\color{dxinavy}#3}\\[0.35em]
      {\dxiurb\fontsize{11.5}{15}\selectfont\color{dxinavy!85}#4}
      \end{minipage}};
    \fill[#1] ([xshift=0.5cm,yshift=-1pt]c.north west) rectangle
              ++(1.5cm,4pt);
  \end{tikzpicture}\hspace{0.35cm}\ignorespaces}

%% Figura centralizada com legenda opcional.
%% \dxifig[<legenda>]{<largura cm>}{<arquivo>}
\newcommand{\dxifig}[3][]{%
  \par\vspace{0.2cm}\centering
  \includegraphics[width=#2 cm]{#3}%
  \ifstrempty{#1}{}{\\[0.35em]{\dxiurb\fontsize{12}{15}\selectfont
    \color{dxinavy!70}#1}}%
  \par\vspace{0.2cm}\RaggedRight}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BPMN SIMPLIFICADO -- versao legivel em projecao dos diagramas AS-IS/TO-BE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tikzset{
  dxilane/.style={fill=dxicinza!22,draw=dxicinza,line width=0.6pt},
  dxilanelabel/.style={rotate=90,anchor=center,align=center,
    font=\dximont\bfseries\fontsize{9}{11}\selectfont,text=dxinavy},
  dxitask/.style={draw=#1,line width=1.1pt,fill=white,rounded corners=0.18cm,
    align=center,inner sep=0.16cm,
    font=\dxiurb\fontsize{9.5}{11.6}\selectfont,text=dxinavy},
  dxitask/.default=dxinavy,
  dxievent/.style={circle,draw=#1,line width=1.4pt,fill=white,minimum size=0.72cm},
  dxievent/.default=dxinavy,
  dxiflow/.style={->,>=stealth,draw=#1,line width=1.1pt},
  dxiflow/.default=dxinavy,
  dxiflowlbl/.style={font=\dxiurb\fontsize{8.5}{10}\selectfont,text=dxinavy!75,
    fill=white,inner sep=1.2pt},
}

%% Evento de inicio por TEMPORIZADOR (relogio dentro do circulo).
%% \dxitimer{<nome do no>}{<x>}{<y>}
\newcommand{\dxitimer}[3]{%
  \node[dxievent] (#1) at (#2,#3) {};
  \draw[dxinavy,line width=0.7pt] (#2,#3) circle (0.19);
  \draw[dxinavy,line width=0.7pt,line cap=round]
    (#2,#3) -- ++(0,0.12) (#2,#3) -- ++(0.09,-0.05);}

%% \dxilane{<x0>}{<y>}{<largura>}{<altura>}{<rotulo>}
\newcommand{\dxilane}[5]{%
  \pgfmathsetmacro{\dxilanew}{#4-0.3}%
  \fill[dxilane] (#1,#2) rectangle ({#1+#3},{#2-#4});
  \draw[dxicinza,line width=0.6pt] ({#1+1.15},#2) -- ({#1+1.15},{#2-#4});
  \node[dxilanelabel,text width=\dxilanew cm]
    at ({#1+0.58},{#2-#4/2}) {#5};}

%% Caixa realcada. \dxicaixa[<cor>]{<largura cm>}{<conteudo>}
\newcommand{\dxicaixa}[3][dxired]{%
  \begin{tikzpicture}[baseline=(dxibx.north)]
    \node[draw=#1,line width=1.2pt,rounded corners=0.35cm,
          inner sep=0.55cm,text width=#2 cm,align=flush left] (dxibx) {#3};
  \end{tikzpicture}}

\endinput
