%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Hao XIE <oaheix@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%- Modified by Niu Liu (niu.liu@foxmail.com) to be used for NJU
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{njubeamer}[2019/02/01 v1.0 LaTeX Document Class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
\RequirePackage{kvoptions}% use key-value options
\SetupKeyvalOptions{
    family=nju,
    prefix=nju@option@
}
\DeclareStringOption[light]{colortheme}[light]% light or dark (default)
\DeclareStringOption[wide]{pagestyle}[wide]% normal, wide (default) or wider
\DeclareStringOption[left]{titlealignment}[left]% left, center or right (default)
\DeclareBoolOption[true]{minted}% use minted package (default) or not
\DeclareBoolOption[false]{algorithm}% use algorithm package bundle or not (default)
\DeclareBoolOption[false]{pgfplots}% use pgfplots package or not (default)
\DeclareDefaultOption{%
    \PassOptionsToClass{\CurrentOption}{beamer}%
}%
%-
%-> Terminates all options processing
%-
\ProcessKeyvalOptions{nju}\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\ifxstringequal}{\expandafter\ifstrequal\expandafter}% expansion control
\ifxstringequal{\nju@option@pagestyle}{normal}{%
    \PassOptionsToClass{aspectratio=43}{beamer}%
}{\ifxstringequal{\nju@option@pagestyle}{wide}{%
    \PassOptionsToClass{aspectratio=1610}{beamer}%
}{%
    \PassOptionsToClass{aspectratio=169}{beamer}%
}}%
\LoadClass[UTF8,10pt,professionalfont,zihao=false]{ctexbeamer}%
%---------------------------------------------------------------------------%
%->> Theme configuration
%---------------------------------------------------------------------------%
\usetheme[progressbar=foot]{metropolis}%
\RequirePackage{appendixnumberbeamer}% 
\metroset{numbering=fraction}%
\ifxstringequal{\nju@option@colortheme}{light}{
    \metroset{background=light}%
    \definecolor{njupurple}{RGB}{99,6,95}
    \setbeamercolor{frametitle}{bg=njupurple,fg=white}
    \setbeamertemplate{background canvas}{
        \begin{tikzpicture}
            \node [opacity=0.09]{\includegraphics[width=\paperwidth,height=\paperheight]{njubeamer/Logos/beidalou.jpeg}};
        \end{tikzpicture}
    }
    \setbeamertemplate{frame footer}{\includegraphics[width=0.12\textwidth]{njubeamer/Logos/nju_logo_with_name_trans.png}}
}{%
    \metroset{background=dark}%
    \setbeamertemplate{frame footer}{\includegraphics[width=0.12\textwidth]{njubeamer/Logos/nju_logo_inv_trans.png}}
}%
%

% \setbeamertemplate{background canvas}{\includegraphics[width=\paperwidth]{Logos/beidalou.jpeg}}

%---------------------------------------------------------------------------%
%->> CJK Languages for different platforms and compilers
%---------------------------------------------------------------------------%
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn%
\providecommand{\g__ctex_fontset_tl}{}% platform fontset state variable
\edef\nju@fontset{\g__ctex_fontset_tl}% expanded platform fontset state variable
\ExplSyntaxOff%
%-
%-> Platform fontset <windows>, <mac>, <linux>
%-
\newif\ifnju@windows \nju@windowsfalse% 
\newif\ifnju@mac \nju@macfalse% 
\newif\ifnju@linux \nju@linuxfalse% 
\ifxstringequal{\nju@fontset}{windows}{
    \nju@windowstrue%
    % \ctexset{fontset=windowsnew}%
}{\ifxstringequal{\nju@fontset}{mac}{
    \nju@mactrue
    % \ctexset{fontset=macnew}%
}{
    \nju@linuxtrue%
    % \ctexset{fontset=ubuntu}%
}}
%-
%-> LaTeX engine <pdflatex>, <lualatex>, <xelatex>
%-
\newif\ifnju@pdftex \nju@pdftexfalse
\newif\ifnju@xetex \nju@xetexfalse
\newif\ifnju@luatex \nju@luatexfalse
\RequirePackage{ifxetex,ifluatex}% LaTeX engine detection
\ifxetex% XeLaTeX
    \nju@xetextrue%
\else\ifluatex% LuaLaTeX
    \nju@luatextrue%
\else% pdfLaTeX, not supported in Linux
    \nju@pdftextrue%
\fi\fi
\RequirePackage{amsmath,mathtools,amsfonts}%
\ifnju@pdftex
    \RequirePackage[utf8]{inputenc}% set input encoding, document must use utf-8 encoding
    \RequirePackage[T1]{fontenc}% set font encoding to enable modern font encoding
    \RequirePackage{newtxtext}%
\else
    \RequirePackage{fontspec}% support calling system fonts
    \ifnju@xetex
        \RequirePackage{xeCJK}% support calling system fonts
    \fi
    
    % \setmainfont{Ubuntu}
    % \setsansfont{Ubuntu}
    % \setmonofont{Ubuntu Mono}
    
    \ifnju@linux
        % \setmainfont[NFSSFamily=entextrm]{TeX Gyre Termes}% an alternative of Times New Roman
        % \setsansfont[NFSSFamily=entextsf]{TeX Gyre Heros}% an alternative of Helvetica
        % \setmonofont[NFSSFamily=entexttt]{TeX Gyre Cursor}% an alternative of Courier New
        \setmainfont{Ubuntu}
        \setsansfont{Ubuntu}
        \setmonofont{Ubuntu Mono}
    \else
        \ifnju@windows%
            \setmainfont{Palatino Linotype}% Times New Roman
            \setsansfont{Palatino Linotype}% Helvetica
            \setmonofont{Consolas}%
        \else% for mac
            \setmainfont{Palatino}% Times New Roman
            \setsansfont{Palatino}% Helvetica
            \setmonofont{Monaco}%
        \fi
    \fi
\fi
\RequirePackage[libertine,liby,libaltvw]{newtxmath}% load after math packages


%---------------------------------------------------------------------------%
%->> New environments and macros for convenience
%---------------------------------------------------------------------------%
\RequirePackage{calc}% arithmetic calculation
%-
%-> The new standout environment for standout frames
%-
\newenvironment{standout}[1][]{%
    \begingroup
    \setbeamertemplate{frame footer}{}
    \setbeamertemplate{background canvas}[default]
    \ifxstringequal{\nju@option@colortheme}{light}{
        \setbeamercolor{frametitle}{fg=black!2,bg=mDarkTeal}
        }{
        \setbeamercolor{frametitle}{fg=mDarkTeal,bg=black!2}
    }
    \begin{frame}[standout]{#1}
}{%
    \end{frame}
    \endgroup
}%
%-
%-> The new fragile environment for fragile frames
%-
\newenvironment{fragile}[1][]{%
    %- the environment option tells beamer to look the new name "fragile",
    %- instead of the original name "frame"
    \begin{frame}[fragile,environment=fragile]{#1}
}{%
    \end{frame}
}%
%-
%-> The new algorithmx environment for algorithms
%-
\ifnju@option@algorithm
    \newenvironment{algorithmx}[2][]{%
        \begin{algorithm}[H]
            \caption{#2}%\label{#1}
            \begin{algorithmic}[1]
    }{%
            \end{algorithmic}
        \end{algorithm}
    }%
\fi
%-
%-> The new bicolumns macro for two columns environment
%-> NOTE:
%-> 1. This command MUST be used within the fragile environment,
%-> 2. NO extra character is allowed in the same line of "{" and "}" of the
%->    last two arguments, not even a comment!!
%-> WRONG:
%->     \bicolumns[0.5]{left}{right}
%-> RIGHT:
%->     \bicolumns[0.5]{
%->         left
%->     }{
%->         right
%->     }
%-
\newlength{\nju@leftwidth}
\newlength{\nju@rightwidth}
\newcommand{\bicolumns}{%
    \begingroup
    \let\do\@makeother\dospecials
    \catcode`\{=1
    \catcode`\}=2
    \endlinechar`\^^J
    \bicolumns@implement
}
\newcommand{\bicolumns@implement}[3][0.618]{
    \endgroup
    \setlength{\nju@leftwidth}{#1\textwidth}
    \setlength{\nju@rightwidth}{\textwidth-\nju@leftwidth}
    \begin{columns}[T,onlytextwidth]
        \begin{column}{\nju@leftwidth}
            \scantokens{#2\noexpand}%
            \expandafter\nju@cleanup%
        \end{column}
        % \vrule{}% vertical line between two columns
        \begin{column}{\nju@rightwidth}
            \scantokens{#3\noexpand}%
            \nju@cleanup%
        \end{column}
    \end{columns}
}
\def\nju@cleanup#1^^J{#1}
%---------------------------------------------------------------------------%
%->> Useful packages for some basic elements
%---------------------------------------------------------------------------%
\RequirePackage{ctable,multirow,multicol}% captions in tables (using booktabs)
\RequirePackage{caption}% extra caption features
\graphicspath{{./Figures/}}% set the default graphic path
%
\ifnju@option@minted%
    \RequirePackage{minted}%
    \ifxstringequal{\nju@option@colortheme}{light}{%
        \usemintedstyle{friendly}%
    }{%
        \usemintedstyle{monokai}%
    }%
    \setminted{%
        autogobble,% automatically remove the spaces to the left of the code
        linenos=true,% show line numbers
        fontsize=\footnotesize,% smaller font size
        % escapeinside=@@,% insert latex code between @ and @
        frame=lines,% frame styles: none or lines
        % numbers=both,% show line numbers on: left, right, both or none
        mathescape=true,% insert math code
    }%
    \setmintedinline{%
        fontsize=\normalsize,
    }%
\fi
\RequirePackage{tikz-uml}% tikz-uml for diagrams (class, use case,
                         % state transitions, sequence and component)
\ifxstringequal{\nju@option@colortheme}{light}{
    \tikzumlset{%
        % text=white,
        % draw=white,
        % fill class=black!80,
        % fill template=blue!80,
        % fill note=darkgray!100,
        % fill package=black!80,
        font=\bfseries\ttfamily\tiny
    }
}{
    \tikzumlset{%
        text=white,
        draw=white,
        fill class=black!80,
        fill template=blue!80,
        fill note=darkgray!100,
        fill package=black!80,
        font=\bfseries\ttfamily\tiny
    }
}
\usetikzlibrary{%
    intersections,
    through,
    shapes.geometric,
    shapes.misc,
    positioning,
    calc,
    arrows,
    graphs,
    math
}
\ifxstringequal{\nju@option@colortheme}{light}{
    \tikzstyle{terminal} = [
        rounded rectangle, thin,
        font = \ttfamily\footnotesize, 
        draw = black!50,
        text = black,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{nonterminal} = [
        rectangle, thin,
        font = \ttfamily\footnotesize,
        draw = black!50,
        text = black,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{status box} = [
        rounded rectangle, very thin,
        font = \tiny,
        draw = red!50!black!50,
        top color = black, bottom color = red!20!black!50,
        text = black,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{motion box} = [
        rectangle, minimum size = 3mm, very thin,
        font = \ttfamily\tiny,
        draw = blue!50!black!50,
        top color = black, bottom color = blue!20!black!50,
        text = black,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{comment box} = [
        rectangle, very thin,
        font = \ttfamily\footnotesize,
        text = black!70,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{point} = [ circle, inner sep = 0pt, minimum size = 0pt ] %
    \tikzstyle{skip loop} = [ to path = { -- ++(#1, 0) |- (\tikztotarget) } ]%
    \tikzstyle{hv path} = [ to path = { -| (\tikztotarget) } ] %
    \tikzstyle{vh path} = [ to path = { |- (\tikztotarget) } ] %
    \tikzstyle{every new ->} = [ shorten >= 1pt ] %
    \tikzstyle{graphs/every graph} = [ edges = rounded corners ] %
    \tikzstyle{every picture} += [remember picture]
    \tikzstyle{na} = [baseline = -.5ex]
}{
    \tikzstyle{terminal} = [
        rounded rectangle, thin,
        font = \ttfamily\footnotesize, 
        draw = black!50,
        text = white,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{nonterminal} = [
        rectangle, thin,
        font = \ttfamily\footnotesize,
        draw = black!50,
        text = white,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{status box} = [
        rounded rectangle, very thin,
        font = \tiny,
        draw = red!50!black!50,
        top color = black, bottom color = red!20!black!50,
        text = white,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{motion box} = [
        rectangle, minimum size = 3mm, very thin,
        font = \ttfamily\tiny,
        draw = blue!50!black!50,
        top color = black, bottom color = blue!20!black!50,
        text = white,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{comment box} = [
        rectangle, very thin,
        font = \ttfamily\footnotesize,
        text = black!30,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{point} = [ circle, inner sep = 0pt, minimum size = 0pt ] %
    \tikzstyle{skip loop} = [ to path = { -- ++(#1, 0) |- (\tikztotarget) } ]%
    \tikzstyle{hv path} = [ to path = { -| (\tikztotarget) } ] %
    \tikzstyle{vh path} = [ to path = { |- (\tikztotarget) } ] %
    \tikzstyle{every new ->} = [ shorten >= 1pt ] %
    \tikzstyle{graphs/every graph} = [ edges = rounded corners ] %
    \tikzstyle{every picture} += [remember picture]
    \tikzstyle{na} = [baseline = -.5ex]
}
\ifnju@option@algorithm%
    \RequirePackage{algpseudocode,algorithm,algorithmicx}% algorithm support
    \algrenewcommand\ALG@beginalgorithmic{\footnotesize}% font size of algorithms
    \algrenewcommand\algorithmiccomment[2][\scriptsize\ttfamily]{
        {#1\hfill\(\triangleright\) #2}% font size of comments in algorithms
    }
    \captionsetup[algorithm]{font=footnotesize}% font size of algorithm captions
\fi%
\ifnju@option@pgfplots%
    \usepackage{pgfplots}
    \usepgfplotslibrary{dateplot}
\fi%
%---------------------------------------------------------------------------%
%->> Customize the alignment of elements at the cover page
%---------------------------------------------------------------------------%

\setbeamertemplate{title}{
    \ifxstringequal{\nju@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\nju@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \linespread{1.0}%
    \inserttitle%
    \par%
    \vspace*{0.5em}%
}
\setbeamertemplate{subtitle}{
    \ifxstringequal{\nju@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\nju@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertsubtitle%
    \par%
    \vspace*{0.5em}%
}
% Remove the line for Institute
\setbeamertemplate{institute}{}
% Add email information
\newcommand{\email}[1]{\gdef\nju@email{#1}}%
\newcommand{\department}[1]{\gdef\nju@department{#1}}%
\setbeamertemplate{author}{
    \ifxstringequal{\nju@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\nju@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \vspace*{2em} \insertauthor %
    \par%
    \insertinstitute \quad \nju@department
    \par
    % {\scriptsize \href{mailto:\nju@email}{\ttfamily \nju@email}}%
    {\scriptsize \href{mailto:\nju@email}{\mdseries \nju@email}}%
    \par%
    \vspace*{0.25em}%
}
\setbeamertemplate{date}{
    \ifxstringequal{\nju@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\nju@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertdate%
    \par%
}
% Logo
\AtBeginDocument{
    \makeatletter
    %-
    %-> The university logo in the title page
    %-
    \ifxstringequal{\nju@option@colortheme}{light}{%
        \titlegraphic{\hfill\includegraphics[width=0.15\textwidth]{njubeamer/Logos/nju_logo_with_name_below.jpg}}%
    }{%
        \titlegraphic{\hfill\includegraphics[width=0.15\textwidth]{njubeamer/Logos/nju_logo_with_name_below_dark.png}}%
    }%
    \makeatother
}
%
%---------------------------------------------------------------------------%
\endinput%
% 