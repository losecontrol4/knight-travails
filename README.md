# knight-travails

The purpose of this program is to calculate the shortest possible path for the chess piece, knight, to get from one spot to another spot on the board.

To accomplish this, I did a breadth first search through every possible move.

## In the breath first search I:

Ignored moves that would take me to square I've already been to using a set
Ignored moves that are out of bounds of an 8 by 8 chess board.

### Keep track of paths by:

Creating a reverse tree like graph where each move points to it's parent move.
This graph was implemented with a hash, therefore navigation up the hash is O(n) with n being how many moves needed in the shortest path

## final thoughs

Since this is a search of all possible moves, ending once I found a solution via breath search, worst case will have to go through n^8 possibilities where n is how many moves needed to get to the end square. Therefore to obtain the graph needed to get the answer, worst case is n^8 without any tricks. Simply ignoring moves that I already did changes the worse case to n^7. For average case, you can make that quite a bit better. I already did simple things like ignoring moves that go out of bounds, but if you were to study which moves you know wouldn't help you, you could elimate those too. This would take a bit of time studying the patterns of the knight to devise a clever algorithm, but would significantly improve the average case. Best case is O(1), where the start point was the same as the end point.

## how to use

everything is done by calling the knight_travails function.

It takes three inputs: start, end_goal, and algebraic_notation
here are some example calls:

knight_travails('a6', 'f2', true) --> ["a6", "b4", "c2", "e3", "f1"]

knight_travails('06', '52', false) --> [[0, 5], [1, 3], [2, 1], [4, 2], [5, 0]]

knight_travails([0, 6], [5, 2], false) --> [[0, 5], [1, 3], [2, 1], [4, 2], [5, 0]]

note these are all doing the same problem. Without algebraic notation, the range is [0..7][0..7]
algebraic notation just refers to the coordinate system used in chess. (a..g)(1..8)
