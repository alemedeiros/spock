:- use_module(library(dcg/basics)).

%Gramatica do Parser
board(Z) --> line(X), {Z = [X]}.
board(Z) --> line(X), board(Y), {Z = [X | Y]}.

line(L) --> sqr(X), [10], {L = [X]}.
line(L) --> sqr(X), line(Y), {L = [X | Y]}.

sqr(S) --> resource(S).
sqr(S) --> robot(S).
sqr(S) --> wall(S).
sqr(S) --> empty(S).

wall(W) --> "XX", {W = "X"}.
empty(E) --> "..", {E = "."}.
robot(R) --> player(P), integer(N), {R = [P,N]}.
resource(R) --> "R", integer(N), {R = ["R",N]}.

player(P) --> "A", {P = "A"}.
player(P) --> "B", {P = "B"}.

%Predicados para parsing do tabuleiro todo ou
% linha a linha
parse_board(L, V) :- board(V, L, []).
parse_line(L, V) :- line(V, L, []).
