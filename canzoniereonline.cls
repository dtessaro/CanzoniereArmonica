\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{canzoniereonline}[2017/12/17 v0.6 Una classe per la creazione di canzonieri on line]

% PACKAGING (1)
%-----------------------------------------------------

\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setdefaultlanguage{italian}
\else
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[italian]{babel}
\fi
\RequirePackage{xkeyval}





%%%%%%%%%%%%%%%%%
%%  PARAMETER  %%
%%%%%%%%%%%%%%%%%

\renewcommand{\normalfont}{\libertine}
\newcommand{\FontSize}           {12pt}  %dimensione font corpo

%titolo canzone
\newcommand{\stampatitolo}{\fontsize{16}{17}\selectfont\bfseries} %% dimensione titolo canzone
\newcommand{\stampanumero}{\fontsize{30}{35}\selectfont\bfseries} %% dimenzione numeri




%% CHAPTER & SECTIONS
%-----------------------------------------

\newcommand*{\mySection}[3]{
	\cleardoublepage{}
	\null	
	\vfill
	\section*{\centering \fontsize{40}{20} \it{#1}}
	\begin{center}
	  \includegraphics[width=#3]{#2}
	\end{center}
	  \vfill
	\newpage
}

\newcommand*{\mySubsection}[1]{

   	\subsection*{\centering \huge\it{#1}}
	\null
}

\newcommand{\songList}[2]{
	\begin{songs}{}
		\songcolumns{\canzsongcolumsnumber}
		\setcounter{songnum}{\theGlobalSongCounter} %set songnum counter, otherwise would be reset
		%set the default path inside current folder
		\makeatletter
		\def\input@path{{#1}}
		\makeatother
		{#2} %Song list
		\setcounter{GlobalSongCounter}{\thesongnum}
	\end{songs}
}


% Conditionals
%-----------------------------------------------------

\newif\iflibertine
\newif\ifcanzsingole
\newif\ifaquattrovert
\newif\ifacinquevert
\newif\ifbcinquevert%<P>
\newif\ifacinqueor
\newif\ifaseivert
\newif\ifsmart
\newif\iftitleindex

\newif\ifcover

\newif\iftwocolumns%<P>

% Class options declaration
%-----------------------------------------------------

\DeclareOption{palatino}{\libertinefalse}
\DeclareOption{libertine}{\libertinetrue}
\DeclareOption{titleindex}{\titleindextrue}
\DeclareOption{authorsindex}{\authorsindextrue}
\DeclareOption{tematicindex}{\tematicindextrue}
\DeclareOption{cover}{\covertrue}
\DeclareOption{nocover}{\coverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{lyric}{\PassOptionsToPackage{lyric}{songs}}
\DeclareOption{chorded}{\PassOptionsToPackage{chorded}{songs}}

\DeclareOptionX{minorsign}{\def\canzonline@myminor{#1}}

\DeclareOption{twocolumns}{\twocolumnstrue}%<P>
\DeclareOption{onecolumn}{\twocolumnsfalse}%<P>

% Get execution option from master doc

\ExecuteOptions{standard,libertine,cover}
\ExecuteOptionsX{minorsign=m}
\ProcessOptions\relax
\ProcessOptionsX\relax

\LoadClass[\FontSize]{book}




% PACKAGING (2)
%-----------------------------------------------------

\RequirePackage{graphicx}
\RequirePackage{amssymb}
\RequirePackage{fancyhdr} 
\RequirePackage{tabularx,booktabs,colortbl}
\RequirePackage{multirow}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{url}
\RequirePackage{xparse}
\RequirePackage{etoolbox,xstring}
\RequirePackage{ccicons}
\RequirePackage{imakeidx} 


\usepackage{titlesec}% cambio la formattazione dei titolo dei capitoli 
										 % (mi serve per l'indice tematico)


% CERCHIETTO PER ASPIRATI
%---------------------------------

\newcommand{\asp}[1]{ \hspace{-8pt} \raisebox{0.5pt}{\textcircled{\raisebox{-.9pt}{#1}}} \hspace{-8pt} }


% FONT
%-----------------------------------------------------

\iflibertine
	\ifxetex
		\setmainfont{Lexia Readable}
	\else
		\RequirePackage[tt=false]{libertine}
	\fi
\else
	\RequirePackage[]{mathpazo}
\fi


% TESTATINE
%-----------------------------------------------------

\pagestyle{fancy}%
\setlength{\headheight}{0pt}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[RO]{} 
\fancyfoot[LE]{}  
\fancypagestyle{plain}{%
	\fancyhead{} % leva l'intestazione
	\fancyfoot[C]{} 
	\renewcommand{\headrulewidth}{0pt} % e leva la linea dalle pagine di inizio capitolo
}




% IMPOSTAZIONI PACCHETTO SONGS
%-----------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[nomeasures,noindexes,noshading]{songs}
\MultiwordChords

\notenamesin {1} {2} {3} {4} {5} {6} {7}
\notenamesout{LA}{SI}{DO}{RE}{MI}{FA}{SOL}
\renewcommand{\sharpsymbol}{\ensuremath{\raisebox{0.5mm}{\footnotesize$\sharp$}}}  % diesis
\renewcommand{\flatsymbol}{\raisebox{0.1ex}{$\flat$}}				% bemolle
\setlength{\cbarwidth}{0pt}						% linea laterale ritornelli
\setlength{\sbarheight}{0pt}						%linee sopra e sotto
\renewcommand{\chorusfont}{\bfseries}  %chorus BOLD per i ritornelli
\renewcommand{\notefont}{\it}
\renewcommand{\rep}[1]{{\normalfont($\times$#1)}}		% cambia la x nelle ripetizioni
\setlength{\parindent}{0pt}
\setlength\columnsep{5mm}

%% ACCORDI
\renewcommand{\printchord}[1]{\normalfont\small\bfseries#1}


%% STROFE
%rimuove la numerazione delle strofe
\renewcommand{\printversenum}[1]{}
\setlength{\versenumwidth}{0pt}
%% Per modificare il font delle seconde voci-risposte
\renewcommand\SB@echo[1]{%
	\endgroup% 
	\begingroup%
		\ifdim\fontdimen\@ne\font>\z@\upshape\else\itshape\fi% 
		% \ifxetex imporre un cambio font per LEXIA %
		\endlinechar\m@ne% 
		\scantokens{(#1)}%
	\endgroup% 
}

%pre- and postlude separation

	\ifchorded
		\afterpreludeskip=-7pt
		\setlength{\versesep}{0.2\baselineskip plus 4pt minus 2pt}
	\else
		\afterpreludeskip=2pt
		\setlength{\versesep}{0.6\baselineskip plus 4pt minus 2pt}
	\fi
\renewcommand{\makepostlude}{\vskip10pt plus 10pt minus 3pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%interlinea
\renewcommand{\clineparams}{
	\baselineskip=10pt		%space between two line of lyrics
	\lineskiplimit=0pt
	\lineskip=0pt 
}



%%modifico il comando per i titoli secondari, in modo da generare l'indice
%\renewcommand\indextitleentry[1]{%
%\ifxetex
%	\iftitleindex\index[alfabetico]{#1|indexanchor{\thesongnum}}
%	\else
%	\fi
%\else
%  	\iftitleindex\index{#1|indexanchor{\thesongnum}}
%	\else
%	\fi
%\fi
%}

%note di basso
\def\bassfont{\futurelet\next\@bassverify}
\def\@basstrue{\hspace{-0.2em}/\hspace{-0.05em}\scriptsize}
\def\@bassfalse{/}
\def\@bassverify{%
  \ifcat\next f
    \@basstrue
  \else
    \@bassfalse
  \fi}
  %\newcommand{\canzonline@myminor}{m}% per modificare il segno di minore si ridefinisca questo comando, ad esempio con {\textendash} al posto di {m}
\renewcommand{\chordlocals}{%
\catcode`/\active
\catcode`-\active}
{\chordlocals\global\let/\bassfont
\global\let-=\canzonline@myminor}



%SONGPOS
%\ifaseivert
%\songpos{0}
%\else
%	\ifacinqueor\songpos{1}
%	\else
%	\ifacinquevert\songpos{1}
%	\fi\fi%
%\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%


%% TITLE GEOMETRY

\newlength{\titlength}
\newlength{\numerwidth}
\newlength{\larcolonna}

\renewcommand\makeprelude{%
		\resettitles%
		\settowidth{\numerwidth}{\stampanumero\thesongnum}
		\newcommand{\titolo}{\raggedright \stampatitolo\songtitle}
		\settowidth{\titlength}{\titolo}
		\setlength{\larcolonna}{\hsize-\numerwidth}			
		\stampanumero\textcolor{gray}{\thesongnum}
	
		\titolo \\
		\rule{\larcolonna+\numerwidth}{.5pt} \hfill
		\raggedleft	\footnotesize{\itshape\songauthors}
}	

%INDICI grazie a Enrico Gregorio
%------------------------------------------------
\makeindex[name=alfabetico,title=Indice alfabetico,program=truexindy,options=-M texindy -C utf8 -L italian -M xindystyle]

\def\accents@list{\do\IeC\do\`\do\'}
\def\letters@list{\do\i{i}}
\newcommand{\noaccentindex}[1]{%
  \begingroup
  \protected@edef\next{#1}%
  \ifnum\pdfstrcmp{\detokenize\expandafter{\next}}{\detokenize{#1}}=\z@
    \endgroup\index{#1|indexanchor{\thesongnum}}%
  \else
    \def\do##1{\def##1####1{####1}}\accents@list
    \def\do##1##2{\def##1{##2}}\letters@list
    \edef\next{\endgroup\def\noexpand\next{\next}}\next
    \expandafter\index\expandafter{\next @\detokenize{#1}|indexanchor{\thesongnum}}%
  \fi}


% COPERTINA
%--------------------------------------- 



\newcommand{\titolettocop}{}
\newcommand{\titolocop}{}
\newcommand{\sottotitolocop}{}
\newcommand{\imgcop}{}
\newcommand{\piede}{}
\newcommand{\printtitoletto}{\Large\titolettocop} 
\newcommand{\printtitolo}{\bf\Huge\titolocop \\}
\newcommand{\printsottotitolo}{\large\scshape\sottotitolocop\\}
\newcommand{\printpiede}{\normalfont\piede}
\newcommand{\firstpage}{%
	\begin{titlepage}
	\begin{center}
	\null
	\vspace*{2cm}
	\printtitoletto 
	\bigskip
	\printtitolo 
	\bigskip
	\printsottotitolo
	\vfill
	\imgcop
	\vfill
	\printpiede
	\end{center}
\end{titlepage}
}

\newcommand{\colophon}{%
	\pagebreak
	\null
	\vfill
	
	\ifaseivert
	\begin{minipage}{\textwidth}
	\else
	\begin{minipage}{0.41\textwidth}
	\fi
	\small
	Questo canzoniere è stato aggiornato il giorno \\
	\textbf{\today{}} \\
	Il codice sorgente è libero e disponibile su \url{ github.com/dtessaro/CanzoniereArmonica}.
	\smallskip
		
	\smallskip
	\smallskip
	\begin{center}
		\includegraphics[width=2cm]{QR_code.png}
	\end{center}
	\end{minipage}
	\clearpage
}

\let\songlink\hyperlink
\endinput
