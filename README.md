# LaTeX to Markdown Converter
## Problem Description

The goal is to convert simple, correctly formatted LaTeX documents into Markdown format. The program must correctly handle a variety of LaTeX commands and environments, converting them to their corresponding Markdown equivalents.


In a LaTeX document, commands and environments can appear. Commands may have no arguments (e.g., <b>\clearpage</b>), one or more arguments (e.g.,  <b>\href{http://www.example.com}{Example} </b>), and may have optional arguments (e.g., <b> \subsection[short title]{title} or \item[+]  </b>).

Environments are characterized by a beginning and an end, e.g.,  <b> \begin{itemize} ... \end{itemize}.  </b>
Conversion Rules

## The following elements will be converted:

-  <b> Document Title: </b>
      The argument of the  <b> \title  </b> command is converted to a Markdown title with double underlining (10 = symbols will be used regardless of the title's length).
-  <b>Section Titles: </b> The argument of any command in the form of  <b> \*section (i.e., \section, \subsection, etc.)  </b>is converted to a Markdown title with single underlining (10 - symbols will be used regardless of the title's length).
 -  <b>Text Formatting Commands:  </b>
       - \textbf → bold
       - \textit, \emph → italic
       - \texttt → code
-  <b>Quotation Environment: </b> The content of the  <b>quotation </b> environment is converted to a blockquote. In the .md format, no more than 10 words per line will be used. Citations will not contain other commands and will not be nested within other environments.
-  <b> Verbatim Environment: </b>The content of a  <b> verbatim  </b> environment is converted to a code block — all text is copied identically but indented with 4 spaces. A verbatim environment will not be nested within other environments.
-  <b>Unordered Lists:  </b> An <b> itemize  </b> environment is converted to an unordered list.
-  <b> Ordered Lists:  </b> An  <b>enumerate </b> environment is converted to an ordered list.
-  <b> Nested Lists:  </b> The program will support any level of nested lists, but only lists of the same type (only itemize or only enumerate) can be nested. The nesting level and indentation display can be managed using C code.
-  <b>Links: </b> A link obtained through the  <b> \href  </b> command is converted to a Markdown link.
-   <b> Ignored Elements:  </b>
    - Any other LaTeX commands will not be displayed.
     - LaTeX comments will not appear in the output.
     - Text within braces (outside of the aforementioned cases) will not be displayed.
     - For any other environment, the start and end directives will be ignored, and their content will be processed according to the rules outlined.

## How to Run

To compile and run the program, use the following commands:

```bash
$ gcc -o latex_to_md latex_to_md.c
$ ./latex_to_md input.tex output.md
```
Where:
 - input.tex is the LaTeX file you want to convert.
  - output.md is the resulting Markdown file.
