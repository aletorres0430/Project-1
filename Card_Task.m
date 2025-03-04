%Josh Assi & Alejandro Torres
% Wisconsin Card Sorting Task Variation


% Clear the workspace and the screen
close all;
clearvars;
sca

RestrictKeysForKbCheck([]);

%most of the basics are from demos
%Says to use this so we don't get a screen error
Screen('Preference', 'SkipSyncTests', 1);

% Call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

% Define white, black, and grey using the luminance values for the display.
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

%Alejandro set the text for this starting portion
%took about an hour getting text to go on the correct spot
%setting text for starting page
%Josh proofed 15 minutes
Screen('TextSize', window, 50);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Wisconsin Card Sorting Task Variation' ,...
'center', screenYpixels * 0.4, [1 1 1]);

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Please read all instructions carefully' ,...
'center', screenYpixels * 0.5, [1 1 1]);

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Images credited to Professor Gijsbert Stoet \n and PsyToolkit main website ' ,...
'center', screenYpixels * 0.7, [1 1 1]);

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Press any key to continue' ,...
'center', screenYpixels * 0.9, [1 1 1]);

Screen('Flip', window);
KbStrokeWait;

%next set of instructions
Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Match the bottom card to one of the cards \n above based on the following rules:' ,...
'center', screenYpixels * 0.3, [1 1 1]);

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Color, Type of Shape, or Number of Shapes' ,...
'center', screenYpixels * 0.6, [1 1 1]);

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Press any key to continue' ,...
'center', screenYpixels * 0.9, [1 1 1]);

Screen('Flip', window);
KbStrokeWait;

%initialize variables
%counts how many rounds of card task played over entire time
totalrounds = 0;

%counts everytime a rule change in the task occurs
%everytime this goes up it means a rule was completed
rulechanges = 0;

rule = randi(3);

%counts the number of distraction tasks that appear over entire time
distractioncounter = 0;

%This stores the round numbers in which the subject made the
%wrong choice
incorrectrounds = [];
%This stores the round numbers before which a distraction popped up
distractionrounds = [];

%task continues until a participant has completed the card task over 
%five different rules
while rulechanges < 5
    %chooses new rule: 1 is shape, 2 is color, 3 is number
    newrule = randi(3);

    %makes sure the new rule is not the same as the old one
    while newrule == rule
        newrule = randi(3);
    end
    
    %sets the current rule to the new rule that was just randomly chosen
    rule = newrule;
    
    %sets the number of correct rounds to zero
    correctcounter = 0;

    %chance for a distraction task to occur only if in the middle of a rule
    %distraction will not appear if a rule was just finished
    while correctcounter < 6
        if totalrounds > 0 
            %creats a random number between 1 and 5
            %if that number is 1 then distraction task appears, distraction
            %should appear about every 1 out of 5 rounds
            if randi(5) == 1
                distraction
                distractioncounter = distractioncounter + 1;
                distractionrounds = [distractionrounds (totalrounds + 1)];
            end
        end

        choose4random

        %read in the random cards chosen in choose4random script 
        card1image=imread(card1);
        card2image=imread(card2);
        card3image=imread(card3);
        card4image=imread(card4);

        %Alejandro wrote the code for displaying images
        %this took about three hours finding images learning how
        %to display multiple images by creating textures and rects
        %Josh debugged for 40 minutes and added the random images variable
        % make a texture for each picture
        T1 = Screen('MakeTexture', window, card1image);
        T2 = Screen('MakeTexture', window, card2image);
        T3 = Screen('MakeTexture', window, card3image);
        T4 = Screen('MakeTexture', window, card4image);
        T = [T1 T2 T3 T4]; %make an vector of texture pointers

        %make a rect for each
        %sets the size of the image and placement on screen
        rect1 = CenterRectOnPointd([0 0 200 200], xCenter-(xCenter/2), yCenter/2)';
        rect2 = CenterRectOnPointd([0 0 200 200], xCenter-(xCenter/6), yCenter/2)';
        rect3 = CenterRectOnPointd([0 0 200 200], xCenter+(xCenter/6), yCenter/2)';
        rect4 = CenterRectOnPointd([0 0 200 200], xCenter+(xCenter/2), yCenter/2)';
        rects = [rect1 rect2 rect3 rect4]; %row for each rect

        %displays images on screen
        Screen('DrawTextures', window, T,[],rects);

        %places numbers under each image so participant knows which number
        %corresponds to each image
        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, '1' , screenXpixels*.245, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '2' , screenXpixels*.41, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '3' , screenXpixels*.58, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '4' , screenXpixels*.745, screenYpixels*.4, [1 1 1]);

        %same image process for bottom card
        card5image=imread(card5);
        T5= Screen('MakeTexture', window, card5image);
        rect5= CenterRectOnPointd([0 0 200 200], xCenter, yCenter/.75)';
        Screen('DrawTexture', window,T5,[],rect5);

        Screen('Flip', window)
        
        %when in card task restricts keys to only 1-4 keys to select card
        %and escape key to leave task entirely
        RestrictKeysForKbCheck([KbName('1!') KbName('2@') KbName('3#') KbName('4$') KbName('ESCAPE')]);
        [secs, keyCode] = KbStrokeWait;

        keyPressed = find(keyCode) - 29;

        if keyPressed == correctcardnumber
            %they made the right match, display "Correct" and increment the counter
             %display 'Correct'
                Screen('TextSize', window, 60);
                Screen('TextFont', window, 'Courier');
                DrawFormattedText(window, 'Correct' ,...
                'center', screenYpixels * 0.5, [0 1 0]);
                Screen('Flip', window);
                pause(1);
                correctcounter = correctcounter + 1;
        elseif find(keyCode) == 41 %escape was pressed
            sca
        else
            %they made a mistake, display "Incorrect" and reset counter to 0
            %display 'Incorrect'
                Screen('TextSize', window, 60);
                Screen('TextFont', window, 'Courier');
                DrawFormattedText(window, 'Incorrect' ,...
                'center', screenYpixels * 0.5, [1 0 0]);
                Screen('Flip', window);
                pause(1);
                %if selection in a round is incorrect then correct counter
                %returns to zero
                %participant must correctly select a card 5 times in a row
                %for the loop to end and rule change to occur
                correctcounter = 0;
                incorrectrounds = [incorrectrounds (totalrounds + 1)];
        end
        totalrounds = totalrounds + 1;
    end
    rulechanges = rulechanges + 1;
end
sca;