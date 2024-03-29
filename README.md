﻿# 🔎 Flex and Bison Parser for Android XML Subset
This repository contains a complete implementation of a lexer and parser using Flex and Bison tools for a subset of the XML notation used in Android application development, specifically focusing on elements related to the User Interface (UI). The lexer and parser analyze input files which are written in this subset of XML and determine if the program is syntactically correct.
## 📸 Screenshots:
### Success: Program Executed Successfully
![success](https://github.com/akispapapanagiotou/flex-and-bison-parser/assets/111454100/6126a471-3925-4482-a312-56cc5a4853ce)
### Failure: Program Execution Error
![failure](https://github.com/akispapapanagiotou/flex-and-bison-parser/assets/111454100/a6d23cca-b9b2-4c9f-a459-343f39df37c3)
### Failure: Duplicate ID Error
![failure - duplicate ID](https://github.com/akispapapanagiotou/flex-and-bison-parser/assets/111454100/2f2804a9-5c7f-44dc-a4e7-ed591149857e)
## ▶️ How to run:
Clone the repository:
```
git clone https://github.com/akispapapanagiotou/flex-and-bison-parser.git
```
Compile the source code using the following commands:
```
flex lexer.l
bison -d syntax.y
gcc -o myParser lex.yy.c syntax.tab.c -lfl
```
Execute the program by running the following command but first replace file_name with the name of the input file written in the XML subset:
```
./myParser file_name
```
## 🛠️ Built with:
- Flex: A fast lexical analyzer generator.
- Bison: A general-purpose parser generator.
- C programming language: Used for implementing the main program logic.
