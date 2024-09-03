/* Ionescu Valentin Stefan 332CC */
%{
#include <stdio.h>

int itemize_level = 0;
int enumerate_level = 0;
int NrCuvinte = 0;

%}

%x TITLE Section quot verbatim  HREF Sterge HrefTitle 
%s ordonat neordonat Item Item2
cuvant [A-Za-z0-9][^' ''\n'\\{}]*
%option stack

%%

\\title(\{[^\}]*\})+  {
                /* regula pentru extragea titlului */ 
                /* exclud paranteza de la final */
                yyless(yyleng-1);
                printf("%s\n",yytext+7);
                printf("==========\n");
                }

\\.*section\{ { BEGIN(Section);printf("\n");
               /* regula pentru extragerea titlului de sectiune */ }

<Section>[^\}]* { 
            /* caut pana gasesc sfarsitul de paranteza,adica sfarsitul titlului */
            printf("%s\n",yytext);
            printf("----------\n");
            printf(" ");
            BEGIN(INITIAL); }

"\\begin{quotation}" {BEGIN(quot);
                      /* regula pentru inceputul mediului quotation */}

<quot>{cuvant} { /* regula pentru contorizarea numarului de cuvinte dintr-o linie */
                if(NrCuvinte == 0) {  
                    printf("> ");
                }
                NrCuvinte++; 
                printf("%s ",yytext);
                if (NrCuvinte ==10) {
                    NrCuvinte = 0;
                    printf("\n");
                    }
                }

<quot>"\\end{quotation}" {BEGIN(INITIAL);
                            NrCuvinte = 0;
                            printf("\n");
                        }

<quot>" " {/* reguli folosite pentru a nu afisa spatiile,taburile si newline-urile de final */}
<quot>^"\n" { printf(">\n");}
<quot>"\t" { }
<quot>"\n" { }


"\\begin{verbatim}" {BEGIN(verbatim);/* regula pentru inceputul mediului verbatim */}

<verbatim>"\\end{verbatim}" {BEGIN(INITIAL);/* regula pentru sfarsitul mediului verbatim */}

<verbatim>.* { printf("    %s",yytext);/* regula pentru afisarea textului din mediul verbatim */}

"\\href{" { BEGIN(HREF); }

<HREF>[^{]* {
    /* regula pentru extragerea link-ului */
    /* caut pana gasesc inceputul de paranteza,adica sfarsitul link-ului */
    yyless(yyleng-1);
    printf("[%s]", yytext ); 
    /* urmeaza numele link-ului intre acolade */
    BEGIN(HrefTitle); 
}
<HrefTitle>"}" {/* sterg paranteza exclusa din regula anterioara */ }

<HrefTitle>(\{[^\}]*\})+ { yyless(yyleng- 1);
                           printf("(%s) ",yytext+1); 
                           BEGIN(INITIAL);
                           /* regula pentru extragerea titlului link-ului */
                           /* extrag ce se afla intre acoladele  */ }


"\\begin{itemize}" {itemize_level++; 
                    BEGIN(neordonat);
}

"\\begin{enumerate}" {enumerate_level++; 
                    BEGIN(ordonat);
                    }


"\\end{itemize}" {  if (itemize_level > 0) {
                        itemize_level--;
                    }
                    printf("\n");
                 }

"\\end{enumerate}"  {    if (enumerate_level > 0) {
                            enumerate_level--;
                        }
                        printf("\n");
                    }

<neordonat>"\\item" { /* daca gasesc un item,afisez inceputul de linie cerut */
                    BEGIN(Item);
                    printf("\n");
                    for(int i = 0;i<itemize_level;i++)
                        printf("   ");
                    printf("-");
                    }

<ordonat>"\\item" {/* daca gasesc un item,afisez inceputul de linie cerut */
                    BEGIN(Item2);
                    printf("\n");
                    for(int i = 0;i<enumerate_level;i++)
                        printf("   ");
                    printf("1.");
                    }
                    
\\textbf(\{[^}]*\})+ {  /* reguli pentru transformarea textului in bold,italic,emph si texttt */
                        /* asemantor cu regula de titlu */
                        yyless(yyleng -1);
                        printf("**%s**",yytext+8);}

\\textit(\{[^}]*\})+ { yyless(yyleng -1);
                            printf("_%s_",yytext+8);} 

\\emph(\{[^}]*\})+ { yyless(yyleng -1);
                            printf("_%s_",yytext+6);} 

\\texttt(\{[^}]*\})+ { yyless(yyleng -1);
                            printf("`%s`",yytext+8);} 

<Item>"\n" {/*afisez orice carcater pana la intalnirea sfaristului de linie */
            /* adica sfarsitul item-ului */
            BEGIN(neordonat);}

<Item2>"\n" {BEGIN(ordonat);}

<neordonat>"\n" { /*sterg newline-urile generate de flex pentru starea actuala */ }

"\t"* {/* sterg taburile  */ }

^[" "]+ {/* sterg spatiile de la inceputul liniei */ }

"}" {/* sterg acolada exclusa de la fiecare regula */ }

[" "]*%.* { /* sterg comentariile */ }

\{[^}]*\} { /* sterg orice se afla in acolade,si nu a fost o regula */ }

\\[a-zA-Z] {/* regula pentru a sterge directivele latex */ 
            yy_push_state(Sterge);}

<Sterge>[a-zA-Z0-9]*(\[[^\]]*\])+ {/*sterg orice directiva urmata de paranteze sau paranteze patrate */
                                    yy_pop_state();}

<Sterge>[a-zA-Z0-9]*(\([^\)]*\))+ {  yy_pop_state();}

<Sterge>[^" ""\n".!?\{]* { yy_pop_state();/* sterg directiva pana la intalnirea caracterelor mentionate in regula */}

<INITIAL>".\n" { printf(".\n");/*regula pentru a nu afisa newline-urile dupa caracterul punct */}

^"\n" { printf("\n");/*regula pentru a afisa newline-urile de la inceputul liniei */}

<INITIAL>[a-zA-Z]"\n" {/* sterg newline-urile de la sfarsit de linie */ 
                        yytext[yyleng-1]=' ';
                        printf("%s",yytext);
                        }

"\n" {/* sterg orice alt newline */ }

%%


int main( int argc, char **argv ) {
yyin = fopen(argv[1], "r");
if (!yyin)
{ printf("!!!eroare!!!");}
yylex();
return 0;
}