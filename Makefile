all: compila

compila:
	flex -i trab1.l
	bison -v analisador_sintatico.y
	gcc -otrab2 analisador_sintatico.tab.c -lfl

executa:
	./trab2 < entrada.txt
