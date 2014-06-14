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
sqr(S)    --> [X,Y],              {square([X,Y],S)}.

parse_board(L, V) :- board(V, L, []).

square(L,S)     :- isEmpty(L), S = ".".
square(L,S)     :- isWall(L), S = "X".
square([X,Y],S) :- isRobot([X,Y]), number_codes(N,[Y]), S = [X,N].
square([X,Y],S) :- isResource([X,Y]), number_codes(N,[Y]), S = [X,N].

isEmpty(L) :- \+ dif(L,"..").

isWall(L) :- \+ dif(L,"XX").

isRobot([X,Y]) :-
    isPlayer(X),
    number(Y).

isPlayer(65). % Player A
isPlayer(66). % Player B

isResource([82,Y]) :- number(Y). % 82 is 'R'

% vim:set ft=prolog:
