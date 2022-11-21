:- include('player.pl')

beli :-
    lokasi_pemain(Nama, Indeks),
    property(ID, _Nama_properti, Indeks, _Deskripsi_properti, _Tipe, _Rent, _Akuisisi, _Blok),
    kepemilikan(Pemilik, ID),
    Pemilik == 'None',
    write('Ingin bangun sampai tingkat berapa? (0/1/2/3) '), nl,
    read(Tingkat),
    Tingkat =:= 0 -> propertyValue(ID, Buy0, _, _, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - Buy0, Nilai_properti_new is Nilai_properti + Buy0, appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
    Tingkat =:= 1 -> propertyValue(ID, Buy0, Buy1, _, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
    Tingkat =:= 2 -> propertyValue(ID, Buy0, Buy1, Buy2, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1 + Buy2), Nilai_properti_new is Nilai_properti + (Buy0 + Buy1 + Buy2), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
    Tingkat =:= 3 -> propertyValue(ID, Buy0, Buy1, Buy2, Buy3, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1 + Buy2 + Buy3), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1 + Buy2 + Buy3), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new).

% upgrade :-
%     lokasi_pemain(Nama, Indeks),
%     property(ID, _Nama_properti, Indeks, _Deskripsi_properti, _Tipe, _Rent, _Akuisisi, _Blok),
%     kepemilikan(Pemilik, ID),
%     Pemilik == Nama,
%     write('Ingin bangun sampai tingkat berapa? (0/1/2/3) '), nl,
%     read(Tingkat),
%     Tingkat =:= 0 -> propertyValue(ID, Buy0, _, _, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - Buy0, Nilai_properti_new is Nilai_properti + Buy0, appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
%     Tingkat =:= 1 -> propertyValue(ID, Buy0, Buy1, _, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
%     Tingkat =:= 2 -> propertyValue(ID, Buy0, Buy1, Buy2, _, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1 + Buy2), Nilai_properti_new is Nilai_properti + (Buy0 + Buy1 + Buy2), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new),
%     Tingkat =:= 3 -> propertyValue(ID, Buy0, Buy1, Buy2, Buy3, _, _, _, _, _, _), aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti), UangNew is Uang - (Buy0 + Buy1 + Buy2 + Buy3), Nilai_properti_new is Nilai_properti +(Buy0 + Buy1 + Buy2 + Buy3), appendList(Daftar_properti, ID, Daftar_properti_new), aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new).
