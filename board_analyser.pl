% board_analyser.pl
%  by alemedeiros <alexandre.n.medeiros _at_ gmail.com>
%  based on parser.pl by Eric Velten de Melo
%
% Name:   Alexandre Novais de Medeiros
% RA:     115966
%
% Player for MC346 (Programming Paradigms) robot fight competition.
%
% Board analysis part of spock.

:- module(board_analyser, [ opponent/2, owned_robot/2, valid_destination/2, neighbours/4 ]).

is_empty([46]). % 46 is '.'

is_wall([88]). % 88 is 'X'

is_robot([X, Y]) :-
    is_player(X),
    number(Y).

is_player(65). % 65 is 'A'
is_player(66). % 66 is 'B'

is_resource([82, Y]) :- % 82 is 'R'
    number(Y).

% A is opponent of B and B is opponent of A.
opponent(65, 66).
opponent(66, 65).

% Robot owned by Player
owned_robot([X, Y], X) :-
    is_robot([X, Y]).

% Right neighbour.
neighbours(SrcI, SrcJ, DestI, DestJ) :-
    DestI is SrcI,
    DestJ is SrcJ - 1.

% Below neighbour.
neighbours(SrcI, SrcJ, DestI, DestJ) :-
    DestI is SrcI - 1,
    DestJ is SrcJ.

% Left neighbour.
neighbours(SrcI, SrcJ, DestI, DestJ) :-
    DestI is SrcI,
    DestJ is SrcJ + 1.

% Above neighbour.
neighbours(SrcI, SrcJ, DestI, DestJ) :-
    DestI is SrcI + 1,
    DestJ is SrcJ.

% A valid destination is not a player's robot neither a wall.
valid_destination(Dest, Player) :-
    \+ owned_robot(Dest, Player),
    \+ is_wall(Dest), !.

/*
    % A resource is a valid destination for any player.
    valid_destination(Dest, _) :-
        is_resource(Dest).

    % An enemy robot is a valid destination for player.
    valid_destination(Dest, Player) :-
        is_robot(Dest),
        opponent(Player, Enemy),
        owned_robot(Dest, Enemy).

    % An empty is a valid destination for any player.
    valid_destination(Dest, _) :-
        is_empty(Dest).
*/

% vim:set ft=prolog:
