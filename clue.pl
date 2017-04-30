
% It's doable to create an interface using prolog 
%Use swi-prolog manual
%This is just list manipulation
%We use interface to get input from 
%users. 
%6 people 
%6 weapons 
%9 rooms 

:- dynamic handSize/2.
% handSize(C,H) if character has H cards in hand.

:- dynamic playerCharacter/1.
% This character has the distinction of being controlled by the player.
% They get to know the specific card which refutes their suggestion.


:- dynamic recordedSuggestion/3.
% A suggestion is ([Weapon,Suspect, Room], Suggester, Disprover)
% the suggestion is a weapon suspect and Room
% the suggester is the player that makes the suggestion
% the disprover is the player that shows the suggester a card to disprove it
% if the suggestion goes all the way around the table,
% the Suggester and the Disprover are the same character

:- dynamic recordedAccusation/3.
% An accusation is like a suggestion, but without a disprover
% All accusations inside the database are false.
% this is because true accusations end the game.

:- dynamic disprovedCards/2.



% List of all possible characters
character(mustard).
character(scarlett).
character(green).
character(white).
character(plum).
character(peacock).

character(1).
character(2).
character(3).
character(4).
character(5).
character(6).

% List of all possible weapons
weapon(knife).
weapon(candlestick).
weapon(rope).
weapon(revolver).
weapon(wrench).
weapon(pipe).

weapon(7).
weapon(8).
weapon(9).
weapon(10).
weapon(11).
weapon(12).

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

room(13).
room(14).
room(15).
room(16).
room(17).
room(18).
room(19).
room(20).
room(21).

getWhoSuggest(X):-
	write("Who made the Suggestion"),
	nl,
	read(X).



getSuggestion(Suggestion,Suggester,Disprover):-
	getWhoSuggest(Suggester),
	character(Suggester),
        write("Enter a suggession in the order weapon, suspect, room: "),
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
	Suggestion = [Weapon,Suspect,Room],
	write("Who disproved the Accusation, if no one disproves it, enter the name of the Accuser"),
	nl, 
	read(Disprover),
	character(Disprover), %replace with player(Disprover)
        assert(recordedSuggestion(Suggestion,Suggester,Disprover)).

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
	Accusation = [Weapon,Suspect,Room],
        assert(recordedAccusation(Accusation, Accuser)).

initGame(Characters,Hands):-
	write("Enter the number of players"),
	nl,
	read(NPlayers),
	member(NPlayers, [3,4,5,6]),
	write("Who is your character"),
	nl,
	read(C1),
	character(C1),
        assert(playerCharacter(C1)),
	write("How many cards are in your hand?"),
	nl, 
	read(H1),
        assert(handSize(C1,H1)),
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
        assert(handSize(CH,NH)),
	N1 is NPlayers - 1,
	playerInfo(N1,CT,NT).

menuScreen(X):-
	write("Press 1 to record a Accusation"),
	nl,
	write("Press 2 to record an accusation").

displayHistory :-
       recordedSuggestion(X,Y,Z),format('~w ~w ~w', [X, Y, Z]),
       failedAccusation(V,W),format('~w ~w',[V,W]).

