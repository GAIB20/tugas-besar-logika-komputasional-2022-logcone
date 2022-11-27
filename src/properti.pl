/* Facts */
:- dynamic(property/8).
:- include('player.pl').

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

checkPropertyDetail(ID) :-
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    write('Nama Properti: '), write(Nama_properti), nl,
    write('Deskripsi Properti: '), write(Deskripsi_properti), nl,
    write('Tipe Bangunan: '), write(Tipe), nl,
    write('Biaya Sewa: '), write(Rent), nl,
    write('Biaya Akuisisi: '), write(Akuisisi), nl.




payRent(Pemilik, ID_Properti):-
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),
    property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok),
    NewMoney is Uang - Rent,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).

payAkuisisi(Pemilik, ID_Properti):-
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),
    property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok),
    NewMoney is Uang - Akuisisi,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).


initProperty:- %Parameter harga, nama lokasi, dan deskripsi lokasi bisa diganti nanti
    asserta(property(a1, 'Jakarta', 2, 'Deskripsi_A1', bangunan_1, 25, 100, a)),
    asserta(property(a1, 'Jakarta', 2, 'Deskripsi_A1', bangunan_2, 50, 200, a)),
    asserta(property(a1, 'Jakarta', 2, 'Deskripsi_A1', bangunan_3, 75, 300, a)),
    asserta(property(a1, 'Jakarta', 2, 'Deskripsi_A1', landmark, 125, 500, a)),
    asserta(property(a2, 'Manila', 3, 'Deskripsi_A2', bangunan_1, 25, 100, a)),
    asserta(property(a2, 'Manila', 3, 'Deskripsi_A2', bangunan_2, 50, 200, a)),
    asserta(property(a2, 'Manila', 3, 'Deskripsi_A2', bangunan_3, 75, 300, a)),
    asserta(property(a2, 'Manila', 3, 'Deskripsi_A2', landmark, 150, 550, a)),
    asserta(property(a3, 'Bangkok', 4, 'Deskripsi_A3', bangunan_1, 25, 100, a)),
    asserta(property(a3, 'Bangkok', 4, 'Deskripsi_A3', bangunan_2, 50, 200, a)),
    asserta(property(a3, 'Bangkok', 4, 'Deskripsi_A3', bangunan_3, 75, 300, a)),
    asserta(property(a3, 'Bangkok', 4, 'Deskripsi_A3', landmark, 175, 575, a)),
    asserta(property(b1, 'Tokyo', 6, 'Deskripsi_b1', bangunan_1, 25, 100, b)),
    asserta(property(b1, 'Tokyo', 6, 'Deskripsi_b1', bangunan_2, 50, 200, b)),
    asserta(property(b1, 'Tokyo', 6, 'Deskripsi_b1', bangunan_3, 75, 300, b)),
    asserta(property(b1, 'Tokyo', 6, 'Deskripsi_b1', landmark, 125, 500, b)),
    asserta(property(b2, 'Beijing', 7, 'Deskripsi_b2', bangunan_1, 25, 100, b)),
    asserta(property(b2, 'Beijing', 7, 'Deskripsi_b2', bangunan_2, 50, 200, b)),
    asserta(property(b2, 'Beijing', 7, 'Deskripsi_b2', bangunan_3, 75, 300, b)),
    asserta(property(b2, 'Beijing', 7, 'Deskripsi_b2', landmark, 150, 550, b)),
    asserta(property(b3, 'Seoul', 8, 'Deskripsi_b3', bangunan_1, 25, 100, b)),
    asserta(property(b3, 'Seoul', 8, 'Deskripsi_b3', bangunan_2, 50, 200, b)),
    asserta(property(b3, 'Seoul', 8, 'Deskripsi_b3', bangunan_3, 75, 300, b)),
    asserta(property(b3, 'Seoul', 8, 'Deskripsi_b3', landmark, 175, 575, b)),
    asserta(property(c1, 'Dubai', 10, 'Deskripsi_c1', bangunan_1, 25, 100, c)),
    asserta(property(c1, 'Dubai', 10, 'Deskripsi_c1', bangunan_2, 50, 200, c)),
    asserta(property(c1, 'Dubai', 10, 'Deskripsi_c1', bangunan_3, 75, 300, c)),
    asserta(property(c1, 'Dubai', 10, 'Deskripsi_c1', landmark, 125, 500, c)),
    asserta(property(c2, 'Kairo', 11, 'Deskripsi_c2', bangunan_1, 25, 100, c)),
    asserta(property(c2, 'Kairo', 11, 'Deskripsi_c2', bangunan_2, 50, 200, c)),
    asserta(property(c2, 'Kairo', 11, 'Deskripsi_c2', bangunan_3, 75, 300, c)),
    asserta(property(c2, 'Kairo', 11, 'Deskripsi_c2', landmark, 150, 550, c)),
    asserta(property(c3, 'New_Delhi', 12, 'Deskripsi_c3', bangunan_1, 25, 100, c)),
    asserta(property(c3, 'New_Delhi', 12, 'Deskripsi_c3', bangunan_2, 50, 200, c)),
    asserta(property(c3, 'New_Delhi', 12, 'Deskripsi_c3', bangunan_3, 75, 300, c)),
    asserta(property(c3, 'New_Delhi', 12, 'Deskripsi_c3', landmark, 175, 575, c)),
    asserta(property(d1, 'Hamburg', 14, 'Deskripsi_d1', bangunan_1, 25, 130, d)),
    asserta(property(d1, 'Hamburg', 14, 'Deskripsi_d1', bangunan_2, 50, 200, d)),
    asserta(property(d1, 'Hamburg', 14, 'Deskripsi_d1', bangunan_3, 75, 300, d)),
    asserta(property(d1, 'Hamburg', 14, 'Deskripsi_d1', landmark, 125, 500, d)),
    asserta(property(d2, 'Paris', 15, 'Deskripsi_d2', bangunan_1, 25, 100, d)),
    asserta(property(d2, 'Paris', 15, 'Deskripsi_d2', bangunan_2, 50, 200, d)),
    asserta(property(d2, 'Paris', 15, 'Deskripsi_d2', bangunan_3, 75, 300, d)),
    asserta(property(d2, 'Paris', 15, 'Deskripsi_d2', landmark, 150, 550, d)),
    asserta(property(d3, 'London', 16, 'Deskripsi_d3', bangunan_1, 25, 100, d)),
    asserta(property(d3, 'London', 16, 'Deskripsi_d3', bangunan_2, 50, 200, d)),
    asserta(property(d3, 'London', 16, 'Deskripsi_d3', bangunan_3, 75, 300, d)),
    asserta(property(d3, 'London', 16, 'Deskripsi_d3', landmark, 175, 575, d)),
    asserta(property(e1, 'New_York', 18, 'Deskripsi_e1', bangunan_1, 25, 180, e)),
    asserta(property(e1, 'New_York', 18, 'Deskripsi_e1', bangunan_2, 50, 200, e)),
    asserta(property(e1, 'New_York', 18, 'Deskripsi_e1', bangunan_3, 75, 300, e)),
    asserta(property(e1, 'New_York', 18, 'Deskripsi_e1', landmark, 125, 500, e)),
    asserta(property(e2, 'Panama', 19, 'Deskripsi_e2', bangunan_1, 25, 100, e)),
    asserta(property(e2, 'Panama', 19, 'Deskripsi_e2', bangunan_2, 50, 200, e)),
    asserta(property(e2, 'Panama', 19, 'Deskripsi_e2', bangunan_3, 75, 300, e)),
    asserta(property(e2, 'Panama', 19, 'Deskripsi_e2', landmark, 150, 550, e)),
    asserta(property(e3, 'Washington', 20, 'Deskripsi_e3', bangunan_1, 25, 100, e)),
    asserta(property(e3, 'Washington', 20, 'Deskripsi_e3', bangunan_2, 50, 200, e)),
    asserta(property(e3, 'Washington', 20, 'Deskripsi_e3', bangunan_3, 75, 300, e)),
    asserta(property(e3, 'Washington', 20, 'Deskripsi_e3', landmark, 175, 575, e)),
    asserta(property(f1, 'Saturnus', 22, 'Deskripsi_f1', bangunan_1, 25, 220, f)),
    asserta(property(f1, 'Saturnus', 22, 'Deskripsi_f1', bangunan_2, 50, 200, f)),
    asserta(property(f1, 'Saturnus', 22, 'Deskripsi_f1', bangunan_3, 75, 300, f)),
    asserta(property(f1, 'Saturnus', 22, 'Deskripsi_f1', landmark, 125, 500, f)),
    asserta(property(f2, 'Uranus', 23, 'Deskripsi_f2', bangunan_1, 25, 100, f)),
    asserta(property(f2, 'Uranus', 23, 'Deskripsi_f2', bangunan_2, 50, 200, f)),
    asserta(property(f2, 'Uranus', 23, 'Deskripsi_f2', bangunan_3, 75, 300, f)),
    asserta(property(f2, 'Uranus', 23, 'Deskripsi_f2', landmark, 150, 550, f)),
    asserta(property(f3, 'Neptunus', 24, 'Deskripsi_f3', bangunan_1, 25, 100, f)),
    asserta(property(f3, 'Neptunus', 24, 'Deskripsi_f3', bangunan_2, 50, 200, f)),
    asserta(property(f3, 'Neptunus', 24, 'Deskripsi_f3', bangunan_3, 75, 300, f)),
    asserta(property(f3, 'Neptunus', 24, 'Deskripsi_f3', landmark, 175, 575, f)),
    asserta(property(g1, 'Saturnus', 26, 'Deskripsi_g1', bangunan_1, 25, 260, g)),
    asserta(property(g1, 'Saturnus', 26, 'Deskripsi_g1', bangunan_2, 50, 200, g)),
    asserta(property(g1, 'Saturnus', 26, 'Deskripsi_g1', bangunan_3, 75, 300, g)),
    asserta(property(g1, 'Saturnus', 26, 'Deskripsi_g1', landmark, 125, 500, g)),
    asserta(property(g2, 'Uranus', 27, 'Deskripsi_g2', bangunan_1, 25, 100, g)),
    asserta(property(g2, 'Uranus', 27, 'Deskripsi_g2', bangunan_2, 50, 200, g)),
    asserta(property(g2, 'Uranus', 27, 'Deskripsi_g2', bangunan_3, 75, 300, g)),
    asserta(property(g2, 'Uranus', 27, 'Deskripsi_g2', landmark, 150, 550, g)),
    asserta(property(g3, 'Neptunus', 28, 'Deskripsi_g3', bangunan_1, 25, 100, g)),
    asserta(property(g3, 'Neptunus', 28, 'Deskripsi_g3', bangunan_2, 50, 200, g)),
    asserta(property(g3, 'Neptunus', 28, 'Deskripsi_g3', bangunan_3, 75, 300, g)),
    asserta(property(g3, 'Neptunus', 28, 'Deskripsi_g3', landmark, 175, 575, g)),
    asserta(property(h1, 'Unknown_Realm', 31, 'Deskripsi_h1', bangunan_1, 25, 100, h)),
    asserta(property(h1, 'Unknown_Realm', 31, 'Deskripsi_h1', bangunan_2, 50, 200, h)),
    asserta(property(h1, 'Unknown_Realm', 31, 'Deskripsi_h1', bangunan_3, 75, 300, h)),
    asserta(property(h1, 'Unknown_Realm', 31, 'Deskripsi_h1', landmark, 150, 550, h)),
    asserta(property(h2, 'Isekai', 32, 'Deskripsi_h2', bangunan_1, 25, 100, h)),
    asserta(property(h2, 'Isekai', 32, 'Deskripsi_h2', bangunan_2, 50, 200, h)),
    asserta(property(h2, 'Isekai', 32, 'Deskripsi_h2', bangunan_3, 75, 300, h)),
    asserta(property(h2, 'Isekai', 32, 'Deskripsi_h2', landmark, 175, 575, h)).

    