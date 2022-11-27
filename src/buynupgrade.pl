buy :-
    retract(list_player(ListNama, Giliran)),
    assertz(list_player(ListNama, Giliran)),
    getElmtList(ListNama, Giliran, Nama),

    retract(lokasi_pemain(Nama, Indeks)),
    asserta(lokasi_pemain(Nama, Indeks)),
    
    % retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
    % retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    
    % retract(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    % asserta(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
    
    kepemilikan(Pemilik, ID),
    % write(Pemilik). 
    write('    Ingin bangun sampai tingkat berapa? (0/1/2/3): '), nl,
    read(Tingkat),
    (
    (Pemilik == 'None' -> (
                          (Tingkat =:= 0 -> HargaBuy is Buy0, 
                                            RentNew is Rent0);
                          (Tingkat =:= 1 -> HargaBuy is Buy0 + Buy1, 
                                            RentNew is Rent0 + Rent1);
                          (Tingkat =:= 2 -> HargaBuy is Buy0 + Buy1 + Buy2, 
                                            RentNew is Rent0 + Rent1 + Rent2);
                          (Tingkat =:= 3 -> HargaBuy is Buy0 + Buy1 + Buy2 + Buy3, 
                                            RentNew is Rent0 + Rent1 + Rent2 + Rent3)
                          ),
                          UangNew is Uang - HargaBuy,
                          (
                          (UangNew < 0 -> write('    Km gpunya uang yg cukup'), 
                                        %  asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                                         asserta(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)));

                          (UangNew >= 0 -> Nilai_properti_new is Nilai_properti + HargaBuy, 
                                          appendList(Daftar_properti, ID, Daftar_properti_new),
                                        %   AkuisisiNew is Nilai_properti_new*2
                                        %   asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tingkat, RentNew, AkuisisiNew, Blok)),
                                          asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti_new)))
                          )
    );

    (Pemilik == Nama -> write('    \nBangunan ini dah jadi punya u, ketik upgrade kalo mau upgrade y brow'));

    % ((Pemilik == 'satu') -> write('satu'))
    ((Pemilik =\= 'None', Pemilik =\= nama) -> UangNew is Uang - Akuisisi,
                                             UangNew < 0 -> write('    Km gpunya uang yg cukup'),
                                            %  asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                                            %  asserta(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti));                                            

                                            UangNew >= 0 -> appendList(Daftar_properti, ID, Daftar_properti_new),
                                                            asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
                                                            asserta(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti_new)),
                                                            
                                                            GiliranNew is (Giliran mod 2) + 1, 
                                                            getElmtList(ListNama, GiliranNew, NamaPemilik),
                                                            retract(aset_pemain(NamaPemilikOld, Uang, Nilai_properti, Daftar_properti_old)),
                                                            remover(ID, Daftar_properti_old, Daftar_properti_new2),
                                                            retract(aset_pemain(NamaPemilikOld, Uang, Nilai_properti, Daftar_properti_new2))
                                                            
        )
                                                            
    )
    
    
    


    .

payTax(Nama, Tax) :-
    retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
    Tax is 0.1*(Uang + Nilai_properti),
    UangNew is Uang - Tax,
    asserta(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)).

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
    

% upgrade :-
%     retract(lokasi_pemain(Nama, Indeks)),
%     retract(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
%     retract(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
%     retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
%     asserta(lokasi_pemain(Nama, Indeks)),
%     % asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, Tipe, Rent, Akuisisi, Blok)),
%     asserta(propertyValue(ID, Buy0, Buy1, Buy2, Buy3, Buy4, Rent0, Rent1, Rent2, Rent3, Rent4)),
%     (Tipe =:= 0 -> write('mau upgrade jadi apa? (1-3) '), read(Up),
%         (Up =:= 1 -> UangNew is Uang - Buy1, Nilai_properti_new is Nilai_properti + Buy1, TipeNew is 1, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
%         Up =:= 2 ->  UangNew is Uang - (Buy1+Buy2), Nilai_properti_new is Nilai_properti + (Buy1+Buy2), TipeNew is 2, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
%         Up =:= 3 ->  UangNew is Uang - (Buy1+Buy2 + Buy3), Nilai_properti_new is Nilai_properti + (Buy1+Buy2+Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
%     Tipe =:=1 -> write('mau upgrade jadi apa? (2-3) '), read(Up),
%         (Up =:= 2 ->  UangNew is Uang - (Buy2), Nilai_properti_new is Nilai_properti + (Buy2), TipeNew is 2, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok));
%         Up =:= 3 -> UangNew is Uang - (Buy2 + Buy3), Nilai_properti_new is Nilai_properti + (Buy2+Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
%     Tipe =:= 2 -> write('mau upgrade jadi apa? (3) '), read(Up),
%         (Up =:= 3 -> UangNew is Uang - (Buy3), Nilai_properti_new is Nilai_properti + (Buy3), TipeNew is 3, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),);
%     Tipe =:= 3 -> write('mau upgrade jadi apa? (4) '), read(Up),
%         (Up =:= 4 -> UangNew is Uang - (Buy4), Nilai_properti_new is Nilai_properti + (Buy4), TipeNew is 4, asserta(aset_pemain(Nama, UangNew, Nilai_properti_new, Daftar_properti)), asserta(property(ID, Nama_properti, Indeks, Deskripsi_properti, TipeNew, Rent, Akuisisi, Blok)),) ).
    
