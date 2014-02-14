my $motor = "xelatex";
my $build_dir = "build/";

$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;
$pdf_previewer = "evince";
$clean_ext = "paux lox pdfsync out";
#$pdflatex="$motor -interaction=nonstopmode";
$pdflatex="mkdir -p $build_dir; $motor -interaction=nonstopmode";
$out_dir = $build_dir;
$aux_dir = $build_dir;
