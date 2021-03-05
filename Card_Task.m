%Josh Assi & Alejandro Torres
% Wisconsin Card Sorting Task Variation

% Clear the workspace and the screen
close all;
clearvars;
sca

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
DrawFormattedText(window, 'Color, Type of Shape, Number of Shapes' ,...
'center', screenYpixels * 0.6, [1 1 1]);

Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Press any key to continue' ,...
'center', screenYpixels * 0.9, [1 1 1]);

Screen('Flip', window);
KbStrokeWait;

sca;