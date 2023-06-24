%{
#include <stdio.h>
#include "y.tab.h"
int lineCounter = 1;
void yyerror (char *s);
int yylex();
%}


INTEGER [-]?[1-9][0-9]*|0
IDENTIFIER [a-z][a-zA-Z0-9_]*
NEWLINE [\n]
STRING ["].*["]
COMMENT [\/][\/].*


%%

"START"             return(START);
"END"               return(END);
"print"             return(PRINT);
"("                 return(LPAREN);
")"                 return(RPAREN);
"{"                 return(LBRACE);
"}"                 return(RBRACE);
"+"                 return(PLUS); 
"-"                 return(MINUS);
"*"                 return(MULTIPLY);
"/"                 return(DIVIDE);
"%"                 return(MOD);
"="                 return(ASSIGN);
";"                 return(SEMICOLON);
","                 return(COMMA);
"=="                return(EQUAL);
"!="                return(NOTEQUAL);
"<"                 return(LESS);
"<="                return(LESSEQUAL);
">"                 return(GREATER);
">="                return(GREATEREQUAL);
"&&"                return(AND);
"||"                return(OR);
"/n"                return(NEWLINE);
"if"                return(IF);
"else"              return(ELSE);
"else if"           return(ELSEIF);
"while"             return(WHILE); 
{IDENTIFIER}        {yylval.id = yytext[0]; return IDENTIFIER;}
{INTEGER}           {yylval.num = atoi(yytext); return NUMBER;}
{STRING}            {
                        char* str = malloc(yyleng - 2); 
                        strncpy(str, yytext + 1, yyleng - 2);
                        yylval.str = str;
                        return STRING;
                    }
{COMMENT}           return (COMMENT);      
{NEWLINE}           {lineCounter++;}

[ \t\r]             ;
.                   {yyerror ("unexpected character");}


%%


int yywrap(void) {
    return 1;
}