goToJail.

goToJail.
    % fact(param_1, count_double), 
    % moveTo(jailPos), 
/*
    Metode untuk keluar dari penjara
    1. Roll
        |___ Double
        |___ 3 kali
    2. card
    3. pay
*/
searchCard([_X|List], _X).
searchCard([], _Y) :- !.
searchCard([_X|_List], _Y) :- 
    searchCard(_List, _Y).

outFromJail(1).
    % fact(param_1, count_)
    % status jail = false
outFromJail(2).
    % searchCard(List, idx) ||| set default X = -1
    % delCard
    % status jail = false

outFromJail.
outFromJail(3, _X) :-
    _X > 1000,
    write('True'),!.

outFromJail(3, _X) :-
    _X =< 1000,
    write('False'),!.
