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

changeMapStatus(M, X, Y, Tipe, Giliran, Mout) :-
    (
        (Giliran =:= 1 ->
            (
                (Tipe =:= 0 ->
                    setElmtMap(M, X, Y, ' X0 ', Mout)
                );
                (Tipe =:= 1 ->
                    setElmtMap(M, X, Y, ' X1 ', Mout)
                );
                (Tipe =:= 2 ->
                    setElmtMap(M, X, Y, ' X2 ', Mout)
                );
                (Tipe =:= 3 ->
                    setElmtMap(M, X, Y, ' X3 ', Mout)
                );
                (Tipe =:= 4 ->
                    setElmtMap(M, X, Y, ' XL ', Mout)
                )
            )
        );
        (Giliran =:= 2 ->
            (
                (Tipe =:= 0 ->
                    setElmtMap(M, X, Y, ' Y0 ', Mout)
                );
                (Tipe =:= 1 ->
                    setElmtMap(M, X, Y, ' Y1 ', Mout)
                );
                (Tipe =:= 2 ->
                    setElmtMap(M, X, Y, ' Y2 ', Mout)
                );
                (Tipe =:= 3 ->
                    setElmtMap(M, X, Y, ' Y3 ', Mout)
                );
                (Tipe =:= 4 ->
                    setElmtMap(M, X, Y, ' YL ', Mout)
                )
            )
        )
    ).



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
    Index =\= 5, Index =\= 9, Index =\= 13, Index =\= 17, Index =\= 21, Index =\= 25, Index =\= 29, Index =\= 30,
    payRent(Nama, Index).

checkLocationDetail(ID) :-
    ((ID == 'CC1' ; ID == 'CC2'; ID == 'CC3'),
    write('Nama Lokasi       :  Chance Card'),nl,
    write('Deskripsi Lokasi  :  Keberuntunganmu diuji disini...'),nl,nl,
    write('Daftar kartu-kartu : '),nl,
    write('1. Kartu Pajak'),nl,
    write('2. Kartu DUIT $$$'),nl,
    write('3. Kartu bebas penjara'),nl,
    write('4. Kartu masuk penjara'),nl,
    write('5. Kartu menuju GO'),nl,
    write('6. Kartu ga ngapa-ngapain'),nl,!);
    ((ID == 'TX1' ; ID == 'TX2' ),
    write('Nama Lokasi       :  Tax'),nl,
    write('Deskripsi Lokasi  :  Bayar pajak woi. Pajaknya cuma sebesar'), write(Tax),write('lho!'),!);
    ((ID == 'WT'),write('Nama Lokasi       :  World Tour'),nl,
    write('Deskripsi Lokasi  :  Kmu bisa kemana aj bagaikan doraemon.'),!);
    (retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    write('    Nama Lokasi          : '), write(Nama_properti),nl,
    write('    Deskripsi Lokasi     : '), write(Deskripsi_properti),nl,
    kepemilikan(Pemilik, ID),
    write('    Kepemilikan          : '), write(Pemilik), nl,
    write('    Biaya sewa saat ini  : '), write(Rent),nl,
    write('    Biaya Akuisisi       : '), write(Akuisisi), nl,
    write('    Tingkatan properti   : '),
    writeTingkatan(Tipe)).


                                       

    
writeTingkatan(Tingkat):-
    (Tingkat == 0; Tingkat == -1) -> write('Tanah');
    (Tingkat == 1 -> write('Bangunan 1'), nl);
    (Tingkat == 2 -> write('Bangunan 2'), nl);
    (Tingkat == 3 -> write('Bangunan 3'), nl);
    (Tingkat == 4 -> write('Landmark'), nl),!.


/* Operation of a Map */
initMap:-startMap(M),assertz(map(M)),displayBoard.