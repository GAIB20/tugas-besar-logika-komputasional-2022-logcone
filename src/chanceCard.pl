addCard(X) :-
    retract(card_pemain(Nama, Daftar_card)),
    assertz(card_pemain(Nama, [Daftar_card|X])).

chanceCard :-
    % random generator,
    _X is random(),
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
        addCard('TX')
        ;
    _X =:= 2 -> 
        format('-------------------------------------------------~n', []),
        format('|                  GIFT CARD                    |~n', []),
        format('-------------------------------------------------~n', []),
        format('                ~n', []),
        format('                GET MONEY FROM BANK              ~n', []),
        format('                 $ ~d ~n', [Random]),
        format('                ~n', []),
        format('-------------------------------------------------~n', []),
        addCard('GC')
        ;
    _X =:= 3 -> 
        format('-------------------------------------------------~n', []),
        format('|                FREE FROM JAIL                  |~n', []),
        format('-------------------------------------------------~n', []),
        format('|                                               |~n', []),
        format('|                  HORAY FREEE                  |~n', []),
        format('|                                               |~n', []),
        format('-------------------------------------------------~n', [])
        addCard('FJ')
        ;
    _X =:= 4 -> 
        format('-------------------------------------------------~n', []),
        format('|                 GO TO JAIL                    |~n', []),
        format('-------------------------------------------------~n', []),
        format('|                                               |~n', []),
        format('|            KORUPSINYA KETAUAN GAN             |~n', []),
        format('|                                               |~n', []),
        format('-------------------------------------------------~n', [])
        addCard('GJ')
        ;
            fail
    ).