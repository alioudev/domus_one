LEX = base_lex2.lex
CUP = base_cup.cup

parser.class :    parser.java sym.java Yylex.java
	javac $^

parser.java:    $(CUP) Yylex.java
	cup $<

Yylex.java :    $(LEX)
	jflex $<

clear :
	rm *.class *.java *.java~ *.class~ *.lex~ *.*.cup~