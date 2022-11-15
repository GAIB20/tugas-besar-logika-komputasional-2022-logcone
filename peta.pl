:-dynamic(map/1).

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


/* Primitive Operation */
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
displayMap([A|T]):-printList(A),nl,displayMap(T).


getXY(IdxLokasi, X, Y):-
/* Get index matrix */
    IdxLokasi=<9,
    X is 13, 
    Y is (11 - IdxLokasi),!.
getXY(IdxLokasi, X, Y):-
/* Get index matrix */
    IdxLokasi>=10, IdxLokasi=<16, 
    X is 20 - IdxLokasi, 
    Y is 2,!.
getXY(IdxLokasi, X, Y):-
/* Get index matrix */
    IdxLokasi>=17, IdxLokasi=<25, 
    X is 1,
    Y is IdxLokasi - 15,!.    
getXY(IdxLokasi, X, Y):-
/* Get index matrix */
    IdxLokasi>=26, IdxLokasi=<32, 
    X is IdxLokasi - 22,
    Y is 4,!.        

getLocation(IdxLokasi, NamaLokasi):-
/* Menampilkan nama lokasi dari index lokasi */
    getElmtList(['GO', 'A1','A2','A3','CC','B1','B2','B3','JL','C1','C2','C3','TX','D1','D2','D3','FP',
                 'E1','E2','E3','CC','F1','F2','F3','WT','G1','G2','G3','TX','CC','H1','H2'], IdxLokasi, NamaLokasi).


/* Operation of a Map */
initMap:-startMap(M),assertz(map(M)),displayMap(M).