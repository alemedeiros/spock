% spock.pl
%   by alemedeiros <alexandre.n.medeiros _at_ gmail.com>
%
% Name:   Alexandre Novais de Medeiros
% RA:     115966
%
% Player for MC346 (Programming Paradigms) robot fight competition.

:- use_module(move_maker).

% Top-Level goal.
main :-
    set_output(user_error),
    [ 'parser.pl' ],
    read_line_to_codes(user_input, [Player]),
    read_line_to_codes(user_input, Size),
    read_size(Size, Lstr, Cstr),
    number_codes(L, Lstr),
    number_codes(C, Cstr),
    read_board(L, Bstr),
    parse_board(Bstr, Brd),
    build_board(Brd, L, C),
    move(Player, SrcI, SrcJ, DestI, DestJ),
    set_output(user_output),
    writef("%n %t %t %t %t\n", [Player, SrcI, SrcJ, DestI, DestJ]), !.

% Read board from stdin a strings.
read_board(0, []) :- !.
read_board(Lin, Board) :-
    read_line_to_codes(user_input, B_line),
    L_aux is Lin - 1,
    read_board(L_aux, B_aux),
    append(B_line, [10 | B_aux], Board).    % 10 is '\n'

% Read line and column values from a string separeted by a space.
read_size([32 | C],       [], C) :- !.                    % 32 is ' '
read_size([H  | T], [H | NL], C) :- read_size(T, NL, C).

% vim:set ft=prolog:
