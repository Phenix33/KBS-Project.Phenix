% MODERN FAMILY CLANS (Kisii-inspired)
% clans.pl - Complete clan definitions with demo queries
:- [family_members].

% ========== CLAN MEMBERSHIPS ==========
% Format: clan(ClanName, [member1, member2,...])

% Abagirango (Leaders)
clan(abagirango, [
    john,    % Family patriarch
    mary,    % Matriarch
    jack,    % Eldest son
    bob,     % Middle child
    ann,     % Bob's wife
    kevin    % Grandson
]).

% Ababasi (Artists)
clan(ababasi, [
    maggie,  % Air guitar player
    george,  % Musician
    lucy,    % George's wife
    paul,    % Artist
    grace    % Youngest granddaughter
]).

% Abamachoge (Farmers)
clan(abamachoge, [
    david,   % Agriculturalist
    susan,   % David's ex-wife
    frank,   % Farmer
    karen,   % Agricultural expert
    charles  % Family elder (deceased)
]).

% Abanyaribari (teachers)
clan(abanyaribari, [
    pamela,  % Teacher
    jackie   % Professor
]).

% ========== CLAN TRAITS ==========
clan_trait(abagirango, leadership).
clan_trait(ababasi, artistic).
clan_trait(abamachoge, agricultural).
clan_trait(abanyaribari, academic).

% ========== QUERY SYSTEM ==========
% How to use: ?- demo_clans. or ?- clan_info(maggie).

% Main demo predicate
demo_clans :-
    nl, write('=== FAMILY CLAN SYSTEM ==='), nl, nl,
    write('1. All Clan Members:'), nl,
    forall(clan(Clan, Members), (
        write('  '), write(Clan), write(': '), 
        write(Members), nl
    )),
    nl,
    write('2. Clan Traits:'), nl,
    list_clan_traits,
    nl,
    write('3. Example Individual Query:'), nl,
    write('   '), clan_info(maggie).

% Get info about a specific member
clan_info(Person) :-
    (   clan(Clan, Members), member(Person, Members)
    ->  write(Person), write(' belongs to '), write(Clan), 
        write(' (Trait: '), clan_trait(Clan, Trait), 
        write(Trait), write(')'), nl
    ;   write(Person), write(' not found in any clan'), nl
    ).

% List all clan traits
list_clan_traits :-
    forall(
        clan_trait(Clan, Trait),
        (write('  '), write(Clan), write(': '), write(Trait), nl)
    ).

% Helper: Check clan membership
clan_member(Person, Clan) :-
    clan(Clan, Members),
    member(Person, Members).