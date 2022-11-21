/* Facts */
:- dynamic(property/7).
:- dynamic(nama_pemain/1).
:- dynamic(aset_pemain/4).


property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok).

/*Rules*/
kepemilikan(Pemilik, ID):-
    nama_pemain(Pemilik),
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),
    getProperti(Daftar_properti,ID).

getProperti([_X|Tail],_X).
getProperti([],_X) :- !.
getProperti([_X|Tail],_Y):-
    getProperti(Tail,_Y).

% checkPropertyDetail(x) -> sudah ada di player.pl

payRent(Pemilik, ID_Properti):-
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),,
    property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok),
    NewMoney is Uang - Rent,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).

payAkuisisi(Pemilik, ID_Properti):-
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),,
    property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok),
    NewMoney is Uang - Akuisisi,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).


    