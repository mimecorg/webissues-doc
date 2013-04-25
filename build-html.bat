@echo off

if "%1" == "" goto usage
if not exist src\%1\book.xml goto usage

if exist html\%1 rmdir /s /q html\%1

mkdir html\%1

echo copying common files...
xcopy /s /q /i common html\%1\common

echo copying images...
xcopy /s /q /i src\%1\images html\%1\images

echo generating html files...
xsltproc --nonet -o html\%1\index.html style-html.xsl src\%1\book.xml

goto :eof

:usage
echo usage: build-html.bat LANG
