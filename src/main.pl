:- include('player.pl').
:- include('peta.pl').
:- include('dice.pl').

startgame:-
    initPlayer,
    initMap,!.