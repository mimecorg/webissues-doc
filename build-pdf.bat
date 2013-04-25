@echo off

if "%1" == "" goto usage
if not exist src\%1\book.xml goto usage

echo generating fo file...
xsltproc --nonet -o src\%1\book.fo style-pdf.xsl src\%1\book.xml

echo generating pdf file...
pushd src\%1
call fop.bat -nocs book.fo ..\..\book-%1.pdf
popd

del /q src\%1\book.fo

goto :eof

:usage
echo usage: build-pdf.bat LANG
