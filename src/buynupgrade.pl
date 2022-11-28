checkProperty(Indeks) :-
    Indeks =\= 5,
    Indeks =\= 9,
    Indeks =\= 13,
    Indeks =\= 17,
    Indeks =\= 21,
    Indeks =\= 25,
    Indeks =\= 29,
    Indeks =\= 30;
    write('\nLokasi ini tidak bisa dibeli\\diupgrade!\n'), !, fail.

buy :-
    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),
    
    retract(lokasi_pemain(Nama, Indeks)),
    assertz(lokasi_pemain(Nama, Indeks)),
    checkProperty(Indeks),
    propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4),
    kepemilikan(Pemilik, ID),
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    % write(Pemilik),
    
    (
        (Pemilik == 'None' -> 
            write('\n    Ingin bangun sampai tingkat berapa? (0/1/2/3): '),  
            read(Tingkat),
            (
                (Tingkat == 0 -> HargaBuy is Buy0, 
                                RentNew is Rent0);
                (Tingkat == 1 -> HargaBuy is Buy0 + Buy1, 
                                RentNew is Rent1);
                (Tingkat == 2 -> HargaBuy is Buy0 + Buy1 + Buy2, 
                                RentNew is Rent2);
                (Tingkat == 3 -> HargaBuy is Buy0 + Buy1 + Buy2 + Buy3, 
                                RentNew is Rent3);
                write('    Input tingkat tidak valid >:(\n'), 
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tingkat, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
                !, fail
            ),
            UangNew is Uang - HargaBuy,
            (
                (UangNew < 0 -> 
                    write('\n    Km gpunya uang yg cukup\n'), 
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, RentNew, Akuisisi, Blok)),
                    assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                );

                (UangNew >= 0 ->
                    Nilai_properti_new is Nilai_properti + HargaBuy, 
                    appendList(Daftar_properti, ID, Daftar_properti_new),
                    AkuisisiNew is HargaBuy*2,
                    assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tingkat, RentNew, AkuisisiNew, Blok)),
                    assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new)),
                    write('    Selamat km berhasil beli properti baru :>'),
                    getXY(Indeks, X, Y),
                    retract(map(M)),
                    changeMapStatus(M, X, Y, Tingkat, Giliran, Mout),
                    assertz(map(Mout)),
                    displayMap(Mout)
                ), !
            )
        );

        (Pemilik == Nama -> 
            write('\n    Bangunan ini dah jadi punya u, ketik upgrade kalo mau upgrade y brow\n'),
            assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
            assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
        );

        ((Pemilik \== 'None', Pemilik \== Nama) -> UangNew is Uang - Akuisisi,
                (
                    ( Tipe =\= 4 ->
                        (
                            (UangNew < 0 ->  
                                write('\n    Km gpunya uang yg cukup\n'),
                                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                            );                                            

                            (UangNew >= 0 -> 
                                appendList(Daftar_properti, ID, Daftar_properti_new),
                                Nilai_properti_new is Nilai_properti + div(Akuisisi, 2),
                                AkuisisiNew is div(Akuisisi, 2),
                                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                                assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new)),
                            
                                GiliranNew is (Giliran mod 2) + 1, 
                                getElmtList(ListNama, GiliranNew, NamaPemilikOld),
                                retract(aset_pemain(NamaPemilikOld, UangOld, Nilai_properti_old, Daftar_properti_old)),
                                remover(ID, Daftar_properti_old, Daftar_properti_new2),
                                Nilai_properti_updated is Nilai_properti_old - div(Akuisisi, 2),
                                assertz(aset_pemain(NamaPemilikOld, UangOld, Nilai_properti_updated, Daftar_properti_new2)),
                                write('    Km berhasil ambil alih properti musuh :>>'),
                                getXY(Indeks, X, Y),
                                retract(map(M)),
                                changeMapStatus(M, X, Y, Tipe, Giliran, Mout),
                                assertz(map(Mout)),
                                displayMap(Mout)
                            )
                        )     
                    );
                    (
                        write('\n    Sudah landmark, gbs diakuisisi yyyy!\n'),
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
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
    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),

    retract(lokasi_pemain(Nama, Indeks)),
    assertz(lokasi_pemain(Nama, Indeks)),

    checkProperty(Indeks),

    kepemilikan(Pemilik, ID),

    (
        Pemilik == Nama,
        true;
        write('    Kamu tidak bisa upgrade sesuatu yang bukan punyamu! >:(\n'),
        !, fail
    ),
    
    retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),

    propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4),
    (
        (
            (Tipe == 0 -> write('    Mau upgrade jadi apa? (1-3) '), read(Up),
                (
                    (Up == 1 -> 
                        UangNew is Uang - Buy1,
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + Buy1, TipeNew is 1,
                        AkuisisiNew is Akuisisi + (Buy1 * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent1, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (Up == 2 ->  
                        UangNew is Uang - (Buy1+Buy2),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy1+Buy2), 
                        TipeNew is 2,
                        AkuisisiNew is Akuisisi + ((Buy1+Buy2) * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent2, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (Up == 3 ->  
                        UangNew is Uang - (Buy1+Buy2 + Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy1+Buy2+Buy3), 
                        TipeNew is 3, 
                        AkuisisiNew is Akuisisi + ((Buy1+Buy2+Buy3) * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent3, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (
                        write('    Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 1 -> write('    Mau upgrade jadi apa? (2-3) '), read(Up),
                (
                    (Up == 2 ->  
                        UangNew is Uang - (Buy2),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy2), 
                        TipeNew is 2,
                        AkuisisiNew is Akuisisi + ((Buy2) * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent2, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (Up == 3 -> 
                        UangNew is Uang - (Buy2 + Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy2+Buy3), 
                        TipeNew is 3, 
                        AkuisisiNew is Akuisisi + ((Buy2+Buy3) * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent3, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (
                        write('    Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 2 -> write('    Mau upgrade jadi apa? (3) '), read(Up),
                (
                    (Up == 3 -> 
                        UangNew is Uang - (Buy3),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy3), 
                        TipeNew is 3,
                        AkuisisiNew is Akuisisi + ((Buy3) * 2),
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), 
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent3, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (
                        write('    Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );
            
            (Tipe == 3 -> write('    Mau upgrade jadi apa? (4) '), read(Up),
                (
                    (Up == 4 -> 
                        UangNew is Uang - (Buy4),
                        UangNew >= 0,
                        Nilai_properti_new is Nilai_properti + (Buy4), 
                        TipeNew is 4, 
                        assertz(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)),
                        AkuisisiNew is Akuisisi + ((Buy4) * 2),
                        assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent4, AkuisisiNew, Blok)),
                        write('    Km berhasil upgrade :>>'),
                        getXY(Indeks, X, Y),
                        retract(map(M)),
                        changeMapStatus(M, X, Y, Up, Giliran, Mout),
                        assertz(map(Mout)),
                        displayMap(Mout)
                    );
                    (
                        write('    Input upgrade tidak valid >:(\n'),
                        retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
                    )
                )
            );

            (Tipe == 4 -> 
                write('    Udah jadi landmark, ngapain mau di upgrade lagi >:(\n'),
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
            );

            (
                write('    Input tipe tidak valid\n'),
                assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
            )
        );

        (
            write('    Uangmu tidak mencukupi :(\n'),
            assertz(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
            assertz(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)), !, fail
        )
    ).