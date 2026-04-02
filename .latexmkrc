# .latexmkrc — конфигурация latexmk для сборки через XeLaTeX + minted

$xelatex = 'xelatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';
$pdf_mode = 5;                   # 5 = xelatex
$out_dir  = 'build';             # все артефакты — в папку build/

# Biber для biblatex
$biber = 'biber --output-directory=build %O %S';

# Собирать только main.tex (чтобы latexmk без аргументов не трогал остальные .tex)
@default_files = ('main.tex');

# Автоочистка вспомогательных файлов
$clean_ext = 'bbl blg run.xml synctex.gz _minted-%R';
