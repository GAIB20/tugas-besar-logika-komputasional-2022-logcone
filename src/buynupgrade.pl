:- include('player.pl').
:- include('properti.pl').

beli(Nama) :-
    retract(lokasi_pemain(Nama, Indeks)),
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    asserta(lokasi_pemain(Nama, Indeks)),
    asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    asserta(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    %kepemilikan()
    (Pemilik == 'None' -> )
    write('Ingin bangun sampai tingkat berapa? (0/1/2/3) '), nl,
    read(Tingkat),
    (Tingkat =:= 0 -> UangNew is Uang - Buy0, Nilai_properti_new is Nilai_properti + Buy0, appendList(Daftar_properti, ID, Daftar_properti_new), asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new));
    Tingkat =:= 1 ->  UangNew is Uang - (Buy0 + Buy1), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1), appendList(Daftar_properti, ID, Daftar_properti_new),asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new));
    Tingkat =:= 2 ->  UangNew is Uang - (Buy0 + Buy1 + Buy2), Nilai_properti_new is Nilai_properti + (Buy0 + Buy1 + Buy2), appendList(Daftar_properti, ID, Daftar_properti_new), asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new));
    Tingkat =:= 3 ->  UangNew is Uang - (Buy0 + Buy1 + Buy2 + Buy3), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1 + Buy2 + Buy3), appendList(Daftar_properti, ID, Daftar_properti_new), asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new))).

payTax(Nama) :-
    retract(aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti)),
    Tax is 0.1*(Uang + Nilai_properti),
    UangNew is Uang - Tax,
    % (UangNew < 0 -> jual aset ),
    asserta(aset_pemain(Pemilik, UangNew, Nilai_properti, Daftar_properti)).

worldTour(Pemain) :-
    wirte('Pilih nama lokasi yang ingin kamu kunjungi : '),
    read(LocName),
    retract(property(ID, LocName, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    assertz(property(ID, LocName, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    (Indeks \== 25 -> retract(lokasi_pemain(Pemain, Indexold)), assertz(lokasi_pemain(Pemain, Indeks)),write('Anda sudah sampai di lokasi tujuan'), nl,
        (Indeks < 25 -> retractz(aset_pemain(Pemain, Uang, Nilai_properti, Daftar_properti)),UangNew is Uang + 10000,assertz(aset_pemain(Pemain, UangNew, Nilai_properti, Daftar_properti)),write('Anda mendapat uang sebanyak 10000'), nl);
    Indeks =:= 25 -> write('Anda tidak boleh menuju ke world tour'), nl, worldTour(Pemain)).
    

upgrade :-
    retract(lokasi_pemain(Nama, Indeks)),
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    asserta(lokasi_pemain(Nama, Indeks)),
    % asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    asserta(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    (Tipe =:= 0 -> write('mau upgrade jadi apa? (1-3) '), read(Up),
        (Up =:= 1 -> UangNew is Uang - Buy1, Nilai_properti_new is Nilai_properti + Buy1, TipeNew is 1, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
        Up =:= 2 ->  UangNew is Uang - (Buy1+Buy2), Nilai_properti_new is Nilai_properti + (Buy1+Buy2), TipeNew is 2, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
        Up =:= 3 ->  UangNew is Uang - (Buy1+Buy2 + Buy3), Nilai_properti_new is Nilai_properti + (Buy1+Buy2+Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
    Tipe =:=1 -> write('mau upgrade jadi apa? (2-3) '), read(Up),
        (Up =:= 2 ->  UangNew is Uang - (Buy2), Nilai_properti_new is Nilai_properti + (Buy2), TipeNew is 2, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
        Up =:= 3 -> UangNew is Uang - (Buy2 + Buy3), Nilai_properti_new is Nilai_properti + (Buy2+Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
    Tipe =:= 2 -> write('mau upgrade jadi apa? (3) '), read(Up),
        (Up =:= 3 -> UangNew is Uang - (Buy3), Nilai_properti_new is Nilai_properti + (Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
    Tipe =:= 3 -> write('mau upgrade jadi apa? (4) '), read(Up),
        (Up =:= 4 -> UangNew is Uang - (Buy4), Nilai_properti_new is Nilai_properti + (Buy4), TipeNew is 4, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),) ).
    
