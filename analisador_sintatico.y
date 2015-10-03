%{
#include <stdio.h>
    
    extern int line_num;
%}

/* TOKENS DEFINICOES BASICAS */
%token token_identificador
%token token_inteiro
%token token_real
%token token_literal
%token token_caractere

/* TOKENS PALAVRAS RESERVADAS */
%token token_algoritmo
%token token_variaveis
%token token_fimVariaveis
%token token_inicio
%token token_fim
%token token_se
%token token_entao
%token token_senao
%token token_fimSe
%token token_de
%token token_verdadeiro
%token token_falso
%token token_enquanto
%token token_faca
%token token_fimEnquanto
%token token_para
%token token_ate
%token token_fimPara
%token token_funcao
%token token_retorne
%token token_passo

/* TOKENS TIPOS DE DADOS */
%token token_tipoReal
%token token_tipoInteiro
%token token_tipoCaractere
%token token_tipoLiteral
%token token_tipoLogico
%token token_tipoMatriz

/* TOKENS OPERADORES */
%token token_operadorAtribuicao
%token token_operadorPotencia
%token token_operadorSomaSoma
%token token_operadorSubtraiSubtrai
%token token_operadorPorcento
%token token_operadorMais
%token token_operadorMenos
%token token_operadorVezes
%token token_operadorDividir
%token token_operadorMaior
%token token_operadorMaiorIgual
%token token_operadorMenor
%token token_operadorMenorIgual
%token token_operadorIgualIgual
%token token_operadorDiferente
%token token_operadorE
%token token_operadorOu
%token token_operadorNao

/*TOKENS SIMBOLOS */
%token token_simboloPontoVirgula
%token token_simboloDoisPontos
%token token_simboloVirgula
%token token_simboloAbreParentese
%token token_simboloFechaParentese
%token token_simboloAbreColchete
%token token_simboloFechaColchete
%token token_simboloEspecial

%start ALGORITMO

%%

ALGORITMO
    : token_algoritmo token_identificador token_simboloPontoVirgula PROGRAMA
    ;

PROGRAMA
    : VARIAVEIS
    | PROGRAMA_PRINCIPAL
    ;

VARIAVEIS
    : token_variaveis DECLARACAO_VARIAVEL token_fimVariaveis PROGRAMA_PRINCIPAL
    ;


TIPO_VARIAVEL
    : token_tipoMatriz MATRIZ
    | TIPO_VARIAVEL_PRIMITIVO
    ;

TIPO_VARIAVEL_PRIMITIVO
    : token_tipoReal
    | token_tipoInteiro
    | token_tipoCaractere
    | token_tipoLiteral
    | token_tipoLogico 
    ;

MATRIZ
    : token_simboloAbreColchete token_inteiro token_simboloFechaColchete MATRIZ
    | token_simboloAbreColchete token_inteiro token_simboloFechaColchete token_de TIPO_VARIAVEL_PRIMITIVO
    ;

DECLARACAO_VARIAVEL
    : token_identificador token_simboloVirgula DECLARACAO_VARIAVEL
    | token_identificador token_simboloDoisPontos TIPO_VARIAVEL token_simboloPontoVirgula DECLARACAO_VARIAVEL
    | token_identificador token_simboloVirgula token_fimVariaveis PROGRAMA_PRINCIPAL
    | token_identificador token_simboloDoisPontos TIPO_VARIAVEL token_simboloPontoVirgula
    ;

PROGRAMA_PRINCIPAL
    : token_inicio COMANDOS token_fim
    | token_inicio COMANDOS token_fim FUNCAO
    ;

COMANDOS
    : COMANDO_ATRIBUICAO token_simboloPontoVirgula COMANDOS
    | COMANDO_ENQUANTO COMANDOS
    | COMANDO_SE COMANDOS
    | COMANDO_CHAMADA_FUNCAO token_simboloPontoVirgula COMANDOS
    | COMANDO_PARA COMANDOS
    |
    ;

COMANDO_ATRIBUICAO
    : token_identificador token_operadorAtribuicao COMANDO_CHAMADA_FUNCAO
    | token_identificador token_operadorAtribuicao EXPRESSAO_COMPLETA
    ;

COMANDO_ENQUANTO
    : token_enquanto EXPRESSAO_COMPLETA token_faca COMANDOS token_fimEnquanto
    ;

COMANDO_SE
    : token_se EXPRESSAO_COMPLETA token_entao COMANDOS token_senao COMANDOS token_fimSe
    | token_se EXPRESSAO_COMPLETA token_entao COMANDOS token_fimSe
    ;

