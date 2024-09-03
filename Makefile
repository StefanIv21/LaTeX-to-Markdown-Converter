#Ionescu Valentin Stefan 332CC
make:
	flex tema.l
	gcc lex.yy.c -o tema -lfl

clean:
	rm -rf lex.yy.c tema
