% move_maker.pl
%   by alemedeiros <alexandre.n.medeiros _at_ gmail.com>
%
% Name:   Alexandre Novais de Medeiros
% RA:     115966
%
% Player for MC346 (Programming Paradigms) robot fight competition.
%
% Move maker part of spock

:- module(move_maker, [build_board/3, move/5]).
:- use_module(board_analyser).

:- dynamic board/3.
:- dynamic robot/3.

% A move is a valid move.
move(Player, SrcI, SrcJ, DestI, DestJ) :-
    %listing,
    valid_move(Player, SrcI, SrcJ, DestI, DestJ).

% Generate a valid move.
valid_move(Player, SrcI, SrcJ, DestI, DestJ) :-
    robot(SrcI, SrcJ, Src),
    owned_robot(Src, Player),
    %writef("src: %t %t\n", [SrcI, SrcJ]),
    neighbours(SrcI, SrcJ, DestI, DestJ),
    board(DestI, DestJ, Dest),
    valid_destination(Dest, Player), !.
    %writef("dst: %t %t\n", [DestI, DestJ]), !.

% Build board for easier access.
build_board(Brd, L, C) :-
    build_board_aux(0, Brd),
    asserta((board(I, _, _) :- I >= L, !, fail) ),
    asserta((board(I, _, _) :- I < 0, !, fail) ),
    asserta((board(_, J, _) :- J >= C, !, fail) ),
    asserta((board(_, J, _) :- J < 0, !, fail) ).

build_board_aux(_, []) :- !.
build_board_aux(I, [H|T]) :-
    build_board_line(I, 0, H),
    NI is I + 1,
    build_board_aux(NI, T).

% Build board line, auxiliar predicate for build_board.
build_board_line(_, _, []) :- !.
build_board_line(I, J, [[P, L] |T]) :-
    (P == "A" ; P == "B"),
    assertz(board(I, J, [P, L])),
    assertz(robot(I, J, [P, L])),
    NJ is J + 1,
    build_board_line(I, NJ, T), !.

build_board_line(I, J, [H|T]) :-
    assertz(board(I, J, H)),
    NJ is J + 1,
    build_board_line(I, NJ, T).

% vim:set ft=prolog:
