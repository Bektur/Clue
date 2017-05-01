
% It's doable to create an interface using prolog 
%Use swi-prolog manual
%This is just list manipulation
%We use interface to get input from 
%users. 
%6 people 
%6 weapons 
%9 rooms 

% maybe create dynamic varaibles for which cards does the character have
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

:- dynamic failedAccusation/3.
% An accusation is like a suggestion, but without a disprover
% All accusations inside the database are false.
% this is because true accusations end the game.

:- dynamic disprovedCards/2.
% disprovedCards(Character, card) if character is known to hold card
% in their hand.



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
	read(X),
        nl.



getSuggestion(Suggestion, Suggester, Disprover, Pc):-
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
	write("Who disproved the Suggestion, if no one disproves it, enter the name of the Suggester"),
	nl, 
	read(Disprover),
	character(Disprover), %replace with player(Disprover)
        assert(recordedSuggestion(Suggestion,Suggester,Disprover)),
        (Pc = Suggester, Suggester \= Disprover -> 
            write("What card did they show you?"),
            nl,
            read(X),
            nl,
            assert(disprovedCards(Disprover,X));
            true
        ).


%getAccusation.  Used when other players make an incorrect accusation
% we do not record correct accusations, as those end the game.
getAccusation():-
	write("Who made an incorrect accusation"),
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
	assert(failedAccusation(Accusation, Accuser)).

getHands(0,_).
getHands(NHands,Character):-
	write("Enter the name of one of the cards in your hand."),
	nl, 
	read(Hands),
        nl,
	assert(handSize(Character,Hands)),
	assert(disprovedCard(Character,Hands)),
	N1 is NHands - 1,
	getHands(N1,Character).


%starts the game
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
        nl,
    	assert(handSize(C1,H1)),
        %record the handsize of the player
	Characters = [C1|CT],
	Hands = [H1|HT],
	N1 is NPlayers - 1,
	playerInfo(N1,CT,HT),
        %record the handsizes of others
        getHands(H1,C1),!,
        %return to the menu screen
        menuScreen(C1).
        

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


%displays a menu screen.  the player selects an option from it.
menuScreen(C1):-
	write("Enter 1 to record a suggestion another player made"),
	nl,
	write("Enter 2 to record an accusation another player made"),
        nl,
        write("Enter 3 to display the history of suggestions"),
        nl,
        write("Enter 4 to display the history of incorrect accusations"),
        nl,
        write("Enter 5 to display advice on what accusation to make"),
        nl,
        write("Enter 6 for advice on a suggestion to make"),
        nl,
        write("Enter 7 if you would like to exit"),
        nl,
        read(S),
        (S = 1 -> getSuggestion(Suggestion,Suggester,Disprover,C1);
         S = 2 -> getAccusation;
         S = 3 -> displayHistory;
         S = 4 -> displayAccHist;
         S = 5 -> calculateAccusation;
         S = 6 -> calculateSuggestion;
         S = 7 -> halt;
         write("not a valid selection."),menuScreen(C1)
         ),
         menuScreen(C1).

calculateAccusation.
calculateSuggestion.


displayHistory :-
       recordedSuggestion(X,Y,Z),format('~w ~w ~w', [X, Y, Z]).
