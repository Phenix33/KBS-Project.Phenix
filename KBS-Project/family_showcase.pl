% MODERN FAMILY KNOWLEDGE BASE SHOWCASE
% Load all components
:- [family_members].    % Replaces characters.pl
:- [clans].            % Replaces dynasties.pl
:- [relations].        % Existing family rules (father or mother orsibling etc.)
:- [roles].           % Custom roles

% === DEMONSTRATION QUERIES ===

demo :-
    nl, write('=== MODERN FAMILY KNOWLEDGE BASE DEMO ==='), nl, nl,
    
    % 1. Basic Genealogy
    write('1. BASIC FAMILY RELATIONS'), nl,
    write('Who are John and Mary\'s children?'), nl,
    findall(Child, (parent(john, Child), parent(mary, Child)), Children),
    write('Answer: '), write(Children), nl, nl,
    
    % 2. Clan Membership
    write('2. CLAN ANALYSIS (Kisii-inspired)'), nl,
    write('Which clan does Maggie belong to?'), nl,
    (clan(Clan, Members), member(maggie, Members) ->
        write('Answer: '), write(Clan) ;
        write('Answer: No clan assigned')),
    nl, nl,
    
    % 3. Special Traits
    write('3. UNIQUE TRAITS'), nl,
    write('Who plays air guitar in the family?'), nl,
    findall(Person, trait(Person, plays_air_guitar), Musicians),
    write('Answer: '), write(Musicians), nl, nl,
    
    % 4. Grandparent Lineage
    write('4. GRANDPARENT CONNECTIONS'), nl,
    write('Who are Frank\'s grandparents?'), nl,
    findall(GP, grandparent(GP, frank), Grandparents),
    write('Answer: '), write(Grandparents), nl, nl,
    
    % 5. Marriage Status
    write('5. MARRIAGE STATUS'), nl,
    write('Is John currently married?'), nl,
    (spouse(john, X), \+ divorced(john, X) ->
        write('Answer: Yes, to '), write(X) ;
        write('Answer: No')),
    nl, nl,
    
    write('=== END DEMO ==='), nl.

% === INTERESTING FAMILY QUERIES ===

% Find all married couples with children
family_units(Units) :-
    findall(Couple-Children, 
           (spouse(X, Y), Couple = [X, Y], 
            findall(Child, (parent(X, Child), parent(Y, Child)), Children)),
           Units).

% Who shares a clan with Maggie?
clan_siblings(Person, ClanMembers) :-
    clan(Clan, Members),
    member(Person, Members),
    findall(M, (member(M, Members), M \= Person), ClanMembers).

% List all divorced couples with children
broken_homes(Broken) :-
    findall([Ex1, Ex2]-Children,
            (divorced(Ex1, Ex2),
             findall(Child, (parent(Ex1, Child), parent(Ex2, Child)), Children)),
            Broken).

% === CULTURAL TWISTS (Kisii-inspired) ===

% Hypothetical: Assign "family roles" based on Gusii traditions
% Elders (Abagirango) -> Decision-makers
% Artisans (Ababasi) -> Musicians/Creatives
% Farmers (Abamachoge) -> Breadwinners
role_analysis :-
    write('FAMILY ROLES BY CLAN:'), nl,
    write('---------------------'), nl,
    forall(clan(Clan, _),
           (clan_trait(Clan, Trait),
            write(Clan), write(': '), write(Trait), nl)).

% === FULL SHOWCASE ===

showcase :-
    write('MODERN FAMILY KNOWLEDGE BASE - FULL SHOWCASE'), nl,
    write('========================================='), nl, nl,
    
    demo, nl,
    
    write('ADVANCED ANALYSIS:'), nl,
    write('------------------'), nl,
    
    % Family units
    family_units(Units),
    write('Nuclear Families: '), nl,
    forall(member(Couple-Children, Units),
           (write(' - '), write(Couple), write(' -> '), write(Children), nl)),
    nl,
    
    % Clan connections
    write('Clan Relationships:'), nl,
    (clan_siblings(maggie, Siblings) ->
        write('Maggie\'s clan mates: '), write(Siblings) ;
        write('No clan mates found')),
    nl, nl,
    
    % Cultural roles
    role_analysis, nl,
    
    write('Database tracks genealogy, relationships, and cultural roles.'), nl.

% === SAMPLE QUERIES FOR USERS ===

sample_queries :-
    write('TRY THESE SAMPLE QUERIES:'), nl,
    write('========================'), nl,
    write('?- parent(john, X).                % List John\'s children'), nl,
    write('?- grandparent(charles, X).        % Find Charles\' grandchildren'), nl,
    write('?- clan(ababasi, X).               % List Ababasi clan members'), nl,
    write('?- trait(maggie, X).               % Check Maggie\'s traits'), nl,
    write('?- spouse(X, Y), \+ divorced(X, Y). % Find currently married couples'), nl,
    write('?- clan_siblings(grace, X).        % Find Grace\'s clan mates'), nl, nl.

% === GLOSSARY ===

glossary :-
    nl, write('=== KNOWLEDGE BASE GLOSSARY ==='), nl, nl,
    
    write('CORE PREDICATES:'), nl,
    write('----------------'), nl,
    write('man(X) / woman(X)          - Gender declarations'), nl,
    write('parent(X, Y)               - Direct parent-child relationship'), nl,
    write('grandparent(X, Y)          - Grandparent connection'), nl,
    write('spouse(X, Y)               - Marriage relationship'), nl,
    write('divorced(X, Y)             - Divorced couples'), nl,
    write('trait(X, Y)                - Personal traits (e.g., plays_air_guitar)'), nl, nl,
    
    write('CLAN PREDICATES (Kisii-inspired):'), nl,
    write('--------------------------------'), nl,
    write('clan(Name, Members)        - Lists all clan members'), nl,
    write('clan_trait(Name, Trait)    - Cultural role of the clan'), nl,
    write('clan_siblings(Person, X)   - Find who shares a clan with Person'), nl, nl,
    
    write('DEMO PREDICATES:'), nl,
    write('---------------'), nl,
    write('demo            - Run basic demonstration'), nl,
    write('showcase        - Full system showcase'), nl,
    write('sample_queries  - Suggested queries to try'), nl,
    write('glossary        - This help menu'), nl, nl,
    
    write('=== END GLOSSARY ==='), nl.