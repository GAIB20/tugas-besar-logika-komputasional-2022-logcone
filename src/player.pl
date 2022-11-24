/* Facts */
:- dynamic(nama_pemain/1).
:- dynamic(turn/1).
:- dynamic(aset_pemain/4).
:- dynamic(lokasi_pemain/2).
:- dynamic(card_pemain/2).
:- dynamic(count_pemain/3).
:- dynamic(list_player/2).
:- dynamic(jail_status/2).

/* rule pemain untuk informasi pemain secara keseluruhan */
pemain(Nama, Indeks, Uang, Nilai_properti, Daftar_properti, Daftar_card, Count_jail, Count_double) :-
    nama_pemain(Nama),
    aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti),
    lokasi_pemain(Nama, Indeks),
    card_pemain(Nama, Daftar_card),
    count_pemain(Nama, Count_jail, Count_double).

/* Inisialisasi data pemain */
initPlayer :-
    write('    MONOPOLY GAME'), nl,
    write('    Masukkan nama pemain 1:'), nl,
    write('    '), read(Nama1),nl,
    Fact =.. [nama_pemain, Nama1],
    asserta(Fact),
    write('    Masukkan nama pemain 2:'), nl,
    write('    '), read(Nama2),
    assertz(list_player([Nama1, Nama2], 1)),
    asserta(nama_pemain(Nama2)),
    (
        forall(
            nama_pemain(Nama),
            (
                asserta(aset_pemain(Nama, 1000, 0, [])),
                asserta(card_pemain(Nama, [])),
                asserta(lokasi_pemain(Nama, 1)),
                asserta(count_pemain(Nama, 0, 0))
            )
        )
    ).

/* Display detail informasi pemain */
checkPlayerDetail(Nama) :-
    pemain(Nama, Indeks, Uang, Nilai_properti, Daftar_properti, Daftar_card, Count_jail, Count_double),
    getLocation(Indeks, NamaLokasi),
    write('    Informasi Player '), write(Nama), nl,nl,
    write('    Lokasi                       : '), write(NamaLokasi), nl, 
    write('    Total Uang                   : '), write(Uang), nl,
    write('    Total Nilai Properti         : '), write(Nilai_properti), nl,
    Aset is Uang + Nilai_properti,
    write('    Total Aset                   : '), write(Aset), nl,
    nl,
    write('    Daftar Kepemilikan Properti  : '), nl,
    displayProperty(Daftar_properti, 1), nl,
    nl,
    write('    Daftar Kepemilikan Card      : '), nl,
    displayCard(Daftar_card, 1), !.

/* Display properti pemain */
displayProperty([], _) :- true.
displayProperty([X|Tail], Count) :-
    write(Count), write('. '), write(X), write(' - '), write('Kondisi'), nl, % Kondisi (tanah, bangunan, landmark) added later
    Count_next is Count + 1,
    displayProperty(Tail, Count_next).

/* Display chance card pemain */
displayCard([], _) :- true.
displayCard([X|Tail], Count) :-
    write(Count), write('. '), write(X), nl,
    Count_next is Count + 1,
    displayCard(Tail, Count_next).

appendList([], A, [A]).
appendList([X|Tail], A, [X|Rest]) :-
    appendList(Tail, A, Rest).

/* Reset data pemain */
reset :-
    retractall(nama_pemain(_)),
    retractall(aset_pemain(_, _, _, _)),
    retractall(lokasi_pemain(_, _, _)),
    retractall(card_pemain(_, _)),
    retractall(count_pemain(_, _, _)).