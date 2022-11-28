
buy :-
    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),
    
    retract(lokasi_pemain(Nama, Indeks)),
    assertz(lokasi_pemain(Nama, Indeks)),
   
    propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4),
    kepemilikan(Pemilik, ID),
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    % write(Pemilik),
    write(Buy0),
    
    (
        (Pemilik == 'None' -> 
            write('Ingin bangun sampai tingkat berapa? (0/1/2/3): \n'),  
            read(Tingkat),
            (
                (Tingkat == 0 -> HargaBuy is Buy0, 
                                RentNew is Rent0);
                (Tingkat == 1 -> HargaBuy is Buy0 + Buy1, 
                                RentNew is Rent0 + Rent1);
                (Tingkat == 2 -> HargaBuy is Buy0 + Buy1 + Buy2, 
                                RentNew is Rent0 + Rent1 + Rent2);
                (Tingkat == 3 -> HargaBuy is Buy0 + Buy1 + Buy2 + Buy3, 
                                RentNew is Rent0 + Rent1 + Rent2 + Rent3);
                write('Input tingkat tidak valid >:(\n'), 
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
                !, fail
            ),
            UangNew is Uang - HargaBuy,
            (
                (UangNew < 0 -> 
                    write('    Km gpunya uang yg cukup'), 
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                    assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti))
                ), !;

                (UangNew >= 0 ->
                    Nilai_properti_new is Nilai_properti + HargaBuy, 
                    appendList(Daftar_properti, ID, Daftar_properti_new),
                    AkuisisiNew is Nilai_properti_new*2,
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tingkat, RentNew, AkuisisiNew, Blok)),
                    assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new))
                ), !
            )
        );

    (Pemilik == Nama -> 
        write('    \nBangunan ini dah jadi punya u, ketik upgrade kalo mau upgrade y brow'),
        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
        assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti))
    );

    ((Pemilik \== 'None', Pemilik \== Nama) -> UangNew is Uang - Akuisisi,
            (
                (UangNew < 0 ->  
                    write('Km gpunya uang yg cukup'),
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                    assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti))
                );                                            

                (UangNew >= 0 -> 
                    appendList(Daftar_properti, ID, Daftar_properti_new),
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                    Nilai_properti_new is Nilai_properti + div(Akuisisi, 2),
                    assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new)),
                
                    GiliranNew is (Giliran mod 2) + 1, 
                    getElmtList(ListNama, GiliranNew, NamaPemilikOld),
                    retract(aset_pemain(NamaPemilikOld, UangOld, Nilai_properti_old, Daftar_properti_old)),
                    remover(ID, Daftar_properti_old, Daftar_properti_new2),
                    Nilai_properti_updated is Nilai_properti_old - div(Akuisisi, 2),
                    assertz(aset_pemain(NamaPemilikOld, UangOld, Nilai_properti_updated, Daftar_properti_new2))
                )
            )                                  
        )
    ).

payTax(Nama, Tax) :-
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    Tax is 0.1*(Uang + Nilai_properti),
    UangNew is Uang - Tax,
    assertz(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)).

worldTour(Pemain) :-
    write('    Pilih nama lokasi yang ingin kamu kunjungi'),nl,
    write('    Format penulisan sesuai map dengan tanda kutip. Contoh:  \'A1\'\n    Masukkan nama lokasi: '),
    read(LocName),
    % write(LocName),
    getMapIndex(LocName, Index),
    % write(Index),
    ((Index \= 25 ->  retract(lokasi_pemain(Pemain, Indexold)), 
                    %   write(Pemain),
                      assertz(lokasi_pemain(Pemain, Index)),
                      write('    Anda sudah sampai di lokasi tujuan'),nl
                    %   retract(lokasi_pemain(Pemain, Indexxx)),
                    %   write(Pemain), assertz(lokasi_pemain(Pemain, Indexxx))
                      );
    (Index == 25 -> write('     Anda tidak boleh menuju ke world tour lagiiii nakal bgt'), nl, worldTour(Pemain))).
    

upgrade :-
    retract(lokasi_pemain(Nama, Indeks)),
    assertz(lokasi_pemain(Nama, Indeks)),

    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),

    propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4),
    (
        (
            (Tipe == 0 -> write('mau upgrade jadi apa? (1-3) '), read(Up),
                (
                    (Up == 1 -> 
                        UangNew is Uang - Buy1,
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + Buy1, TipeNew is 1, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (Up == 2 ->  
                        UangNew is Uang - (Buy1+Buy2),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy1+Buy2), 
                        TipeNew is 2, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (Up == 3 ->  
                        UangNew is Uang - (Buy1+Buy2 + Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy1+Buy2+Buy3), 
                        TipeNew is 3, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (
                        write('Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 1 -> write('mau upgrade jadi apa? (2-3) '), read(Up),
                (
                    (Up == 2 ->  
                        UangNew is Uang - (Buy2),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy2), 
                        TipeNew is 2, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (Up == 3 -> 
                        UangNew is Uang - (Buy2 + Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy2+Buy3), 
                        TipeNew is 3, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (
                        write('Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 2 -> write('mau upgrade jadi apa? (3) '), read(Up),
                (
                    (Up == 3 -> 
                        UangNew is Uang - (Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy3), 
                        TipeNew is 3, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (
                        write('Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 3 -> write('mau upgrade jadi apa? (4) '), read(Up),
                (
                    (Up == 4 -> 
                        UangNew is Uang - (Buy4),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy4), 
                        TipeNew is 4, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok))
                    );
                    (
                        write('Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );

            (Tipe == 4 -> 
                write('Udah jadi landmark, ngapain mau di upgrade lagi >:(\n'),
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
            );

            (
                write('Input tipe tidak valid\n'),
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
            )
        );

        (
            write('Uangmu tidak mencukupi :(\n'),
            assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
            assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
        )
    ).