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

# ---------- Авто-генерация _includes.tex для каждой главы ----------
# Сканирует chapters/XX-name/, собирает все .tex кроме chapter.tex и
# _includes.tex, сортирует по имени → записывает \input{...} в _includes.tex.
# Запускается перед каждой компиляцией.

sub generate_includes {
    my $chapdir = 'chapters';
    opendir(my $dh, $chapdir) or die "Cannot open $chapdir: $!";
    my @groups = sort grep { -d "$chapdir/$_" && $_ !~ /^\./ } readdir($dh);
    closedir($dh);

    for my $group (@groups) {
        my $dir = "$chapdir/$group";
        opendir(my $sdh, $dir) or next;
        my @files = sort grep { /\.tex$/ && $_ ne 'chapter.tex' && $_ ne '_includes.tex' } readdir($sdh);
        closedir($sdh);

        my @lines;
        for my $f (@files) {
            (my $base = $f) =~ s/\.tex$//;
            push @lines, "\\input{$dir/$base}";
        }

        my $inc = "$dir/_includes.tex";
        my $content = join("\n", @lines) . "\n";

        my $old = '';
        if (-f $inc) {
            open my $fh, '<', $inc or die;
            local $/; $old = <$fh>;
            close $fh;
        }
        if ($old ne $content) {
            open my $fh, '>', $inc or die "Cannot write $inc: $!";
            print $fh $content;
            close $fh;
        }
    }
}

generate_includes();
