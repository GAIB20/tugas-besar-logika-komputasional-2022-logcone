/* Facts */
:- dynamic(property/8).
% :- include('player.pl').

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
    


payRent(Pemilik, ID_Properti):-
    retract(aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti)),
    retract(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    NewMoney is Uang - Rent,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).

payAkuisisi(Pemilik, ID_Properti):-
    aset_pemain(Pemilik, Uang, Nilai_properti, Daftar_properti),
    property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok),
    NewMoney is Uang - Akuisisi,
    asserta(property(ID_Properti, Nama_properti, Indeks, Deskripsi_properti, Tipe, NewMoney, Akuisisi, Blok)).

hargaSewa(ID_Properti, Tipe_bangunan, Biaya_sewa).
hargaAkuisisi(ID_Properti, Tipe_bangunan, Biaya_akuisisi).
deskripsiProperti(ID_Properti, Indeks, Nama_properti, Deskripsi_properti).
initProperty:- %Parameter harga, nama lokasi, dan deskripsi lokasi bisa diganti nanti
    deskripsiProperti('A1', 'Jakarta',2, 'Ibukota Indonesia'),
    deskripsiProperti('A2', 'Manila',3, 'Ibukota Filipina'),
    deskripsiProperti('A3', 'Bangkok', 4,'Ibukota Thailand'),
    deskripsiProperti('B1', 'Tokyo', 6,'Ibukota Tokyo'),
    deskripsiProperti('B2', 'Beijing',7,'Ibukota China'),
    deskripsiProperti('B3', 'Seoul',8,'Ibukota Korea'),
    deskripsiProperti('C1', 'Dubai',10,'Kota Elit Unit Emirat Arab'),
    deskripsiProperti('C2', 'Kairo',11,'Ibukota Mesir'),
    deskripsiProperti('C3', 'New_Delhi',12, 'Ibukota India'),
    deskripsiProperti('D1', 'Hamburg', 14,'Ibukota Jerman'),
    deskripsiProperti('D2', 'Paris', 15, 'Ibukota Prancis'),
    deskripsiProperti('D3', 'London', 16, 'Ibukota Inggris'),
    deskripsiProperti('E1', 'New_York', 18, 'Kota kebanggaan Amerika Serikat'),
    deskripsiProperti('E2', 'Panama', 19, 'Ibukota Meksiko'),
    deskripsiProperti('E3', 'Washington', 20, 'Ibukota Amerika Serikat'),
    deskripsiProperti('F1', 'Saturnus', 22, 'Planet'),
    deskripsiProperti('F2', 'Uranus', 23, 'Planet'),
    deskripsiProperti('F3', 'Neptunus', 24, 'Planet'),
    deskripsiProperti('G1', 'α-Centaury', 26, 'Bintang'),
    deskripsiProperti('G2', 'Pollux', 27, 'Bintang'),
    deskripsiProperti('G3', 'Alcyone', 28, 'Bintang'),
    deskripsiProperti('H1', 'Teyvat',31, 'Undefined_Realm'),
    deskripsiProperti('H2', 'Isekai', 32, 'Weaboo_Realm'),
    propertyValue('A1',15,37,75,150,168,10,25,50,75,75),
    propertyValue('A2',15,40,78,156,175,10,27,52,78,78),
    propertyValue('A3',15,43,81,162,182,10,29,54,81,81),
    propertyValue('B1',30,45,90,180,202,20,30,60,90,90),
    propertyValue('B2',30,48,93,186,209,20,32,62,93,93),
    propertyValue('B3',30,51,96,192,216,20,34,64,96,96),
    propertyValue('C1',45,54,108,216,243,30,36,72,108,108),
    propertyValue('C2',45,57,111,222,249,30,38,74,111,111),
    propertyValue('C3',45,60,114,228,256,30,40,76,114,114),
    propertyValue('D1',60,64,129,259,291,40,43,86,129,129),
    propertyValue('D2',60,67,132,265,298,40,45,88,132,132),
    propertyValue('D3',60,70,135,271,305,40,47,90,135,135),
    propertyValue('E1',75,77,155,311,349,50,51,103,155,155),
    propertyValue('E2',75,80,158,317,356,50,53,105,158,158),
    propertyValue('E3',75,83,161,323,363,50,55,107,161,161),
    propertyValue('F1',90,93,186,373,419,60,62,124,186,186),
    propertyValue('F2',90,96,189,379,426,60,64,126,189,189),
    propertyValue('F3',90,99,192,385,433,60,66,128,192,192),
    propertyValue('G1',105,111,223,447,503,70,74,149,223,223),
    propertyValue('G2',105,114,226,453,510,70,76,151,226,226),
    propertyValue('G3',105,117,229,459,517,70,78,153,229,229),
    propertyValue('H1',120,134,268,537,604,80,89,179,268,268),
    propertyValue('H2',120,137,271,543,611,80,91,181,271,271).


