:- include('player.pl').
:- dynamic(jailStatus/1).

goToJail(Nama):-
% Predicate untuk masuk penjara
    retract(count_pemain(Nama, Count_jail, Count_double)),
    retract(card_pemain(Nama, Kartu)),
    (Count_double =:= 3 ; getIndex(Kartu,'GJ', X)), % Jika roll dice dapet double sampe 3 kali atau punya kartu jail
    lokasi_pemain(Nama, 9), % lokasi index dari penjara adalah 9
    New_count_jail is 0,
    New_count_double is 0,
    assertz(Nama, New_count_jail, New_count_double).

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

outFromJail(1, Nama):-
    retract(count_pemain(Nama, Count_jail, Count_double)),
    (Count_double =:= 1 ; Count_jail =:=3),
    New_count_double is 0,
    New_count_jail is 0,
    assertz(count_pemain(Nama, New_count_jail, New_count_double)).
    % status jail = false

outFromJail(2, Nama):-
    retract(card_pemain(Nama, Daftar_card)),
    getIndex(Daftar_card, 'FJ', Idx),
    remover(Daftar_card, 'FJ', Daftar_card_baru),
    assertz(card_pemain(Nama, Daftar_card_baru)).
    % status jail = false

outFromJail(3, Nama) :-
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    Uang > 1000,
    Uang_baru is Uang - 1000
    assertz(aset_pemain(Nama, Uang_baru, Nilai_properti, Daftar_properti)).
    % status jail = false