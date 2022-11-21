:- include('player.pl').


goToJail(Nama):-
% Predicate untuk masuk penjara
    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, Count_jail, Count_double)),
    retract(card_pemain(Nama, Kartu)),
    assertz(card_pemain(Nama, Kartu)),
    (Count_double == 3 ; getIndex(Kartu,'GJ', X)),     % Jika roll dice dapet double sampe 3 kali atau punya kartu jail
    write('    Kamu masuk penjara karena banyak dosa >:['),
    retract(count_pemain(Nama, Count_jail, Count_double)),
    assertz(count_pemain(Nama, 1, 0)),

    retract(lokasi_pemain(Nama, Lokasi)), 
    assertz(lokasi_pemain(Nama, 9)),!.     % lokasi index dari penjara adalah 9

/*
    Metode untuk keluar dari penjara
    1. Roll
        |___ Double
        |___ 3 kali
    2. card
    3. pay
*/

% Mencari kartu dalam list
getIndex([H | _], H, 1):-!.
getIndex([_ | T], Val, Index) :-
    getIndex(T, Val, Index1),
    Index is Index1 + 1.

remover( _, [], []).
remover( R, [R|T], T).
remover( R, [H|T], [H|T2]) :- H \= R, remover( R, T, T2).

outFromJail(1, Nama, Dadu_1, Dadu_2):-
    retract(count_pemain(Nama, Count_jail, Count_double)),
    (Dadu_1 =:= Dadu_2 ; Count_jail =:=4),
    New_count_jail is 0,
    assertz(count_pemain(Nama, New_count_jail, Count_double)),
    write('    Selamat kamu keluar penjara :>'),nl,

    write('    '), write(Nama), Dadu is Dadu_1 + Dadu_2,
    write(' maju sebanyak '), write(Dadu), write(' langkah'), nl,
    retract(lokasi_pemain(Nama, Indeks)),
    IndeksNew is ((Indeks + Dadu - 1) mod 32) + 1,
    assertz(lokasi_pemain(Nama, IndeksNew)),!.

outFromJail(1, Nama, Count_jail, Count_double, New_count_double,New_count_jail):-
    retract(count_pemain(Nama, Count_jail, Count_double)),
    (Dadu_1 \= Dadu_2 ; Count_jail < 4),
    New_count_jail is Count_jail + 1,
    assertz(count_pemain(Nama, New_count_jail, Count_double)),
    write('Selamat kamu gagal keluar penjara >:)'),!.

outFromJail(2, Nama):-
    retract(card_pemain(Nama, Daftar_card)),
    getIndex(Daftar_card, 'FJ', Idx),
    remover(Daftar_card, 'FJ', Daftar_card_baru),
    assertz(card_pemain(Nama, Daftar_card_baru)).
    % status jail = false

outFromJail(3, Nama) :-
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    Uang > 1000,
    Uang_baru is Uang - 1000,
    assertz(aset_pemain(Nama, Uang_baru, Nilai_properti, Daftar_properti)).
    % status jail = false