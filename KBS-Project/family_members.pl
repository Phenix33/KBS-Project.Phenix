% === GENDER DECLARATIONS === (Modern Family Version)
% --- Women ---
woman(pamela).
woman(jackie).
woman(maggie).
woman(mary).
woman(susan).
woman(ann).
woman(lisa).
woman(karen).
woman(lucy).
woman(grace).

% --- Men ---
man(john).
man(jack).
man(bob).
man(kevin).
man(george).
man(paul).
man(frank).
man(david).
man(charles).

% === PARENT-CHILD RELATIONSHIPS ===
% John's children
parent(john, jack).
parent(john, bob).
parent(john, jackie).

% Bob's children
parent(bob, kevin).
parent(bob, pamela).

% Kevin's children
parent(kevin, maggie).

% George's children
parent(george, paul).
parent(george, lucy).

% Paul's children
parent(paul, grace).

% David's children
parent(david, frank).
parent(david, karen).

% Charles' children
parent(charles, david).

% === GRANDPARENTS (Explicit Facts) ===
% John is the grandfather of Kevin and Pamela
grandparent(john, kevin).
grandparent(john, pamela).

% Bob is the grandfather of Maggie
grandparent(bob, maggie).

% Charles is the grandfather of Frank and Karen
grandparent(charles, frank).
grandparent(charles, karen).

% === MARRIAGES ===
spouse(john, mary).
spouse(bob, ann).
spouse(kevin, lisa).
spouse(george, lucy).
spouse(frank, susan).

% === DIVORCED ===
divorced(john, susan).
divorced(david, grace).

% === SPECIAL TRAITS ===
trait(maggie, plays_air_guitar).
trait(maggie, loves_parties).
