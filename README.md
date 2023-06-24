<h1 align="center"> "Core" Programming Language </h3>

*Group Members*:
- [Ali Çolak](https://github.com/alicolak64)
- [İsmail Şengül](https://github.com/ismailsengul)
- [Emre Eldemir](https://github.com/emreeldemir)

---

## Description and Design Decisions

In the world of computer programming, we are a group of brilliant young developers who are frustrated with the limitations of existing programming languages. We long for a language that is simple, elegant, and powerful, one that will allow us to express our ideas in a way that is both efficient and intuitive.

So, we set out to create our own programming language, spending countless hours brainstorming, coding, testing, and refining our creation. We call it **"Core"** with the **".core"** extension.

The name "Core" was not chosen lightly. It is a nod to the heart of computing, the central processing unit (CPU), which is often referred to as the "core" of a computer. The CPU is responsible for executing instructions and performing calculations at the heart of every computer system.

We see our language, Core, as a kind of "core" for programming. It is designed to be the foundation upon which all other software can be built. It is meant to be simple enough for beginners to learn.

As stated in the instruction, we have defined terminal values ​​such as characters, integers, floating point numbers, text, true/false (boolean) operators,  functions and conditional expressions as well as constants and variables, included basic input/output (IO) expressions.

While designing our language, we got help and inspiration from many languages such as C/C++. In Core Language, all programs start with the keyword *"START"* and end with the keyword *"END"*. Our language is a procedural language and programs consist of if, while, for etc. similar structures and for this reason, things work in our language by calling the procedures.

---

## Running Instructions

```
make core 
```

```
 ./core < exampleprog1.core
```
...( some output )...

```
make clean
```
---

## BNF Form

```

<program> : <startStatement> <statements> <endStatement>

<statements> : <statement> <statements> | <statement>

<statement> : <printStatement> SEMICOLON 
                | <assignmentStatement> SEMICOLON
                | <ifStatement> 
                | <whileStatement> 
                | <endStatement> 
                | <startStatement> 
                | <commentStatement>

<term> : NUMBER
        | IDENTIFIER

<stringTerm> : STRING
              | IDENTIFIER

<expression> : <term>
              | <expression> PLUS <expression>
              | <expression> MINUS <expression>
              | <expression> MULTIPLY <expression>              
              | <expression> DIVIDE <expression>
              | <expression> MOD <expression>
              | <expression> EQUAL <expression>
              | <expression> NOTEQUAL <expression>
              | <expression> LESS <expression>
              | <expression> LESSEQUAL <expression>
              | <expression> GREATER <expression>
              | <expression> GREATEREQUAL <expression>
              | <expression> AND <expression>
              | <expression> OR <expression>
              | NOT <expression>
              | LPAREN <expression> RPAREN

<block> : LBRACE <statements> RBRACE

<printStatement> : PRINT LPAREN <stringTerm> RPAREN
                  | PRINT LPAREN <expression> RPAREN

<assignmentStatement> : IDENTIFIER ASSIGN <expression>
                       | IDENTIFIER ASSIGN <stringTerm>

<ifStatement> : IF LPAREN <expression> RPAREN <block>
               | IF LPAREN <expression> RPAREN <block> ELSE <block>
               | IF LPAREN <expression> RPAREN <block> <elseIfStatement> LPAREN <expression> RPAREN <block>
               | IF LPAREN <expression> RPAREN <block> <elseIfStatement> LPAREN <expression> RPAREN <block> ELSE <block>

<elseIfStatement> : ELSEIF LPAREN <expression> RPAREN <block>
                   | ELSEIF LPAREN <expression> RPAREN <block> <elseIfStatement>

<whileStatement> : WHILE LPAREN <expression> RPAREN <block>

<startStatement> : START

<endStatement> : END

<commentStatement> : COMMENT

```


## Explanation of the Syntax

- ### START-END STATEMENTS

The "START "keyword indicates that the program has started, and the "END" keyword indicates that the program is finished.

```
START

END
```

Output :
```
PROGRAM STARTED
PROGRAM FINISHED
```

- ### PRINT STATEMENT
The print() function is used to print a series of characters and values to the standard output.
```
print("Hello World!");
```

Output :
```
Hello World!
```

- ### COMMENTS
User can annotate code blocks with comment line. Code readability increases with comment lines. The program defines the comment line with two "//" characters. The command line consists of these characters and the sentence(s) between these characters.

```
 // This is a comment line
```

- ### ASSIGNMENT STATEMENTS

Assignment operations are done with the "=" operator. The expressions on the right side of the sign go through arithmetic operations, if any, and then the result is transferred to the variable to the left of the "=" sign.

```
a = 14;
b = 4;
print(a);
print(b)
```
Output :
```
14
4
```


- ### ARITHMETIC EXPRESSIONS

Arithmetic expressions; includes addition (+), subtraction (-), multiplication (*), division (/) and mode taking(%).

```
a = 14;
b = 4;
c = a + b;
print (c);
e = a * 3;
print (e);
f = b mod 3;
print (f);
```

Output :
```
18
42
1
```

- ### LOGIC EXPRESSIONS

Logic expressions can be operators that combine multiple boolean expressions or values and provide a single boolean output (such as AND, OR, etc.). The primary use of these boolean tools is to implement statements that control if decisions and while loops. There may be operators that compare values and return TRUE (1) or FALSE (0).

```
g = 3 > 5;
print(g);

h = 4 == 4;
print(h);
k = h || g;
print(k);
```

Output :
```
0
1
1
```
- ### IF STATEMENT

An if statement is a selection statement that allows more than one possible flow of control. An if statement lets you conditionally process a statement when the specified test expression, implicitly converted to bool , evaluates to true.
```
if (5 == 5) {
    print("If block is valid");
} 
```

Output :
```
If block is valid
```

- ### WHILE STATEMENT

The while statement allows you to repeatedly execute a block of statements as long as a condition is true.
```
d = 3;
while (d > 0) {
    d = d - 1;
    print(d);
} 
```

Output :
```
2
1
0
```

