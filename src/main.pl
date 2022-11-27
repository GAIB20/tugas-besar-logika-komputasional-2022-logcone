:- include('player.pl').
:- include('peta.pl').
:- include('dice.pl').
:- include('chanceCard.pl').
:- include('jail.pl').
:- include('buynupgrade.pl').
:- include('properti.pl').

startgame:-
    initPlayer,
    initProperty,
    initMap,!.

reset :-
    retractall(nama_pemain(_)),
    retractall(aset_pemain(_, _, _, _)),
    retractall(lokasi_pemain(_, _, _)),
    retractall(card_pemain(_, _)),
    retractall(count_pemain(_, _, _)),
    retractall(map(_)),
    retractall(property(_, _, _, _, _, _, _)).