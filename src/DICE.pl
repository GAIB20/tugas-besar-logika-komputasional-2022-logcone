:- include('player.pl')

throwDice :- 
    turn(Player),
    random(1, 7, Dadu_1), 
    random(1, 7, Dadu_2), 
    write('Dadu 1 : '),write(Dadu_1), nl,
    write('Dadu 2 : '), write(Dadu_2),nl, 
    Dadu is Dadu_1 + Dadu_2, 
    write('Anda Maju sebanyak '), write(Dadu), write(' langkah'), nl,
    lokasi_pemain(Player, Indeks),
    IndeksNew is (Indeks + Dadu) mod 32,
    lokasi_pemain(Player, IndeksNew),
    Dadu_1 =:= Dadu_2, 
    count_pemain(Player, _, Count_double),
    Count_doubleNew is Count_double + 1,
    count_pemain(Player,_, Count_doubleNew),
    write('Double!'),
    turn(player).







