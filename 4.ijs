#!/usr/bin/env jconsole
text =. (1!:1) 3                                         NB. read input as a char array
unwantedSymbols =. ',-',4&u:10                           NB. ',-\n'
cleantext=.' '((text e.unwantedSymbols)#(i.#text))}text  NB. replace unwanted symbols by whitespace
ns =. _1 ". cleantext                                    NB. parse numbers
ns =. 0 2 3 1 { |: (_4 ]\ ns)                            NB. reshape to rows with length 4, transpose, then permute columns
f =. *./ _2 (>:/)\ ns                                    NB. the first subrange contains the second
s =. *./ _2 (<:/)\ ns                                    NB. the second subrange contains the first
r =. +/ f +. s                                           NB. logic or and then sum
r (1!:2) 2                                               NB. print to stdout (fd = 2)
exit ''
