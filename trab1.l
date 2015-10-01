%{
    #include <string.h>
    #include <stdlib.h>
    int line_num = 1;
    int comment_caller;
     
%}

/* definicao de digitios */
ALGORITMO "algoritmo"
VARIAVEIS "variaveis"
FIM_VARIAVEIS "fim-variaveis"
INICIO "inicio"
FIM "fim"
PALAVRA_RESERVADA_SE "se"
PALAVRA_RESERVADA_ENTAO "entao"
PALAVRA_RESERVADA_SENAO "senao"
PALAVRA_RESERVADA_FIMSE "fim-se"
PALAVRA_RESERVADA_MATRIZ "matriz"
PALAVRA_RESERVADA_DE "de"
PALAVRA_RESERVADA_VERDADEIRO "verdadeiro"
PALAVRA_RESERVADA_FALSO "falso"
PALAVRA_RESERVADA "enquanto"|"faca"|"fim-enquanto"|"para"|"ate"|"fim-para"|"funcao"|"retorne"|"passo"
IDENTIFICADOR {CHAR}("_"|{CHAR}|{INTEIRO})*
INTEIRO [0-9]
CHAR [a-zA-Z]
REAL {INTEIRO}+"."{INTEIRO}+
CARACTERE "'"{CHAR}"'"
LOGICO "verdadeiro"|"falso"
TIPO "real"|"inteiro"|"caractere"|"literal"|"logico"
TIPO_REAL "real"
TIPO_INTEIRO "inteiro"
TIPO_CARACTERE "caractere"
TIPO_LITERAL "literal"
TIPO_LOGICO "logico"
OPERADOR_ARITMETICO "^"|"++"|"--"
OPERADOR_PORCENTO "%"
OPERADOR_MAIS "+"
OPERADOR_MENOS "-"
OPERADOR_VEZES "*"
OPERADOR_DIVIDIR "/"
OPERADOR_MAIOR ">"
OEPRADOR_MAIORIGUAL ">="
OPERADOR_MENOR "<"
OPERADOR_MENORIGUAL "<="
OPERADOR_IGUALIGUAL "=="
OPERADOR_DIFERENTE "<>"
OPERADOR_E "e"
OPERADOR_OU "ou"
OPERADOR_NAO "nao"
SIMBOLO_PONTOVIRGULA ";"
SIMBOLO_DOISPONTOS ":"
SIMBOLO_VIRGULA ","
SIMBOLO_ABREPARENTESE "("
SIMBOLO_FECHAPARENTESE ")"
SIMBOLO_ABRECOLCHETE "["
SIMBOLO_FECHACOLCHETE "]"
SIMBOLO_ESPECIAL "\""|"."|"{"|"}"|"#"|"'"|"\\"
ATRIBUICAO "="
COMENTARIO_LINHA "//"(.)*
LITERAL "\""[^"]*"\""
%x comment stringSequence

%%
"/*" {
    comment_caller = INITIAL;
    BEGIN(comment);
}

{COMENTARIO_LINHA}          {}
{LITERAL}                   {return token_literal;}
{LOGICO}                    {return token_logico;}
{REAL}                      {return token_real;}
{INTEIRO}+                  {return token_inteiro;}
{CARACTERE}                 {return token_caracter;}
{ALGORITMO}                 {return token_algoritmo;}
{VARIAVEIS}                 {return token_variaveis;}
{FIM_VARIAVEIS}             {return token_fimVariaveis;}
{TIPO_REAL}                 {return token_tipoReal;}
{TIPO_INTEIRO}              {return token_tipoInteiro;}
{TIPO_CARACTERE}            {return token_tipoCaractere;}
{TIPO_LITERAL}              {return token_tipoLiteral;}
{TIPO_LOGICO}               {return token_tipoLogico;}
{INICIO}                    {return token_inicio;}
{FIM}                       {return token_fim;}
{PALAVRA_RESERVADA_SE}      {return token_se;}
{PALAVRA_RESERVADA_ENTAO}   {return token_entao;}
{PALAVRA_RESERVADA_SENAO}   {return token_senao;}
{PALAVRA_RESERVADA_FIMSE}   {return token_fimSe;}
{PALAVRA_RESERVADA_MATRIZ}  {return token_tipoMatriz;}
{PALAVRA_RESERVADA_DE}      {return token_de;}
{PALAVRA_RESERVADA_FALSO}   {return token_falso;}
{PALAVRA_RESERVADA_VERDADEIRO} {return token_verdadeiro;}
{PALAVRA_RESERVADA}         {return token_palavraReservada;}
{ATRIBUICAO}                {return token_atribuicao;}
{OPERADOR_MAIS}             {return token_operadorMais;}
{OPERADOR_MENOS}            {return token_operadorMenos;}
{OPERADOR_VEZES}            {return token_operadorVezes;}
{OPERADOR_DIVIDIR}          {return token_operadorDividir;}
{OPERADOR_PORCENTO}         {return token_porcento;}
{OPERADOR_ARITMETICO}       {return token_operadorAritmetico;}
{OEPRADOR_MAIORIGUAL}       {return token_maiorIgual;}
{OPERADOR_MENORIGUAL}       {return token_menorIgual;}
{OPERADOR_MAIOR}            {return token_maior;}
{OPERADOR_MENOR}            {return token_menor;}
{OPERADOR_IGUALIGUAL}       {return token_igualIgual;}
{OPERADOR_E}                {return token_e;}
{OPERADOR_OU}               {return token_ou;}
{OPERADOR_NAO}              {return token_nao;}
{OPERADOR_DIFERENTE}        {return token_diferente;}
{SIMBOLO_PONTOVIRGULA}      {return token_pontoVirgula;}
{SIMBOLO_DOISPONTOS}        {return token_doisPontos;}
{SIMBOLO_VIRGULA}           {return token_virgula;}
{SIMBOLO_ABREPARENTESE}     {return token_abreParentese;}
{SIMBOLO_FECHAPARENTESE}    {return token_fechaParentese;}
{SIMBOLO_ABRECOLCHETE}      {return token_abreColchete;}
{SIMBOLO_FECHACOLCHETE}     {return token_fechaColchete;}
{SIMBOLO_ESPECIAL}          {return token_simboloEspecial;}
{IDENTIFICADOR}             {return token_identificador;}
[ \t]                       ; /* sao ignorados */
.                           {}
[\n]                        line_num++;

<comment>([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/ { /*procura por qualquer coisa que termine com final de comentario */
                                                    int i = 0, count = 0;
                                                    for (i=0, count=0; i < strlen(yytext); i++)
                                                        count += (yytext[i] == '\n');
                                                    line_num += count;
                                                    BEGIN(comment_caller);
                                                }
<comment>.                                      { /*se nao encontrar o final do comentario, volta ao inicio avaliando normalmente */
                                                    printf ("/: OPERADORARITMETICO\n");
                                                    printf ("*: OPERADORARITMETICO\n");
                                                    BEGIN(comment_caller);
                                                }
                                                
<stringSequence>(\\.|[^"])*\" { /*procura por qualquer coisa que termine com aspas duplas */
                                                    /*"\"" {
                                                            comment_caller = INITIAL;
                                                            BEGIN(stringSequence);
                                                            
                                                            }*/
                                                    int i = 0, count = 0;
                                                    for (i=0, count=0; i < strlen(yytext); i++){                  
                                                        count += (yytext[i] == '\n');
                                                    }
                                                    char* plainText = (char*)malloc((strlen(yytext)+1)*sizeof(char));
                                                    plainText[0] = '\"';
                                                    for (i=0; i < strlen(yytext); i++){                  
                                                       plainText[i+1] = yytext[i];
                                                    }
                                                    printf ("%s: LITERAL\n", plainText); 
                                                    line_num += count;
                                                    BEGIN(comment_caller);
                                                }
<stringSequence>.                               { /*se nao encontrar o final da string, volta ao inicio avaliando normalmente */
                                                    printf ("\": SIMBOLOESPECIAL\n");
                                                    BEGIN(comment_caller);
                                                }
%%