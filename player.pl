/* Facts */
:- dynamic(nama_pemain/1).
:- dynamic(turn/1).
:- dynamic(aset_pemain/4).
:- dynamic(lokasi_pemain/3).
:- dynamic(card_pemain/2).
:- dynamic(count_pemain/3).

/* rule pemain untuk informasi pemain secara keseluruhan */
pemain(Nama, Lokasi, Indeks, Uang, Nilai_properti, Daftar_properti, Daftar_card, Count_jail, Count_double) :-
    nama_pemain(Nama),
    aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti),
    lokasi_pemain(Nama, Lokasi, Indeks),
    card_pemain(Nama, Daftar_card),
    count_pemain(Nama, Count_jail, Count_double).

/* Inisialisasi data pemain */
initPlayer :-
    write('MONOPOLY GAME'), nl,
    write('Masukkan nama pemain 1:'), nl,
    read(Nama1),
    Fact =.. [nama_pemain, Nama1],
    asserta(Fact),
    write('Masukkan nama pemain 2:'), nl,
    read(Nama2),
    asserta(nama_pemain(Nama2)),
    (
        forall(
            nama_pemain(Nama),
            (
                asserta(aset_pemain(Nama, 1000, 0, [])),
                asserta(card_pemain(Nama, [])),
                asserta(lokasi_pemain(Nama, 'GO', 1)),
                asserta(count_pemain(Nama, 0, 0))
            )
        )
    ).

/* Display detail informasi pemain */
checkPlayerDetail(Nama) :-
    pemain(Nama, Lokasi, Uang, Nilai_properti, Daftar_properti, Daftar_card, Count_jail, Count_double),
    write('Informasi Player '), write(Nama), nl,
    nl,
    write('Lokasi                       : '), write(Lokasi), nl,
    write('Total Uang                   : '), write(Uang), nl,
    write('Total Nilai Properti         : '), write(Nilai_properti), nl,
    Aset is Uang + Nilai_properti,
    write('Total Aset                   : '), write(Aset), nl,
    nl,
    write('Daftar Kepemilikan Properti  : '), nl,
    displayProperti(Daftar_properti, 1), nl,
    nl,
    write('Daftar Kepemilikan Card      : '), nl,
    displayCard(Daftar_card, 1), !.

/* Display properti pemain */
displayProperty([], _) :- true.
displayProperty([X|Tail], Count) :-
    write(Count), write('. '), write(X), write(' - '), write('Kondisi'), nl,
    Count_next is Count + 1,
    displayProperty(Tail, Count_next).

/* Display chance card pemain */
displayCard([], _) :- true.
displayCard([X|Tail], Count) :-
    write(Count), write('. '), write(X), nl,
    Count_next is Count + 1,
    displayCard(Tail, Count_next).

/* Reset data pemain */
reset :-
    retractall(nama_pemain(_)),
    retractall(aset_pemain(_, _, _, _)),
    retractall(lokasi_pemain(_, _, _)),
    retractall(card_pemain(_, _)),
    retractall(count_pemain(_, _, _)).