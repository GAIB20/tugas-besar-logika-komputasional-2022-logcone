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
    % random(1,5,_X),
    % write('hooray'),
    random(20,150,_Y),
    _X is 2,
    
    ((_X == 1 -> 
        payTax(Nama, Tax),
        moveToTax(Nama),
        write('    -------------------------------------------------'),nl,
        write('    |                  TAX CARD                     |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |                 PAY TAX OF                    |'),nl,
        write('                        '),write(Tax),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    Anda dipindahkan ke lokasi TAX terdekat >_o')) % kemudian manggil predicate yang tujuannya mindahin player ke lokasi tax terdekat
        ;
    (_X == 2 -> 
        write('    -------------------------------------------------'),nl,
        write('    |                  GIFT CARD                    |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |             GET MONEY FROM BANK               |'),nl,
        write('                         '),write(_Y),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        retract(aset_pemain(Nama, Uang, Nilai_properti, Daftar_properti)),
        UangNew is Uang + _Y,
        assertz(aset_pemain(Nama, UangNew, Nilai_properti, Daftar_properti)))
        ;
    (_X == 3 -> 
        write('    -------------------------------------------------'),nl,
        write('    |                FREE FROM JAIL                 |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |                 HORAY FREEE                   |'),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        addCard(Nama, 'FJ'))
        ;
    (_X == 4 -> 
        write('    -------------------------------------------------'),nl,
        write('    |                 GO TO JAIL                    |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |            KORUPSINYA KETAUAN GAN             |'),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        addCard(Nama, 'GJ')
    )).   % kemudian manggil predicate jail
    