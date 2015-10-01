%{
#include <stdio.h>
    
    extern int line_num;
%}

%token token_literal
%token token_logico
%token token_palavraReservada
%token token_atribuicao
%token token_operadorAritmetico
%token token_operadorMais
%token token_operadorMenos
%token token_operadorVezes
%token token_operadorDividir
%token token_operadorRelacional
%token token_simboloEspecial
%token token_real
%token token_inteiro
%token token_caracter
%token token_identificador
%token token_pontoVirgula
%token token_algoritmo
%token token_variaveis
%token token_fimVariaveis
%token token_doisPontos
%token token_virgula
%token token_tipo
%token token_inicio
%token token_fim
%token token_tipoReal
%token token_tipoInteiro
%token token_tipoCaractere
%token token_tipoLiteral
%token token_tipoLogico
%token token_tipoMatriz
%token token_de
%token token_abreParentese
%token token_fechaParentese
%token token_abreColchete
%token token_fechaColchete
%token token_se
%token token_senao
%token token_entao
%token token_fimSe

%start ALGORITMO

%%

ALGORITMO: token_algoritmo token_identificador token_pontoVirgula PROGRAMA
;

PROGRAMA: VARIAVEIS
         | PROGRAMA_PRINCIPAL
;

VARIAVEIS: token_variaveis VARIAVEL
;

TIPO_VARIAVEL: MATRIZ
              | TIPO_VARIAVEL_PRIMITIVO
;

TIPO_VARIAVEL_PRIMITIVO: token_tipoReal
              | token_tipoInteiro
              | token_tipoCaractere
              | token_tipoLiteral
              | token_tipoLogico 
;

MATRIZ: token_abreColchete token_inteiro token_fechaColchete MATRIZ
        | token_abreColchete token_inteiro token_fechaColchete token_de TIPO_VARIAVEL_PRIMITIVO
;

VARIAVEL: token_identificador token_virgula VARIAVEL
         | token_identificador token_doisPontos TIPO_VARIAVEL token_pontoVirgula VARIAVEL
         | token_identificador token_virgula token_fimVariaveis PROGRAMA_PRINCIPAL
         | token_identificador token_doisPontos TIPO_VARIAVEL token_pontoVirgula token_fimVariaveis PROGRAMA_PRINCIPAL
;

PROGRAMA_PRINCIPAL : token_inicio BLOCO
;

ATRIBUICAO: token_identificador token_atribuicao EXPRESSAO token_pontoVirgula
;

NUMERO: token_real
        | token_inteiro
;

BLOCO: ATRIBUICAO BLOCO
       | token_fim
       
       //LISTA_COMANDOS BLOCO
;
           
EXPRESSAO: EXPRESSAO token_operadorMais TERMO
            | EXPRESSAO token_operadorMenos TERMO
            | TERMO
;

TERMO: TERMO token_operadorVezes FATOR
        | TERMO token_operadorDividir FATOR
        | FATOR
;

FATOR: NUMERO
       | token_identificador
;
/*
COMANDO_IF: COMANDO_ASSOCIADO
            | COMANDO_NAO_ASSOCIADO
;

COMANDO_ASSOCIADO: token_se EXPRESSAO token_entao COMANDO_ASSOCIADO token_senao COMANDO_ASSOCIADO
                | COMANDOS_BASICOS
;

COMANDO_NAO_ASSOCIADO: token_se EXPRESSAO token_entao COMANDO_IF
                        | token_se EXPRESSAO token_entao COMANDO_ASSOCIADO token_senao COMANDO_NAO_ASSOCIADO
;

COMANDOS_BASICOS: COMANDO_IF
;

LISTA_COMANDOS: COMANDOS_BASICOS
                | COMANDO_NAO_ASSOCIADO*/

%%

#include "lex.yy.c"

main(){
	yyparse();
}

/* rotina chamada por yyparse quando encontra erro */
yyerror (void){
	printf("Erro na Linha: %d\n", line_num);
}

