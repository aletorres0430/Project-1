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

%setting text for starting page
Screen('TextSize', window, 50);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Wisconsin Card Sorting Task Variation' ,...
'center', screenYpixels * 0.5, [1 1 1]);

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Please read all instructions carefully' ,...
'center', screenYpixels * 0.6, [1 1 1]);

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Press any key to continue' ,...
'center', screenYpixels * 0.9, [1 1 1]);

Screen('Flip', window);
KbStrokeWait;

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

totalrounds = 0;
rulechanges = 0;
rule = randi(3);

while rulechanges < 5
    %chooses new rule: 1 is shape, 2 is color, 3 is number
    newrule = randi(3);

    %makes sure the new rule is not the same as the old one
    while newrule == rule
        newrule = randi(3);
    end
    rule = newrule;
    correctcounter = 0;

    while correctcounter < 6

        choose4random

        card1image=imread(card1);
        card2image=imread(card2);
        card3image=imread(card3);
        card4image=imread(card4);

        % make a texture for each picture
        T1 = Screen('MakeTexture', window, card1image);
        T2 = Screen('MakeTexture', window, card2image);
        T3 = Screen('MakeTexture', window, card3image);
        T4 = Screen('MakeTexture', window, card4image);
        T = [T1 T2 T3 T4]; %make an vector of texture pointers

        % make a rect for each
        rect1 = CenterRectOnPointd([0 0 200 200], xCenter-(xCenter/2), yCenter/2)';
        rect2 = CenterRectOnPointd([0 0 200 200], xCenter-(xCenter/6), yCenter/2)';
        rect3 = CenterRectOnPointd([0 0 200 200], xCenter+(xCenter/6), yCenter/2)';
        rect4 = CenterRectOnPointd([0 0 200 200], xCenter+(xCenter/2), yCenter/2)';
        rects = [rect1 rect2 rect3 rect4]; %row for each rect

        Screen('DrawTextures', window, T,[],rects);

        Screen('TextSize', window, 40);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, '1' , screenXpixels*.245, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '2' , screenXpixels*.41, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '3' , screenXpixels*.58, screenYpixels*.4, [1 1 1]);
        DrawFormattedText(window, '4' , screenXpixels*.745, screenYpixels*.4, [1 1 1]);

        %same process for bottom card
        card5image=imread(card5);
        T5= Screen('MakeTexture', window, card5image);
        rect5= CenterRectOnPointd([0 0 200 200], xCenter, yCenter/.75)';
        Screen('DrawTexture', window,T5,[],rect5);

        Screen('Flip', window)
        RestrictKeysForKbCheck([KbName('1!') KbName('2@') KbName('3#') KbName('4$')]);
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
                correctcounter = 0;
        end
        totalrounds = totalrounds + 1;
    end
    rulechanges = rulechanges + 1;
end
sca;