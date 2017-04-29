/* 
	It's doable to create an interface using prolog 
	Use swi-prolog manual
	This is just list manipulation
	We use interface to get input from 
	users. 
	6 people 
	6 weapons 
	9 rooms 
*/

getWeapons(Weapons):-
	Weapons = [Knife', 'Candlestick', 'Revolver', 'Rope', 'Lead Pipe', 'Wrench'].

getSuspects(Suspects):-
	Suspects = ['Mrs Scarlet', 'Colonel Mustard', 'Mrs White', 'Mr Green', 'Mrs Peacock', 'Professor Plum'].

getRoom(Rooms):-
	Rooms = ['Ballroom', 'Conservatory', 'Billiard Room', 'Library', 'Study', 'Hall', 'Lounge', 'Dining Room', 'Kitchen'].