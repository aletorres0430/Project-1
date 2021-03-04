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

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it black
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

line1 = 'Welcome To the Wisconsin Card Sorting Task Variation';
line2 = '\n\n Josh Assi & Alejandro Torres';
line3 = '\n\n Please read all the following directions and instructions';

% Draw all the text in one go
Screen('TextSize', window, 40);
DrawFormattedText(window, [line1 line2 line3],...
    'center', screenYpixels * 0.25, white);

% Flip to the screen
Screen('Flip', window);

%Press any key to terminate
KbStrokeWait;

% Clear the screen
sca;