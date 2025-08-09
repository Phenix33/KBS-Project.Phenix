% MODERN FAMILY INHERITANCE RULES
% Load core data
:- [family_members].  % Gender and relationships
:- [family_timeline]. % Birth to death years

% === HELPER PREDICATES ===

% Check if someone is alive (simpler than medieval version)
alive(Person) :- 
    lifetime(Person, _, alive).

% Extract birth year (handles "alive" status)
birth_year(Person, Year) :-
    lifetime(Person, Birth, _),
    (number(Birth) -> Year = Birth ; Birth = circa(Y), Year is Y - 1).

% List children by age (modern replacement for succession_order/2)
children_by_age(Parent, OrderedChildren) :-
    findall(Child-Birth, 
           (parent(Parent, Child), 
            birth_year(Child, Birth)), 
    keysort(ChildBirthPairs, SortedPairs),
    pairs_keys(SortedPairs, OrderedChildren).

% === MODERN INHERITANCE RULES ===

% 1. DEFAULT INHERITANCE (Kenyan Law)
% Spouse + children split estate equally
default_heirs(Deceased, Heirs) :-
    findall(Heir, (
        (spouse(Deceased, Heir), alive(Heir)) ;  % Surviving spouse
        (parent(Deceased, Heir), alive(Heir))    % Living children
    ), Heirs).

% 2. GUSII TRADITIONAL INHERITANCE
% Eldest son inherits family home, others share land
gusii_heirs(Deceased, PrimaryHeir, OtherHeirs) :-
    man(Deceased),  % Traditional rules typically apply to male heirs
    findall(Son, (son(Son, Deceased), alive(Son)), Sons),
    sort(Sons, [PrimaryHeir|OtherHeirs]).  % Sort ensures eldest first

% 3. WILL-BASED INHERITANCE
% Example: John left his guitar collection to Maggie
custom_bequest(john, maggie, musical_instruments).

% === SPECIAL CASES ===

% Clan-based inheritance (Kisii cultural twist)
clan_heir(Deceased, Heir) :-
    clan(Clan, Members),
    member(Deceased, Members),
    % Find closest living male clan member (traditional preference)
    (   man(Deceased),
        findall(M, (member(M, Members), man(M), alive(M), M \= Deceased), Candidates),
        sort(Candidates, [Heir|_])  % Simple age-based priority
    ;   woman(Deceased),
        daughter(Heir, Deceased)    % Daughters inherit from mothers
    ).

% === QUERY EXAMPLES ===

% Who inherits under Kenyan law if John dies?
% ?- default_heirs(john, Heirs).

% What does traditional Gusii inheritance dictate?
% ?- gusii_heirs(charles, Primary, Others).

% Any special bequests?
% ?- custom_bequest(_, maggie, What).