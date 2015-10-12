all: compila

compila:
	flex -i analisador_lexico.l
	bison analisador_sintatico.y
	gcc -otrab2 analisador_sintatico.tab.c -lfl
	pdflatex relatorio-trab2.tex
