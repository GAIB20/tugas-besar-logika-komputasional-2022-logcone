:-include('player.pl').

addCard(Nama, X) :-
    retract(card_pemain(Nama, Daftar_card)),
    assertz(card_pemain(Nama, [X|Daftar_card])).

chanceCard(Nama) :-
    % random generator,
    % random(1,5,_X),
    % write('hooray'),
    random(5,31,_Y),
    _X is 4,
    
    ((_X == 1 -> 
        write('    -------------------------------------------------'),nl,
        write('    |                  TAX CARD                     |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |                 PAY TAX OF                    |'),nl,
        write('    |                    bla                        |'),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        payTax(Nama)) % kemudian manggil predicate yang tujuannya mindahin player ke lokasi tax terdekat
        ;
    (_X == 2 -> 
        write('    -------------------------------------------------'),nl,
        write('    |                  GIFT CARD                    |'),nl,
        write('    -------------------------------------------------'),nl,
        write('    |                                               |'),nl,
        write('    |             GET MONEY FROM BANK               |'),nl,
        write('    |                     bla                       |'),nl,
        write('    |                                               |'),nl,
        write('    -------------------------------------------------'),nl,
        addCard(Nama, 'GC'))
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
    