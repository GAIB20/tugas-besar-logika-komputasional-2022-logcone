:-dynamic(map/1).
% :-include('player.pl').
% :-include('chanceCard.pl').
% :-include('properti.pl').

startMap(
/* Bentuk dari map awal*/
[['              ','    ','    ','    ','    ','    ','    ','    ','    ','    ','              '],
 ['    ','    ',' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  ','    ','    '],
 ['    ','    ',' |  FP  |  E1  |  E2  |  E3  |  CC2 |  F1  |  F2  |  F3  |  WT  | ','    ','    '],
 ['    ','    ',' |  D3  | - - - - - - - - - - - - - - - - - - - - - - -  |  G1  | ','    ','    '],
 ['    ','    ',' |  D2  |                                                |  G2  | ','    ','    '],
 ['    ','    ',' |  D1  |                                                |  G3  | ','    ','    '],
 ['    ','    ',' |  TX1 |                M O N O P O L Y                 |  TX2 | ','    ','    '],
 ['    ','    ',' |  C3  |                                                |  CC3 | ','    ','    '],
 ['    ','    ',' |  C2  |                                                |  H1  | ','    ','    '],
 ['    ','    ',' |  C1  | - - - - - - - - - - - - - - - - - - - - - - -  |  H2  | ','    ','    '], 
 ['    ','    ',' |  JL  |  B3  |  B2  |  B1  |  CC1 |  A3  |  A2  |  A1  |  GO  | ','    ','    '],
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

displayBoard:-
    retract(list_player(ListNama, Giliran)),
    getElmtList(ListNama, 1, Nama1), getElmtList(ListNama, 2, Nama2),
    retract(lokasi_pemain(Nama1, Lokasi1)),
    retract(lokasi_pemain(Nama2, Lokasi2)),
    assertz(lokasi_pemain(Nama1, Lokasi1)),
    assertz(lokasi_pemain(Nama2, Lokasi2)),
    getLocation(Lokasi1, NamaLokasi1),
    getLocation(Lokasi2, NamaLokasi2),
    retract(map(M)),
    displayMap(M),
    assertz(map(M)),
    write('                 Posisi pemain: '),nl,
    write('                 '),write(Nama1),write(': '),write(NamaLokasi1),nl,
    write('                 '),write(Nama2),write(': '),write(NamaLokasi2),nl,nl,
    getElmtList(ListNama, Giliran, NamaGiliran),
    write('                 '),write('Sekarang giliran '),write(NamaGiliran),
    assertz(list_player(ListNama, Giliran)).

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
    getElmtList(['GO', 'A1','A2','A3','CC1','B1','B2','B3','JL','C1','C2','C3','TX1','D1','D2','D3','FP',
                 'E1','E2','E3','CC2','F1','F2','F3','WT','G1','G2','G3','TX2','CC3','H1','H2'], IdxLokasi, NamaLokasi).

getIndexOf([Val|_], Val, 1):- !.
getIndexOf([_|T], Val, Index):-
  getIndexOf(T, Val, Index1),!,
  Index is Index1+1.

getMapIndex(NamaLokasi, IdxLokasi):-
/* Menampilkan index lokasi dari nama lokasi*/
    getIndexOf(['GO', 'A1','A2','A3','CC1','B1','B2','B3','JL','C1','C2','C3','TX1','D1','D2','D3','FP',
                'E1','E2','E3','CC2','F1','F2','F3','WT','G1','G2','G3','TX2','CC3','H1','H2'], NamaLokasi, IdxLokasi).

checkLocation(Nama, Index):-
    % Untuk dapet Chance Card
    (
        ((Index =:= 5 ; Index =:= 21; Index =:= 30) -> chanceCard(Nama));
        ((Index =:= 13 ; Index =:= 29 ) -> payTax(Nama, Tax),
                                        write('    Ninu ninu km kena pajaaakkk sebesar '), 
                                        write(Tax));
        ((Index =:= 25) -> worldTour(Nama))
    ).

checkLocation(Nama, Index):-
    Index \= 5, Index \= 21, Index \= 30, Index \= 5, Index \= 21, Index \= 25, Index \= 30.

checkLocationDetail(ID) :-
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    write('    Nama Lokasi          : '), write(Nama_properti),nl,
    write('    Deskripsi Lokasi     : '), write(Deskripsi_properti),nl,
    kepemilikan(Pemilik, ID),
    write('    Kepemilikan          : '), write(Pemilik), nl,
    write('    Biaya sewa saat ini  : '), write(Rent),nl,
    write('    Biaya Akuisisi       : '), write(Akuisisi), nl,
    write('    Tingkatan properti   : '),
    writeTingkatan(Tipe).
    
writeTingkatan(Tingkat):-
    (Tingkat == 0; Tingkat == -1) -> write('Tanah');
    (Tingkat == 1 -> write('Bangunan 1'), nl);
    (Tingkat == 2 -> write('Bangunan 2'), nl);
    (Tingkat == 3 -> write('Bangunan 3'), nl);
    (Tingkat == 4 -> write('Landmark'), nl),!.


/* Operation of a Map */
initMap:-startMap(M),assertz(map(M)),displayBoard.