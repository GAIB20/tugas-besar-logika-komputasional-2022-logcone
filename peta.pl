:-dynamic(map/1).
resCal :- retract(map(_)), fail.
resCal.

startMap(
/* Bentuk dari map awal*/
[['              ','    ','    ','    ','    ','    ','    ','    ','    ','    ','              '],
 ['    ','    ',' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  ','    ','    '],
 ['    ','    ',' |  FP  |  E1  |  E2  |  E3  |  CC  |  F1  |  F2  |  F3  |  WT  | ','    ','    '],
 ['    ','    ',' |  D3  | - - - - - - - - - - - - - - - - - - - - - - -  |  G1  | ','    ','    '],
 ['    ','    ',' |  D2  |                                                |  G2  | ','    ','    '],
 ['    ','    ',' |  D1  |                                                |  G3  | ','    ','    '],
 ['    ','    ',' |  TX  |                M O N O P O L Y                 |  TX  | ','    ','    '],
 ['    ','    ',' |  C3  |                                                |  CC  | ','    ','    '],
 ['    ','    ',' |  C2  |                                                |  H1  | ','    ','    '],
 ['    ','    ',' |  C1  | - - - - - - - - - - - - - - - - - - - - - - -  |  H2  | ','    ','    '], 
 ['    ','    ',' |  JL  |  B3  |  B2  |  B1  |  CC  |  A3  |  A2  |  A1  |  GO  | ','    ','    '],
 ['    ','    ',' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  ','    ','    '],
 ['              ','    ','    ','    ','    ','    ','    ','    ','    ','    ','              ']]
).


/* Getters and Setters of a map */
getElmtList([H | _], 1, H):-!.
getElmtList([H | T], Index, Val):-
    Index1 is Index - 1,
    getElmtList(T, Index1, Val),!.

getElmtMap(Map, X, Y, Val):-
/* Mendapatkan value dari map dengan index X, Y */
    getElmtList(Map, X, ValX),
    getElmtList(ValX, Y, Val).

setElmtList([_|T], 1, Value, [Value|T]).
setElmtList([H|T], Index, Value, [H|R]):- 
    Index > 0, 
    Index1 is Index-1, 
    setElmtList(T, Index1, Value, R), !.
setElmtList(L, _, _, L).

setElmtMap(MapIn, X, Y, Val, MapOut):-
/* Mengubah map pada index X, Y menjadi Val */
    getElmtList(MapIn, X, ValX),
    setElmtList(ValX, Y, Val, ListOut),
    setElmtList(MapIn, X, ListOut, MapOut).


/* Display Map */
printList([A]):-write(A),nl,!.
printList([A|T]):-write(A),printList(T).

displayMap([A]):-printList(A),nl,!.
displayMap([A|T]):-printList(A),nl,printMap(T).


/* Operation of a Map */
initMap:-resCal,startMap(M),assertz(map(M)),printMap(M).