COMANDO_PARA
    : token_para token_identificador token_de EXPRESSAO_COMPLETA token_ate EXPRESSAO_COMPLETA token_passo NUMERO token_faca COMANDOS token_fimPara
    | token_para token_identificador token_de EXPRESSAO_COMPLETA token_ate EXPRESSAO_COMPLETA token_faca COMANDOS token_fimPara
    ;

COMANDO_CHAMADA_FUNCAO
    : token_identificador token_simboloAbreParentese token_simboloFechaParentese
    | token_identificador token_simboloAbreParentese PARAMETRO_FUNCAO_CHAMADA_FUNCAO token_simboloFechaParentese
    ;

PARAMETRO_FUNCAO_CHAMADA_FUNCAO
    : EXPRESSAO_COMPLETA token_simboloVirgula PARAMETRO_FUNCAO_CHAMADA_FUNCAO
    | COMANDO_CHAMADA_FUNCAO token_simboloVirgula PARAMETRO_FUNCAO_CHAMADA_FUNCAO
    | EXPRESSAO_COMPLETA
    | COMANDO_CHAMADA_FUNCAO
    ;

FUNCAO
    : DECLARACAO_FUNCAO FUNCAO
    | DECLARACAO_FUNCAO
    ;

DECLARACAO_FUNCAO
    : token_funcao ARGUMENTOS_DECLARACAO_FUNCAO token_simboloDoisPontos TIPO_VARIAVEL_PRIMITIVO DECLARACAO_VARIAVEL token_inicio COMANDOS COMANDO_RETORNE token_fim
    | token_funcao ARGUMENTOS_DECLARACAO_FUNCAO token_simboloDoisPontos TIPO_VARIAVEL_PRIMITIVO token_inicio COMANDOS COMANDO_RETORNE token_fim
    ;

ARGUMENTOS_DECLARACAO_FUNCAO
    : token_identificador token_simboloAbreParentese token_simboloFechaParentese
    | token_identificador token_simboloAbreParentese PARAMETRO_DECLARACAO_FUNCAO token_simboloFechaParentese
    ;

PARAMETRO_DECLARACAO_FUNCAO
    : token_identificador token_simboloDoisPontos TIPO_VARIAVEL token_simboloVirgula PARAMETRO_DECLARACAO_FUNCAO
    | token_identificador token_simboloDoisPontos TIPO_VARIAVEL
    ;

COMANDO_RETORNE
    : token_retorne EXPRESSAO_COMPLETA token_simboloPontoVirgula COMANDOS
    | token_retorne token_simboloPontoVirgula COMANDOS
    ;

NUMERO
    : token_real
    | token_inteiro
    ;

EXPRESSAO_COMPLETA
    : EXPRESSAO
    | EXPRESSAO token_operadorDiferente EXPRESSAO
    | EXPRESSAO token_operadorMenor EXPRESSAO
    | EXPRESSAO token_operadorMenorIgual EXPRESSAO
    | EXPRESSAO token_operadorMaior EXPRESSAO
    | EXPRESSAO token_operadorMaiorIgual EXPRESSAO
    ;

EXPRESSAO
    : EXPRESSAO token_operadorMais TERMO
    | EXPRESSAO token_operadorMenos TERMO
    | EXPRESSAO token_operadorOu TERMO
    | TERMO
    ;

TERMO
    : TERMO token_operadorVezes FATOR
    | TERMO token_operadorDividir FATOR
    | TERMO token_operadorE FATOR
    | TERMO token_operadorPorcento FATOR
    | TERMO token_operadorIgualIgual FATOR
    | TERMO token_operadorPotencia FATOR
    | FATOR
    ;

FATOR
    : NUMERO
    | OPERADORES_MAIS_MAIS_MENOS_MENOS
    | CONSTANTES_LOGICA
    | token_literal
    | token_caractere
    | token_identificador
    | token_operadorNao token_identificador
    | token_simboloAbreParentese EXPRESSAO token_simboloFechaParentese
    | token_operadorNao token_simboloAbreParentese EXPRESSAO token_simboloFechaParentese
    ;

OPERADORES_MAIS_MAIS_MENOS_MENOS
    : token_operadorSomaSoma NUMERO
    | NUMERO token_operadorSomaSoma
    | token_operadorSubtraiSubtrai NUMERO
    | NUMERO token_operadorSubtraiSubtrai
    | token_operadorSomaSoma token_identificador
    | token_identificador token_operadorSomaSoma
    | token_operadorSubtraiSubtrai token_identificador
    | token_identificador token_operadorSubtraiSubtrai
    ;

CONSTANTES_LOGICA
    : token_verdadeiro
    | token_falso
    ;

%%

#include "lex.yy.c"

main(){
	yyparse();
}

/* rotina chamada por yyparse quando encontra erro */
yyerror (void){
	printf("Erro na Linha: %d\n", line_num);
}

