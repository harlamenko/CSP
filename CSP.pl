% 13.
% Три купчихи — Олимпиада, Матрена и Евдокия — пили чай. Если бы Олимпиада
% выпила на 5 чашек больше, то она выпила бы столько, сколько две другие вместе. Если бы
% Матрена выпила бы на 9 чашек больше, то она выпила бы столько, сколько две другие вместе.
% Сколько каждая из трех купчих выпила чашек и у кого из них какое отчество, если известно,
% что: Уваровна пила чай вприкуску; количество чашек чая, выпитых Титовной, кратно трем;
% Карповна выпила 11 чашек.

:- op(100, xfy, '::').

howMuch([N1::F1::C1, N2::F2::C2, N3::F3::C3]) :-
    generateSolution([F1::C1, F2::C2, F3::C3]),
    testSolution([N1::C1, N2::C2, N3::C3]), !.

generateSolution(Res) :-
    carpovna(Carpovna),
    titovna(Titovna),
    uvarovna(Uvarovna, Titovna),
    Res = [uvarovna::Uvarovna, titovna::Titovna, carpovna::Carpovna].

testSolution([N1::C1, N2::C2, N3::C3]) :-
    mix([olimpiada::O, matrena::M, evdokiya::E], [N1::C1, N2::C2, N3::C3]),
    O is M + E - 5,
    M is O + E - 9.

carpovna(11).

titovna(Cups) :- 
    between(1, inf, Cups),
    0 is Cups mod 3.

uvarovna(Cups, Titovna) :- % вприкуску, видимо меньше остальных выпила
     between(1, Titovna, Cups).

del(X, [X|T], T).
del(X, [Н|T], [Н|T1]) :- del(X, T, T1).

add(X, L1, L) :- del(X, L, L1).

mix([], []).
mix([X|L], P) :-
    mix(L, L1),
    add(X, L1, P).

writeAtom(A, Size) :- 
    atom_length(A, L),
    write(A),
    tab(Size - L).

writeLine(N::F::C) :- 
    writeAtom(N, 12),
    writeAtom(F, 11),
    write(C), nl,
    write('----------+----------+------'),
    nl.

start :-
    howMuch([N1::F1::C1, N2::F2::C2, N3::F3::C3]),
    writeLine('Name'::'Family'::'Cups'),
    writeLine(N1::F1::C1),
    writeLine(N2::F2::C2),
    writeLine(N3::F3::C3).