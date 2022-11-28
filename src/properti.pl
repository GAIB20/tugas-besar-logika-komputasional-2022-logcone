/* Facts */
:- dynamic(property/8).
% :- include('player.pl').
propertyValue('A1',15,37,75,150,168,10,25,50,75,75).
propertyValue('A2',15,40,78,156,175,10,27,52,78,78).
propertyValue('A3',15,43,81,162,182,10,29,54,81,81).
propertyValue('B1',30,45,90,180,202,20,30,60,90,90).
propertyValue('B2',30,48,93,186,209,20,32,62,93,93).
propertyValue('B3',30,51,96,192,216,20,34,64,96,96).
propertyValue('C1',45,54,108,216,243,30,36,72,108,108).
propertyValue('C2',45,57,111,222,249,30,38,74,111,111).
propertyValue('C3',45,60,114,228,256,30,40,76,114,114).
propertyValue('D1',60,64,129,259,291,40,43,86,129,129).
propertyValue('D2',60,67,132,265,298,40,45,88,132,132).
propertyValue('D3',60,70,135,271,305,40,47,90,135,135).
propertyValue('E1',75,77,155,311,349,50,51,103,155,155).
propertyValue('E2',75,80,158,317,356,50,53,105,158,158).
propertyValue('E3',75,83,161,323,363,50,55,107,161,161).
propertyValue('F1',90,93,186,373,419,60,62,124,186,186).
propertyValue('F2',90,96,189,379,426,60,64,126,189,189).
propertyValue('F3',90,99,192,385,433,60,66,128,192,192).
propertyValue('G1',105,111,223,447,503,70,74,149,223,223).
propertyValue('G2',105,114,226,453,510,70,76,151,226,226).
propertyValue('G3',105,117,229,459,517,70,78,153,229,229).
propertyValue('H1',120,134,268,537,604,80,89,179,268,268).
propertyValue('H2',120,137,271,543,611,80,91,181,271,271).

initProperty:-
    assertz(property('A1', 'Jakarta',2, 'Ibukota Indonesia', -1, 0, 0, 'A')),
    assertz(property('A2', 'Manila',3, 'Ibukota Filipina', -1, 0, 0, 'A')),
    assertz(property('A3', 'Bangkok', 4,'Ibukota Thailand', -1, 0, 0, 'A')),
    assertz(property('B1', 'Tokyo', 6,'Ibukota Tokyo', -1, 0, 0, 'B')),
    assertz(property('B2', 'Beijing',7,'Ibukota China', -1, 0, 0, 'B')),
    assertz(property('B3', 'Seoul',8,'Ibukota Korea', -1, 0, 0, 'B')),
    assertz(property('C1', 'Dubai',10,'Kota Elit Unit Emirat Arab', -1, 0, 0, 'C')),
    assertz(property('C2', 'Kairo',11,'Ibukota Mesir', -1, 0, 0, 'C')),
    assertz(property('C3', 'New_Delhi',12, 'Ibukota India', -1, 0, 0, 'C')),
    assertz(property('D1', 'Hamburg', 14,'Ibukota Jerman', -1, 0, 0, 'D')),
    assertz(property('D2', 'Paris', 15, 'Ibukota Prancis', -1, 0, 0, 'D')),
    assertz(property('D3', 'London', 16, 'Ibukota Inggris', -1, 0, 0, 'D')),
    assertz(property('E1', 'New_York', 18, 'Kota kebanggaan Amerika Serikat', -1, 0, 0, 'E')),
    assertz(property('E2', 'Panama', 19, 'Ibukota Meksiko', -1, 0, 0, 'E')),
    assertz(property('E3', 'Washington', 20, 'Ibukota Amerika Serikat', -1, 0, 0, 'E')),
    assertz(property('F1', 'Saturnus', 22, 'Planet', -1, 0, 0, 'F')),
    assertz(property('F2', 'Uranus', 23, 'Planet', -1, 0, 0, 'F')),
    assertz(property('F3', 'Neptunus', 24, 'Planet', -1, 0, 0, 'F')),
    assertz(property('G1', 'α-Centaury', 26, 'Bintang', -1, 0, 0, 'G')),
    assertz(property('G2', 'Pollux', 27, 'Bintang', -1, 0, 0, 'G')),
    assertz(property('G3', 'Alcyone', 28, 'Bintang', -1, 0, 0, 'G')),
    assertz(property('H1', 'Teyvat',31, 'Undefined_Realm', -1, 0, 0, 'H')),
    assertz(property('H2', 'Isekai', 32, 'Weaboo_Realm', -1, 0, 0, 'H')).


