
% It's doable to create an interface using prolog 
%Use swi-prolog manual
%This is just list manipulation
%We use interface to get input from 
%users. 
%6 people 
%6 weapons 
%9 rooms 


% List of all possible characters
character(mustard).
character(scarlett).
character(green).
character(white).
character(plum).
character(peacock).

% List of all possible weapons
weapon(knife).
weapon(candlestick).
weapon(rope).
weapon(revolver).
weapon(wrench).
weapon(pipe).

% List of all possible rooms
room(kitchen).
room(ballroom).
room(conservatory).
room(diningroom).
room(billiard).
room(library).
room(lounge).
room(hall).
room(study).


getUserInput(X):-
	write('Choose a player'),
	nl, 
	read(X),
	getSuspects(X).

getWhoSuggest(X):-
	write("Who made the Accusation"),
	nl,
	read(X).


getAccusation(Accusation,Accuser,Disprover):-
	getWhoSuggest(Accuser),
	character(Accuser),	
	write("Enter a suggession in the format Weapon, suspect, room: "),
	nl, 
	write("What was the weapon"),
	nl,
	read(Weapon),
	weapon(Weapon),
	write("Who was the suspect"),
	nl,
	read(Suspect),
	character(Suspect),
	write("What was the room"),
	nl,
	read(Room),
	room(Room),
	Accusation = [Weapon,Suspect,Room],
	write("Who disproved the Accusation, if no one disproves it, enter the name of the Accuser"),
	nl, 
	read(Disprover),
	character(Disprover).

getAccusation(Accusation,Accuser):-
	write("Who made an incorrect accussation"),
	nl,
	read(Accuser),
	character(Accuser),	
	write("Enter the incorrect accusation in the format weapon, suspect, room: "),
	nl, 
	write("What was the weapon"),
	nl,
	read(Weapon),
	weapon(Weapon),
	write("Who was the suspect"),
	nl,
	read(Suspect),
	character(Suspect),
	write("What was the room"),
	nl,
	read(Room),
	room(Room),
	Accusation = [Weapon,Suspect,Room].

initGame(Characters,Hands):-
	write("Enter the number of players"),
	nl,
	read(NPlayers),
	member(NPlayers, [3,4,5,6]),
	write("Who is your character"),
	nl,
	read(C1),
	character(C1),
	write("How many cards are in your hand?"),
	nl, 
	read(H1),
	Characters = [C1|CT],
	Hands = [H1|HT],
	N1 is NPlayers - 1,
	playerInfo(N1,CT,HT).

% NH is head for hand size list
playerInfo(0,[],[]).
playerInfo(NPlayers,[CH|CT],[NH|NT]):-
	write("Who is the next player to the left"),
	nl, 
	read(CH),
	character(CH),
	%\+member(CH,CT),
	write("How many cards does the player have in their hand?"),
	nl,
	read(NH),
	N1 is NPlayers - 1,
	playerInfo(N1,CT,NT).
	


menuScreen(X):-
	write("Press 1 to record a Accusation"),
	nl,
	write("Press 2 to record an accusation").

