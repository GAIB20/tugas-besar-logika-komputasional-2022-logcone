% :-include('player.pl').
% :-include('buynupgrade.pl').

moveToTax(Nama):-
    retract(lokasi_pemain(Nama, IndexLoc)),
    (((IndexLoc == 5) -> IndexNew is 13);
    ((IndexLoc == 30) -> IndexNew is 13);
    ((IndexLoc == 21 -> IndexNew is 29))),
    assertz(lokasi_pemain(Nama, IndexNew)).

addCard(Nama, X) :-
    retract(card_pemain(Nama, Daftar_card)),
    assertz(card_pemain(Nama, [X|Daftar_card])).

chanceCard(Nama) :-
    % random generator,
    random(1,6,_X),
    random(20,150,_Y),
    % _X is 1,
    
    ((_X == 1 -> 
        payTax(Nama, Tax),
        moveToTax(Nama),
        % Tax is 30,
        write('\n    ================================================='),nl,
        write('    ||               TAAT BAYAR PAJAK              ||'),nl,
        write('    ================================================='),nl,
        write('    ||                                             ||'),nl,
        write('    ||  MY POST : GANTENG? REVIEW SALDONYA DONGGG  ||'),nl,
        write('    ||    NOTIF : DITJEN PAJAK REPLY YOUR POST     ||'),nl,
        write('    ||           GANTENGNYAAAA !! (love)           ||'),nl,
        write('                        '),write(Tax),nl,
        write('    ||                                             ||'),nl,
        write('    =================================================\n'),nl,
        write('    Anda dipindahkan ke lokasi TAX terdekat >_o')) % kemudian manggil predicate yang tujuannya mindahin player ke lokasi tax terdekat
        ;
    (_X == 2 -> 
        write('\n    ================================================='),nl,
        write('    ||             DAPETT DUIT NIHHH               ||'),nl,
        write('    ================================================='),nl,
        write('    ||                                             ||'),nl,
        write('    ||         GAK ADA ANGIN GK ADA UJAN           ||'),nl,
        write('    ||         EHH HASIL NGEPET DAH CAIR           ||'),nl,
        write('    ||            TERIMA KASIH CUKIOK              ||'),nl,
        write('                         '),write(_Y),nl,
        write('    ||                                             ||'),nl,
        write('    =================================================\n'),nl,
        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
        UangNew is Uang + _Y,
        assertz(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)))
        ;
    (_X == 3 -> 
        write('\n    ================================================='),nl,
        write('    ||             BEBAS PENJARA NIHHH             ||'),nl,
        write('    ================================================='),nl,
        write('    ||                                             ||'),nl,
        write('    ||       KAMU SANGAT BERUNTUNG TERNYATA        ||'),nl,
        write('    ||          BEKINGAN KAMU SANGAT KUAT          ||'),nl,
        write('    ||        BEKINGAN KAMU TERNYATA ZAMBOO        ||'),nl,
        write('    ||                                             ||'),nl,
        write('    =================================================\n'),nl,
        addCard(Nama, 'FJ'))
        ;
    (_X == 4 -> 
        write('\n    ================================================='),nl,
        write('    ||           MASUK PENJARA DULU GAN            ||'),nl,
        write('    ================================================='),nl,
        write('    ||                                             ||'),nl,
        write('    ||          NAH LOHHH MASUK JUGA KAN           ||'),nl,
        write('    ||     BEKINGAN KAMU GAMAU BANTU SOALNYA       ||'),nl,
        write('    ||    GAPAPA YA PENJARANYA KAYAK HOTEL KOK     ||'),nl,
        write('    ||                                             ||'),nl,
        write('    =================================================\n'),nl,
        addCard(Nama, 'GJ'))
        ;
    (_X == 5 ->
        write('\n    ================================================='),nl,
        write('    ||       HAHA KAMU NANYEA INI KARTU APA ???    ||'),nl,
        write('    ================================================='),nl,
        write('    ||                                             ||'),nl,
        write('    ||        KARTU INI GK AKAN NGARUH APA2        ||'),nl,
        write('    ||       SEPERTI EFFORT KAMU KE SI \'DIA\'     ||'),nl,
        write('    ||        SAMA2 GK AKAN NGARUHIN HATINYA       ||'),nl,
        write('    ||                                             ||'),nl,
        write('    =================================================\n'),nl
    )
    ).   % kemudian manggil predicate jail
    