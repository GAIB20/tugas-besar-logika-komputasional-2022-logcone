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

    random(1, 7, Dadu_1), 
    random(1, 7, Dadu_2),
    % Dadu_1 is 2,
    % Dadu_2 is 1,

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    
    outFromJail(1, Nama, Dadu_1, Dadu_2),

    retract(list_player(ListNama, Giliran)),
    Giliran_new is ((Giliran) mod 2) + 1,
    assertz(list_player(ListNama, Giliran_new)),
    displayBoard,!.

throwDice :-        % Untuk yang ga dipenjara
    retract(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),
    % random(1, 7, Dadu_1), 
    % random(1, 7, Dadu_2),
    Dadu_1 is 6,
    Dadu_2 is 6,
    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    Count_jail == 0,

    % Cek double masuk penjara atau ga
    retract(count_pemain(Nama, Count_jail, Count_double)),
    checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew, Giliran, Giliran_new),

    assertz(count_pemain(Nama, Count_jail, Count_doubleNew)),
    assertz(list_player(ListNama, Giliran_new)),
    % Cek penjara
    goToJail(Nama),displayBoard,!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew, Giliran, Giliran_new) :-
    Dadu_1 =:= Dadu_2, 
    Count_double =:= 2,       % Double masuk penjara
    Count_doubleNew is Count_double + 1,
    Giliran_new is ((Giliran) mod 2) + 1,!.
    % write(Count_doubleNew), write(Giliran_new),!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew, Giliran, Giliran_new) :-
    Dadu_1 =:= Dadu_2, 
    Count_double < 2,       % Double tp tdk masuk penjara

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    Dadu is Dadu_1 + Dadu_2, write('    '), write(Nama), 
    write(' maju sebanyak '), write(Dadu), write(' langkah'), nl,
    retract(lokasi_pemain(Nama, Indeks)),
    IndeksNew is ((Indeks + Dadu - 1) mod 32) + 1,
    assertz(lokasi_pemain(Nama, IndeksNew)),
    checkLocation(Nama, IndeksNew),

    Count_doubleNew is Count_double + 1,
    Giliran_new is Giliran,
    % write(Count_double), write(Giliran),
    % write(Count_doubleNew), write(Giliran_new),
    write('\n    Double!\n    Anda dapat mengocok lagi!\n'),!.

checkDouble(Nama, Dadu_1, Dadu_2, Count_jail, Count_double, Count_doubleNew, Giliran, Giliran_new) :-
    Dadu_1 =\= Dadu_2,      % Tidak double

    write('    Dadu 1 : '),write(Dadu_1), nl,
    write('    Dadu 2 : '), write(Dadu_2),nl, 
    Dadu is Dadu_1 + Dadu_2, write('    '), write(Nama), 
    write(' maju sebanyak '), write(Dadu), write(' langkah'), nl,
    retract(lokasi_pemain(Nama, Indeks)),
    IndeksNew is ((Indeks + Dadu - 1) mod 32) + 1,
    assertz(lokasi_pemain(Nama, IndeksNew)),
    checkLocation(Nama, IndeksNew),

    Count_doubleNew is 0,
    Giliran_new is ((Giliran) mod 2) + 1,!.






