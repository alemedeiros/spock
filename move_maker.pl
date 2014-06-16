% move_maker.pl
%   by alemedeiros <alexandre.n.medeiros _at_ gmail.com>
%
% Name:   Alexandre Novais de Medeiros
% RA:     115966
%
% Player for MC346 (Programming Paradigms) robot fight competition.
%
% Move maker part of spock

:- module(move_maker, [build_board/2, move/5]).
:- use_module(board_analyser).

:- dynamic board/3.

% A move is a valid move.
move(Player, SrcI, SrcJ, DestI, DestJ) :-
    valid_move(Player, SrcI, SrcJ, DestI, DestJ).

% Generate a valid move.
valid_move(Player, SrcI, SrcJ, DestI, DestJ) :-
    board(SrcI, SrcJ, Src),
    owned_robot(Src, Player),
    board(DestI, DestJ, Dest),
    neighbours(SrcI, SrcJ, DestI, DestJ),
    valid_destination(Dest, Player).

% Build board for easier access.
build_board(_, []) :- !.
build_board(I, [H|T]) :-
    build_board_line(I, 0, H),
    NI is I + 1,
    build_board(NI, T).

% Build board line, auxiliar predicate for build_board.
build_board_line(_, _, []) :- !.
build_board_line(I, J, [H|T]) :-
    assertz(board(I, J, H)),
    NJ is J + 1,
    build_board_line(I, NJ, T).

% vim:set ft=prolog:
