Ionescu Valentin Stefan 332CC

pentru realizarea temei m am folosit de stari si de stiva de stari

-pentru a extrage titlul am cautat dupa secventa: \title urmata de caracterul '{', orice caracter
care nu este '}' si la final de caracterul '}'.Pentru a nu afisa carcaterele { } ,am folosit yyless
si am printat de la carcaterul urmator de dupa {
-pentru a extrage section: am cautat dupa caracterul: \ urmata de orice carcater de oricate ori (.*)
si apoi de secventa 'section' si caracterul '{'. Astfel, daca s a dat match, intru intr o noua stare pentru 
a cauta continutul din section, folsoind [^\}]* (orice caracter care nu este } urmat de oricate ori)
-pentru liste m am folosit de o variabila pentru a retine cat spatiu adaug la inceput.Astfel,daca se 
gaseste secventa begin{itemize} sau begin{enumerate} cresc indexul variabilei
-invers pentru secventele cu end ,scad indexul variabilei
-dupa ce am gasit secventa de  begin{itemize} sau begin{enumerate} intru intr o stare specifica in care 
caut secventa "\item".Daca am gasit o,atuci ma pregatesc sa afisez caracterele ce urmeaza
(adaug carcaterul specific de inceput si spatiile necesare folosind un for).
-aflat in starea item,daca intalnesc carcaterul "\n",atunci item ul din lista s a incheiat si
revin in starea de dinainte de item.Astfel,pentru orice alt caracter precedat de "\n" se afiseza
Starile in care ajung pentru parsarea listei nu sunt exclusive,pentru a identifica secventele:
textbf textit emph texttt
-pentru secventele textbf textit emph texttt este identic ca si la title
-pentru quotation caut dupa secventa "\begin{quotation}" si intru intr o stare specifica
-pentru orice cuvant gasit in starea aceasta il afisez.Dupa 10 cuvinte gasite,pun un "\n" pentru
a afisa de la o noua linie.Cand gasesc "\end{quotation}" ies din starea respectiva,ajungand in starea
INITIAL
-asemanator pentru verbatim
-pentru linkuri,caut prima data dupa secventa "\\href{".daca o gasesc ,intru intr o stare noua
si afisez secventa de caractere pana intalnesc caracterul '{'.Daca intalnesc caracterul '{',
inseamna ca trb sa caut titlul linkului si intru intr o noua stare.In starea actuala,caut dupa
secventa aflata intre { },identic ca si la title si il afisez
-pentru a respecta identarea si spatierea:
    -sterg orice spatiere cu tab
    -sterg orice spatiu aflat la inceput de linie
    -sterg orice "\n" aflat la final
    -sterg orice "\n" gasit,fara cel de inceput de linie

sterg orice comentariu gasit(orice secventa de caractere dupa caracterul % pana la "\n")
sterg orice secventa de caractere aflate intre { }

pentru orice alta comanda ,ca sa nu afisez:
    caut dupa caracterul "\", urmat de o litera.Daca gasesc o potrivire,intru intr o alta stare
si caut pana la gasirea primei {,spatiului,semnelor de punctuatie sau pana la "\n" si nu il afisez
Daca gasesc caracterul ( sau [,caut pana la gasirea perechii lui (adica caracterul ) sau ] }