% property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok). %contoh Tipe: bangunan 1, tanah, dst.

/*Rules*/
kepemilikan(P1, ID):-
    retract(list_player([P1, P2], Giliran)),
    assertz(list_player([P1, P2], Giliran)),
    retract(aset_pemain(P1, Uang1, Nilai_properti1, Daftar_properti1)),
    assertz(aset_pemain(P1, Uang1, Nilai_properti1, Daftar_properti1)),
    remover(ID, Daftar_properti1, Daftar_properti1_New),
    Daftar_properti1 \= Daftar_properti1_New,!.

kepemilikan(P2, ID):-
    retract(list_player([P1, P2], Giliran)),
    assertz(list_player([P1, P2], Giliran)),
    retract(aset_pemain(P2, Uang2, Nilai_properti2, Daftar_properti2)),
    assertz(aset_pemain(P2, Uang2, Nilai_properti2, Daftar_properti2)),
    remover(ID, Daftar_properti2, Daftar_properti2_New),
    Daftar_properti2 \= Daftar_properti2_New,!.

kepemilikan('None', ID):-
    retract(list_player([P1, P2], Giliran)),
    assertz(list_player([P1, P2], Giliran)),
    retract(aset_pemain(P1, Uang1, Nilai_properti1, Daftar_properti1)),
    assertz(aset_pemain(P1, Uang1, Nilai_properti1, Daftar_properti1)),
    retract(aset_pemain(P2, Uang2, Nilai_properti2, Daftar_properti2)),
    assertz(aset_pemain(P2, Uang2, Nilai_properti2, Daftar_properti2)),
    
    remover(ID, Daftar_properti1, Daftar_properti1_New),
    remover(ID, Daftar_properti2, Daftar_properti2_New),
    
    Daftar_properti1 == Daftar_properti1_New,
    Daftar_properti2 == Daftar_properti2_New,!.


getProperti([_X|Tail],_X).
getProperti([],_X) :- !.
getProperti([_X|Tail],_Y):-
    getProperti(Tail,_Y).

checkPropertyDetail(ID) :-
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4),
    % (propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    % X is 0 + Buy0,

    % write(Buy0),
    write('Nama Properti         : '),write(Nama_properti),nl,
    write('Deskripsi Properti    : '),write(Deskripsi_properti),nl,nl,
    write('Harga Tanah           : '),write(Buy0),nl,
    write('Harga Bangunan 1      : '),write(Buy1),nl,
    write('Harga Bangunan 2      : '),write(Buy2),nl,
    write('Harga Bangunan 3      : '),write(Buy3),nl,
    write('Harga Landmark        : '),write(Buy4),nl,nl,
    write('Biaya Sewa Tanah      : '),write(Rent0),nl,
    write('Biaya Sewa Bangunan 1 : '),write(Rent1),nl,
    write('Biaya Sewa Bangunan 2 : '),write(Rent2),nl,
    write('Biaya Sewa Bangunan 3 : '),write(Rent3),nl,
    write('Biaya Sewa Landmark   : '),write(Rent4),nl,nl,!.
    


payRent(NamaPemain, Indeks):-
    % getLocation(Indeks, )

    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    
    ((Tipe == -1);
    (Tipe \== -1) -> (
        kepemilikan(NamaPemilik, ID_Properti),
        (NamaPemilik == NamaPemain);
        (NamaPemilik \== NamaPemain) -> (
            write('    Kamu numpang di wilayah lawan, harus bayar rent yaaaaa sebesar '), write(Rent),nl,
            retract(aset_pemain(NamaPemain, UangPemain, Nilai_properti_Pemain, Daftar_properti_Pemain)),
            
            UangPemainNew is UangPemain - Rent,
            % nnti ditambahin kondisi ketika uang < 0 (mekanisme bangkrut)
            assertz(aset_pemain(NamaPemain, UangPemainNew, Nilai_properti_Pemain, Daftar_properti_Pemain)),
            
            retract(aset_pemain(NamaPemilik, UangPemilik, Nilai_properti_Pemilik, Daftar_properti_Pemilik)),
            UangPemilikNew is UangPemilik + Rent,
            assertz(aset_pemain(NamaPemilik, UangPemilikNew, Nilai_properti_Pemilik, Daftar_properti_Pemilik))        
        )
    )).

    


% sellProperty(NamaPemain):-
%     retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
%     displayProperty