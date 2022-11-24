:- include('player.pl').
:- include('peta.pl').
:- include('dice.pl').
:- include('chanceCard.pl').
:- include('jail.pl').
:- include('buynupgrade.pl').

startgame:-
    initPlayer,
    initMap,!.