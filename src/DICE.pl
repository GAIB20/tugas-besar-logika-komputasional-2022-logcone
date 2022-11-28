% :- include('player.pl').
% :- include('peta.pl').
% :- include('jail.pl').


throwDice :-        % Untuk yang dipenjara
    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    Count_jail \= 0,

    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),

    % random(1, 7, Dadu_1), 
    % random(1, 7, Dadu_2),
    Dadu_1 is 2,
    Dadu_2 is 3,

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    
    outFromJail(1, Nama, Dadu_1, Dadu_2),

    retract(list_player(ListNama, Giliran)),
    Giliran_new is (Giliran mod 2) + 1,
    assertz(list_player(ListNama, Giliran_new)),

    displayBoard,!.

throwDice :-        % Untuk yang ga dipenjara
    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),

    getElmtList(ListNama, Giliran, Nama),
    % random(1, 7, Dadu_1), 
    % random(1, 7, Dadu_2),
    Dadu_1 is 2,
    Dadu_2 is 2,
    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    Count_jail == 0,

    % Cek double masuk penjara atau ga
    retract(count_pemain(Nama, Count_jail, Count_double)),
    % write('test1'),
    checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew),
    % write('test2'),
    assertz(count_pemain(Nama, Count_jail, Count_doubleNew)),

    % Cek penjara
    goToJail(Nama),displayBoard,!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew) :-
    Dadu_1 =:= Dadu_2, 
    Count_double =:= 2,       % Double masuk penjara
    Count_doubleNew is Count_double + 1,
    
    retract(list_player(ListNama, Giliran)),
    Giliran_new is (Giliran mod 2) + 1,
    assertz(list_player(ListNama, Giliran_new)),!.
    % write(Count_doubleNew), write(Giliran_new),!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew) :-
    Dadu_1 =:= Dadu_2, 
    Count_double < 2,       % Double tp tdk masuk penjara

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    Dadu is Dadu_1 + Dadu_2, write('    '), write(Nama), 
    write(' maju sebanyak '), write(Dadu), write(' langkah'), nl,
    retract(lokasi_pemain(Nama, Indeks)),
    IndeksNew is ((Indeks + Dadu - 1) mod 32) + 1,
    assertz(lokasi_pemain(Nama, IndeksNew)),
    % write(Nama),
    passGO(Nama, Indeks, IndeksNew),
    checkLocation(Nama, IndeksNew),
    % payRent(Nama, IndeksNew),


    Count_doubleNew is Count_double + 1,
    % write(Count_double), write(Giliran),
    % write(Count_doubleNew), write(Giliran_new),
    write('\n    Double!\n    Anda dapat mengocok lagi!\n'),!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew) :-
    Dadu_1 =\= Dadu_2,      % Tidak double

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    Dadu is Dadu_1 + Dadu_2, write('    '), write(Nama), 
    write(' maju sebanyak '), write(Dadu), write(' langkah'), nl,
    retract(lokasi_pemain(Nama, Indeks)),
    IndeksNew is ((Indeks + Dadu - 1) mod 32) + 1,
    assertz(lokasi_pemain(Nama, IndeksNew)),
    passGO(Nama, Indeks, IndeksNew),
    checkLocation(Nama, IndeksNew),
    % payRent(Nama, IndeksNew),

    Count_doubleNew is 0,!.

gantiGiliran:-
    retract(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),

    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    
    ((Count_double > 0 -> write('    Gabisa ganti giliran karena anda dobel yyy'),assertz(list_player(ListNama, Giliran)));
    (Count_double == 0 -> GiliranNew is (Giliran mod 2) + 1, assertz(list_player(ListNama, GiliranNew)))),
    % write('test4'),
    displayBoard,!.


passGO(Nama, IndeksAwal, IndeksAkhir) :-
        (IndeksAkhir < IndeksAwal), 
        write('\n    Yey kamu sudah melewati GO :>\n    Kamu mendapatkan 200 dolar.\n'),
        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
        UangNew is Uang + 200,
        assertz(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)).

passGO(Nama, IndeksAwal, IndeksAkhir) :-
        (IndeksAkhir >= IndeksAwal),
        Count_doubleNew is 0,!.

gantiGiliran:-
    retract(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),

    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    
    ((Count_double > 0 -> write('    Gabisa ganti giliran karena anda dobel yyy'),assertz(list_player(ListNama, Giliran)));
    (Count_double == 0 -> GiliranNew is (Giliran mod 2) + 1, assertz(list_player(ListNama, GiliranNew)))),
    % write('test4'),
    displayBoard,!.


passGO(Nama, IndeksAwal, IndeksAkhir) :-
        (IndeksAkhir < IndeksAwal), 
        write('\n    Yey kamu sudah melewati GO :>\n    Kamu mendapatkan 200 dolar.\n'),
        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
        UangNew is Uang + 200,
        assertz(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)).

passGO(Nama, IndeksAwal, IndeksAkhir) :-
        (IndeksAkhir >= IndeksAwal).