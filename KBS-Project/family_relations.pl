% MODERN FAMILY RELATIONSHIPS
% Load core data
:- [family_members].  % Gender and basic facts
:- [clans].          % Clan affiliations (optional)

% === SPOUSAL RELATIONS ===

% Current marriages (from your original KB)
married(john, mary).
married(bob, ann).
married(kevin, lisa).
married(george, lucy).
married(frank, susan).

% Divorces (from your original KB)
divorced(john, susan).
divorced(david, grace).

% Symmetric marriage predicate
spouse(X, Y) :- married(X, Y) ; married(Y, X).

% Gender-specific predicates
husband(H, W) :- married(H, W), man(H).
wife(W, H) :- married(W, H), woman(W).

% === NUCLEAR FAMILY RELATIONS ===

% Parent-child relationships (expanded for clarity)
children_of(john, mary, [jack, bob, jackie]).
children_of(bob, ann, [kevin, pamela]).
children_of(kevin, lisa, [maggie]).
children_of(george, lucy, [paul, lucy]).
children_of(paul, _, [grace]).          % Grace's mother not specified
children_of(david, _, [frank, karen]).  % Karen's mother not specified
children_of(charles, _, [david]).       % Charles is David's father

% Parent rules (consistent with your original KB)
parent(X, Y) :- father(X, Y) ; mother(X, Y).
father(F, C) :- man(F), (son(C, F) ; daughter(C, F)).
mother(M, C) :- woman(M), (son(C, M) ; daughter(C, M)).

% Ancestry
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% === EXTENDED FAMILY (Kisii-inspired) ===

% Siblings (full siblings)
siblings(X, Y) :-
    father(F, X), father(F, Y),
    mother(M, X), mother(M, Y),
    X \= Y.

% Half-siblings (shared father only - common in Gusii polygamous traditions)
half_siblings(X, Y) :-
    father(F, X), father(F, Y),
    (mother(M1, X), mother(M2, Y), M1 \= M2),
    X \= Y.

% Clan-based relations (Kisii cultural twist)
clan_brother(X, Y) :-
    clan(Clan, Members),
    member(X, Members),
    member(Y, Members),
    man(X), man(Y),
    X \= Y.

% === GENERATION-BASED PREDICATES ===

% Grandparents (explicit)
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% Gusii-style "abagusia" (family elders)
elder(X) :-
    grandparent(X, _),
    \+ divorced(X, _).  % Elders typically maintain family unity

% === IN-LAWS AND MODERN RELATIONS ===

% Father-in-law
father_in_law(FIL, Person) :-
    married(Person, Spouse),
    father(FIL, Spouse).

% Step-parents (from divorce)
step_parent(Step, Child) :-
    divorced(Step, Ex),
    parent(Ex, Child).

% === QUERY HELPERS ===

% List all family units
family_units :-
    findall(Parents-Children, 
            (children_of(F, M, Children), Parents = [F, M]), 
            Units),
    forall(member(Unit, Units), 
           (write(Unit), nl)).

% Who married into which clan? (Cultural extension)
clan_marriages :-
    clan(Clan, Members),
    findall(Spouse, 
            (member(Person, Members), 
            spouse(Person, Spouse), 
            Spouses),
    write(Clan), write(': '), write(Spouses), nl.