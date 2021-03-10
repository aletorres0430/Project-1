# Project-1
Wisconsin-sorting task variation
Joshua Assi and Alejandro Torres

Card_Task.m runs our project as a whole (the wisconsin card sorting task with random distractions) and houses the code used spefically for the cards display
distraction.m houses the code for the distractions that randomly pop up throughout. It is called in Card_Task.m when needed
choose4random.m houses the code that chooses the cards that are randomly displayed, all following the parameters we set. It is called in Card_Task.m when needed
tester.m is just a script we used to test bits of code, and does not need to be looked at.

The program will change the sorting rule when the subject makes 5 correct matches in a row. The program ends after 5 rule changes.

This program is meant to measure how distractions affect a subject's working memory. Some data is stored in certain variables when the program ends:
totalrounds = the number of rounds it took to complete 5 rule changes
distractioncounter = the number of distractions that popped up
distractionrounds = a vector storing the numbers of rounds before which a distraction popped up
incorrectrounds = a vector storing the numbers of rounds which the subject made a wrong match

These data might be useful to analyze how the distractions affected the subject's performance on the test.
The video shows a few rounds, between which a few distractions pop up and a rule change happens.
The colors and images are a bit distorted to reduce the file size.

![](WCSTvideo.gif)
