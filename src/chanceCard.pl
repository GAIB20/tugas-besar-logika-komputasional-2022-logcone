addCard(Nama, X) :-
    retract(card_pemain(Nama, Daftar_card)),
    assertz(card_pemain(Nama, [X|Daftar_card])).

chanceCard(Nama) :-
    % random generator,
    random(1,5,_X),
    random(5,31,_Y),
    (
    _X =:= 1 -> 
        format('-------------------------------------------------~n', []),
        format('|                  TAX CARD                     |~n', []),
        format('-------------------------------------------------~n', []),
        format('        ~n', []),
        format('                  PAY TAX OF                     ~n', []),
        format('                     $15                         ~n', []),
        format('        ~n', []),
        format('-------------------------------------------------~n', []),
        addCard(Nama, 'TX'), % kemudian manggil predicate yang tujuannya mindahin player ke lokasi tax terdekat 
        ;
    _X =:= 2 -> 
        format('-------------------------------------------------~n', []),
        format('|                  GIFT CARD                    |~n', []),
        format('-------------------------------------------------~n', []),
        format('                ~n', []),
        format('                GET MONEY FROM BANK              ~n', []),
        format('                 $ ~d ~n', [_Y]),
        format('                ~n', []),
        format('-------------------------------------------------~n', []),
        addCard(Nama, 'GC')
        ;
    _X =:= 3 -> 
        format('-------------------------------------------------~n', []),
        format('|                FREE FROM JAIL                  |~n', []),
        format('-------------------------------------------------~n', []),
        format('|                                               |~n', []),
        format('|                  HORAY FREEE                  |~n', []),
        format('|                                               |~n', []),
        format('-------------------------------------------------~n', [])
        addCard(Nama, 'FJ')
        ;
    _X =:= 4 -> 
        format('-------------------------------------------------~n', []),
        format('|                 GO TO JAIL                    |~n', []),
        format('-------------------------------------------------~n', []),
        format('|                                               |~n', []),
        format('|            KORUPSINYA KETAUAN GAN             |~n', []),
        format('|                                               |~n', []),
        format('-------------------------------------------------~n', [])
        addCard(Nama, 'GJ'), goToJail(Nama)   % kemudian manggil predicate jail
        ;
            fail
    ).