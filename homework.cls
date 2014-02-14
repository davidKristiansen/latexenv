\ProvidesClass{homework}

\LoadClass[a4paper, 11pt]{article}

\RequirePackage[left=3.25cm, right=2.5cm, top=1.5cm, bottom=2.5cm]{geometry}

%% Mattepakker
\RequirePackage{amssymb, amsmath}
\RequirePackage{ulem} % \uuline{x} - To streker under svarett

%% font
\RequirePackage{ifxetex}
\ifxetex
\usepackage{fontspec}
\usepackage[MnSymbol]{mathspec}
\setmathsfont{STIX Math}
%\setromanfont{Caecilia LT Roman}
%\setsansfont{Droid Sans}
\setmonofont{Source Code Pro}
\defaultfontfeatures{Ligatures=TeX}

\else
\usepackage[utf8]{inputenc}
\RequirePackage{graphicx}
\fi
\RequirePackage[norsk]{babel}
\tolerance = 5000      % LaTeX er normalt streng når det gjelder linjebrytingen.
\hbadness = \tolerance % Vi vil være litt mildere, særlig fordi norsk har så
\pretolerance = 2000   % mange lange sammensatte ord.

% Linjeskift ved avsnitt
%\RequirePackage{parskip}
%\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt} % 1ex plus 0.5ex minus 0.2ex}
\setlength{\parindent}{0pt}

% Grafikk
\graphicspath{{img/}}

% denne kombinert med [H] `Tvinger` float til å plassere seg på rett plass
\RequirePackage{float}

%% Sections
\RequirePackage{titlesec}
\titleformat{\section}{\Large\bfseries\sffamily}{\thesection}{1em}{}
% \titlespacing{\command}{left}{before-sep}{after-sep}{right-sep}
\titlespacing{\section}{8pt}{-10pt}{0pt}

\RequirePackage{ifthen}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
% \fancyhf{}
\fancyfoot[C]{\texttt{\thepage}}

\renewcommand{\headrulewidth}{1pt}
\setlength{\headheight}{30pt}
% -----------------------------------------------------------------------------------
% Setter opp box
% -----------------------------------------------------------------------------------

\newcommand{\name}[1]{\def \@name {#1}}
\newcommand{\class}[1]{\def \@class {#1}}
\newcommand{\assignment}[1]{\def \@assignment {#1}}
\newcommand{\duedate}[1]{\def \@duedate {#1}}

\newcommand{\headerblock}{%
  \textsf{
    \begin{flushright}
      \mbox{\@name}\protect\\
      \mbox{\@class}\protect\\
      \mbox{\@assignment}\protect\\
      \mbox{\@duedate}\protect\\
    \end{flushright}%
  }}


\AtBeginDocument{%
  \headerblock
  \fancyhead[L]{
    \scriptsize{\textsf{\@name \\ \@class \\ \@assignment}}
  }
  \thispagestyle{plain}
}

% ----------------------------------------------------------------------------------
% Nye miljø
% ----------------------------------------------------------------------------------
\RequirePackage{framed}

\newenvironment{problem}[1][]{%
  \sffamily
  % \bfseries
  \begin{minipage}{\textwidth} % For å holde på samme side
    \setlength{\parskip}{6pt}
    \begin{framed}

    }{%

    \end{framed}
  \end{minipage}

}

\newenvironment{solution}[1][]{%

  \begin{minipage}{\textwidth} % For å holde på samme side
    \setlength{\parskip}{6pt}
    \rmfamily
  }{%
    \begin{flushright}
      \hfill\ensuremath{\scriptscriptstyle\blacksquare} % QED
    \end{flushright}
  \end{minipage}

}

\AtEndDocument{%
}
