% parser.pl
%  by alemedeiros <alexandre.n.medeiros _at_ gmail.com>
%  based on parser.pl by Eric Velten de Melo
%
% Name:   Alexandre Novais de Medeiros
% RA:     115966
%
% Player for MC346 (Programming Paradigms) robot fight competition.
%
% Parsing part of spock.

:- module(parser, [parse_board/2]).

% Grammar for Parser
board(Z)  --> line(X),            {Z = [X]}.
board(Z)  --> line(X), board(Y),  {Z = [X | Y]}.
line(L)   --> sqr(X), [10],       {L = [X]}.          % 10 is '\n'
line(L)   --> sqr(X), line(Y),    {L = [X | Y]}.
sqr(S)    --> [X | T],            {square([X | T], S)}.

parse_board(L, V) :- board(V, L, []).

square(L, S)       :- is_empty(L),                              S = ".".
square(L, S)       :- is_wall(L),                               S = "X".
square([X | T], S) :- is_robot([X | T]),    number_codes(N, T), S = [X, N].
square([X | T], S) :- is_resource([X | T]), number_codes(N, T), S = [X, N].

is_number([H | T]) :- code_type([H], digit), is_number(T).
is_number([H])     :- code_type([H], digit).

is_empty(L) :- \+ dif(L, "..").

is_wall(L)  :- \+ dif(L, "XX").

is_robot([X | T]) :- is_player(X), is_number(T).

is_player(65). % Player A
is_player(66). % Player B

is_resource([82 | T]) :- is_number(T).

% vim:set ft=prolog:
