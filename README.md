# `njubeamer` 
# by Niu Liu (niu.liu@nju.edu.cn)

This is a non-official LaTeX template based on the [`metropolis`](https://github.com/matze/mtheme) beamer theme, and customized for the convenience of making slides for Nanjing University (NJU).

The original template is copied from a template named cuzbeamer (https://github.com/xiehao/cuzthesis) used for students in Communication University of Zhejiang (CUZ), which is a very good one. I made some modifications to the template according to my habits and added several NJU elements. The new template was then renamed to njubeamer. It could be used for class lecture and presentation for defense.

Please feel free to use it and let me know if you have any suggestions and comments or you need any help.

## Related Repo

- [njubeamer](https://https://github.com/Niu-Liu/njubeamer): a non-official LaTeX template used in NJU.

## Project Structure

The structure of this project is shown and explained below:

```bash
njubeamer
├── njubeamer
│   ├── njubeamer.cls
│   ├── Logos
│   │   ├── beidalou.jpeg
│   │   ├── nju_log.jpg
│   │   ├── nju_logo_inv_trans.png
│   │   └── nju_logo_with_name_below.jpg
│   │   └── nju_logo_with_name_trans.png
│   │   └── nju_logo_with_name.jpg
│   └── tikz-uml.sty
├── Figures
├── demo.pdf
├── demo.tex
├── initialization.tex
├── ReadMe.md
└── references.bib
```

- `njubeamer/`: a folder containing the class file `njubeamer.cls` and the package `tikz-uml.sty` (written by [Nicolas Kielbasiewicz](http://perso.ensta-paristech.fr/~kielbasi/tikzuml/)), also with the `Logos/` folder (with various versions of school logos in it), this folder should be copied/moved to a default path storing custom tex templates, before using this template (see the Installation part);
- `initialization.tex`: common info imported by a series of `.tex` files, the content includes: author's name and e-mail, title, subtitle and date, users should assign these variables beforehand;
- `demo.tex`: the demo source file, showing how to use this `njubeamer` class to make a proper set of slides;
- `references.bib` (optional): the bib file used for `bibtex` to import references.
- `Figures`: a folder to put the figure (my own habit)

Users are supposed to add new `.tex` files at the same level of `demo.tex`, and specify their own common info in `initialization.tex` and necessary reference items in `references.bib` file if needed; while the file structure is not suggested to be modified, unless you know exactly what you are doing.

## Prerequests

To use this class:

- A LaTeX environment is required ([TeX Live](https://www.tug.org/texlive/) is highly recommended);
- The [Ubuntu font](https://design.ubuntu.com/font/) is required to show beautiful non-CJK characters;
- [Optional] If codes are to be shown, the `minted` package is used (the `minted` option should be switched on, see below), which then requires a Python 3 environment, with the `pygments` installed:

    ``` bash
    > pip install pygments
    ```

## Installation

Users are supposed to copy/move the `njubeamer/` folder to the path where the custom latex templates located, which could be obtained by:

```bash
> kpsewhich --var-value=TEXMFHOME
```
 eg (the `tex/latex` folders should be created manually if they do not exist):

- For Manjaro Linux: `~/texmf/tex/latex`
- For macOS: `~/Library/texmf/tex/latex`

## Usage

### Compilation

Due to some reasons of `metropolis` beamer theme, the `pdflatex` engine is not supported, thus the `xelatex` or `lualatex` is recommended. Besides, if `minted` option is on, the `-shell-escape` option is required when compiling, e.g.:

```bash
> xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error demo.tex
```

### Options


- `[colortheme=light/dark]`: a string option, set the background color of `metropolis`, `dark` by default, or `light` if desired;
- `[pagestyle=normal/wide/wider]`: a string option, set the aspectratio of slide pages, `normal` for 5:4, `wide` for 16:10 (the default), or `wider` for 16:9;
- `[titlealignment=left/center/right]`: a string option, set the alignment of elements (e.g. title, subtitle, author, date, etc.) in the title page, `left` (the default), `center` or `right`;
- `[minted=true/false]`: a boolean option, set for whether to include codes in the slides, `true` by default;
- `[algorithm=true/false]`: a boolean option, set for whether to use algorithm environments, `false` by default;
- `[pgfplots=true/false]`: a boolean option, set for whether to use `pgfplots` package to plot figures, `false` by default.

## License

This class is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/). This means that if you change the theme and re-distribute it, you *must* retain the copyright notice header and license it under the same CC-BY-SA license. This does not affect the presentation that you create with the class.