% MODERN FAMILY ROLES AND RESPONSIBILITIES
% Load core data
:- [family_members].  % Gender and relationships
:- [family_timeline]. % Birth to death years
:- [clans].          % Clan affiliations

% === ROLE DEFINITIONS ===
% holds_role(Person, Role, StartYear, EndYear, HowAssigned)
% HowAssigned: inheritance, election, appointment, custom

% --- Family Leadership Roles ---
holds_role(charles, family_elder, 1980, 2005, election). % Deceased grandfather
holds_role(john, family_elder, 2005, 2020, inheritance). % Inherited from Charles
holds_role(bob, family_elder, 2020, alive, election).     % Current elder

% --- Clan-Based Roles (Kisii-inspired) ---
holds_role(george, clan_spokesperson, 2015, alive, appointment). % Represents Ababasi clan
holds_role(mary, family_mediator, 2010, alive, custom).          % Resolves disputes

% --- Modern Responsibilities ---
holds_role(jack, financial_manager, 2018, alive, appointment).   % Handles family funds
holds_role(ann, education_coordinator, 2015, alive, election).  % Oversees kids' schooling
holds_role(maggie, tech_support, 2022, alive, custom).           % Youngest but tech-savvy

% --- Special Assignments ---
holds_role(grace, family_historian, 2000, 2010, custom).         % Documented family tree
holds_role(karen, health_advocate, 2018, alive, appointment).   % Organizes medical care

% === ROLE QUERIES ===

% Who holds a role in a given year?
role_holder(Role, Person, Year) :-
    holds_role(Person, Role, Start, End, _),
    (End == alive -> Year >= Start ; Year >= Start, Year =< End).

% How someone obtained a role
role_assignment(Person, Role, Method) :-
    holds_role(Person, Role, _, _, Method).

% Current active roles
current_role(Person, Role) :-
    holds_role(Person, Role, _, alive, _).

% List all roles held by a person
all_roles(Person, Roles) :-
    findall(Role, holds_role(Person, Role, _, _, _), Roles).

% Clan-specific roles
clan_role_members(Clan, Role, Members) :-
    clan(Clan, ClanMembers),
    findall(Person, (member(Person, ClanMembers), current_role(Person, Role)), Members).

% === EXAMPLE QUERIES ===
% 1. Who is the current family elder?
% ?- role_holder(family_elder, X, 2023). → X = bob

% 2. What roles has Mary held?
% ?- all_roles(mary, R). → R = [family_mediator]

% 3. List all Ababasi clan members with official roles:
% ?- clan_role_members(ababasi, Role, Person).