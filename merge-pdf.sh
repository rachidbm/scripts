
# merge / concat PDF files
out=merged.pdf
pdftk *.pdf cat output $out
echo "Output is in: " $out;


# gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=all.pdf scherm1.pdf scherm2.pdf 

