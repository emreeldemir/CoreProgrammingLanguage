%{
    
void yyerror (char *s);
int yylex();

#include <stdio.h>   
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int symbols[52];
char *strings[52];

int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
void updateStringsVal(char symbol, char *val);
int computeSymbolIndex(char token);
char *stringsVal(char symbol);

%}

%union {
    int num; 
    char id; 
    char *str;
}

%start program

%token START END PRINT COMMENT NEWLINE
%token ASSIGN PLUS MINUS MULTIPLY DIVIDE MOD AND OR NOT
%token EQUAL NOTEQUAL GREATER LESS GREATEREQUAL LESSEQUAL
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA
%token IF ELSE ELSEIF WHILE

%token <id> IDENTIFIER
%token <str> STRING
%token <num> NUMBER

%type <id> assignmentStatement 
%type <num> expression term  
%type <str> stringTerm 

%left PLUS MINUS
%left MULTIPLY DIVIDE MOD
%left AND OR NOT ASSIGN
%left EQUALS NOTEQUAL GREATER LESS GREATEREQUAL LESSEQUAL
%left LPAREN RPAREN LBRACE RBRACE COMMA SEMICOLON COMMENT
 
%%

program: 
    startStatement statements endStatement {printf("Program is valid\n");}
;

statements: 
    statement statements {;}
    | statement {;}
;    

statement: 
    printStatement SEMICOLON {;}
    | assignmentStatement SEMICOLON {;}
    | ifStatement {;}
    | whileStatement {;}
    | endStatement {;}
    | startStatement {;}
    | commentStatement {;}

;

term: 
    NUMBER {$$ = $1;}
    | IDENTIFIER {$$ = symbolVal($1);}

stringTerm: 
    STRING {$$ = $1;}

expression: 
    term {$$ = $1;}
    | expression PLUS expression {$$ = $1 + $3;}
    | expression MINUS expression {$$ = $1 - $3;}
    | expression MULTIPLY expression {$$ = $1 * $3;}
    | expression DIVIDE expression { 
        if ($3 == 0) {
            yyerror("Error: Cannot divide by 0\n");
        } else {
            $$ = $1 / $3; 
        }
    }
    | expression MOD expression {$$ = $1 % $3;} 
    | expression EQUAL expression {$$ = $1 == $3;}
    | expression NOTEQUAL expression {$$ = $1 != $3;}
    | expression LESS expression {$$ = $1 < $3;}
    | expression LESSEQUAL expression {$$ = $1 <= $3;}
    | expression GREATER expression {$$ = $1 > $3;}
    | expression GREATEREQUAL expression {$$ = $1 >= $3;}
    | expression AND expression {$$ = $1 && $3;}
    | expression OR expression {$$ = $1 || $3;}
    | NOT expression {$$ = !$2;}
    | LPAREN expression RPAREN {$$ = $2;}
;
    
block:
    LBRACE statements RBRACE {;}
;

printStatement:
    PRINT LPAREN stringTerm RPAREN {
        if (strcmp($3, "/n") == 0) {
            printf("\n");
        } else {
           printf("%s\n", $3); 
        } 
    }
    | PRINT LPAREN expression RPAREN {printf("%d\n", $3);}
;

assignmentStatement: 
    IDENTIFIER ASSIGN expression       {updateSymbolVal($1,$3);}
    | IDENTIFIER ASSIGN stringTerm       {updateStringsVal($1,$3);}
;      


ifStatement:
    IF LPAREN expression RPAREN block { 
        if ($3) {
            // run $5
        } 
    }
    | IF LPAREN expression RPAREN block ELSE block {
        if ($3) {
            // run $5
        } else {
            // run $7
        }
    }
    | IF LPAREN expression RPAREN block elseIfStatement LPAREN expression RPAREN block {
        if ($3) {
            // run $5
        } else if ($8) {
            // run $10
        }
    }
    | IF LPAREN expression RPAREN block elseIfStatement LPAREN expression RPAREN block ELSE block {
        if ($3) {
            // run $5
        } else if ($8) {
            // run $10
        } else {
            // run $12
        }
    }
;

elseIfStatement:
    ELSEIF LPAREN expression RPAREN block {
        if ($3) {
            // run $5
        }
    }
    | ELSEIF LPAREN expression RPAREN block elseIfStatement {
    }
;  

whileStatement:
    WHILE LPAREN expression RPAREN block {
        while ($3){
            // run $5
        }
    }
;

startStatement:
    START      {printf("PROGRAM STARTED\n");}

endStatement: 
    END        {printf("PROGRAM FINISHED\n"); exit(EXIT_SUCCESS);}
; 

commentStatement:
    COMMENT  {printf("Comment is valid\n");}
;       
      
       
%%

int computeSymbolIndex(char token)
{
    int idx = -1;
    if(islower(token)){
        idx = token - 'a' + 26;
    }
    else if(isupper(token)){
        idx = token - 'A';
    }
    return idx;
}

int symbolVal(char symbol)
{
    int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

char *stringsVal(char symbol)
{
    int idx = computeSymbolIndex(symbol);
    printf("%s\n", strings[idx]);
    return strings[idx];
}


void updateSymbolVal(char symbol, int val)
{
    int idx = computeSymbolIndex(symbol);
    symbols[idx] = val;
}
void updateStringsVal(char symbol, char *val)
{
    int idx = computeSymbolIndex(symbol);
    strings[idx] = val;
}

int main(void){
    int i;
    for(i = 0; i < 52; i++){
        symbols[i] = 0;
        strings[i] = "";
    }
return yyparse();
}

extern int lineCounter;

void yyerror (char *s) {
    printf ("%s on line %d\n", s, lineCounter);
    exit (EXIT_FAILURE);
}