% MODERN FAMILY TIMELINE
% Birth and death years for family members (20th-21st century)

% === GENERATION 1 (Eldest) ===
lifetime(charles, 1925, 2005).  % Grandfather (assumed deceased)
lifetime(grace, 1930, 2010).    % Grandmother (divorced from David)

% === GENERATION 2 (Middle) ===
% John's branch
lifetime(john, 1950, 2020).     % Died recently
lifetime(mary, 1955, alive).     % Still alive
lifetime(susan, 1952, alive).    % John's ex-wife

% Bob's branch
lifetime(bob, 1958, alive).
lifetime(ann, 1960, alive).

% George's branch
lifetime(george, 1965, alive).
lifetime(lucy, 1968, alive).

% David's branch (divorced from Grace)
lifetime(david, 1955, 2022).    % Deceased
lifetime(karen, 1960, alive).    % David's daughter

% === GENERATION 3 (Younger) ===
% John and Mary's children
lifetime(jack, 1980, alive).
lifetime(bob, 1982, alive).      % Same name as his uncle
lifetime(jackie, 1985, alive).

% Bob and Ann's children
lifetime(kevin, 1990, alive).
lifetime(pamela, 1992, alive).

% Kevin and Lisa's child
lifetime(maggie, 2015, alive).   % Youngest, plays air guitar

% George and Lucy's children
lifetime(paul, 1995, alive).
lifetime(grace, 1998, alive).    % Named after grandmother

% Frank (David's son)
lifetime(frank, 1990, alive).

% === SPECIAL CASES ===
% Unknown birth years (use circa/1)
lifetime(sprota, circa(1935), unknown).  % Example placeholder

% === HELPER PREDICATES ===
% Check if someone is alive
alive(Person) :- 
    lifetime(Person, _, alive).

% Calculate approximate age
age(Person, Age) :-
    lifetime(Person, Birth, Death),
    (Death == alive ->
        get_time(Now),
        stamp_date_time(Now, date(CurrentYear, _, _, _, _, _, _, _, _), 
        Age is CurrentYear - Birth
    ; 
        Age is Death - Birth
    ).

% List living family members
living_members(Living) :-
    findall(Person, alive(Person), Living).

% === EXAMPLE QUERIES ===
% ?- age(maggie, X).       % Maggie's age (e.g., 8 in 2023)
% ?- living_members(X).     % All alive family members
% ?- lifetime(john, B, D).  % John lived 1950–2020