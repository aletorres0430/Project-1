%Distraction Script

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the center coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%Distraction Opening Screen
%first text block, instructions for distraction
Screen('TextSize', window, 50);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Use left or right arrow key to \n input which direction the dots are moving' ,...
'center', screenYpixels * 0.5, [1 1 1]);

%second text block, press any key
Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Press any key to continue' ,...
'center', screenYpixels * 0.9, [1 1 1]);
    
Screen('Flip', window);
RestrictKeysForKbCheck([]);
KbStrokeWait;

%distraction starts, continues until they get the direction correct
correct = 0;
while ~correct
    %Lines 36-76 sourced from http://peterscarfe.com/ptbtutorials.html,
    %edited by Josh (tailoring the setup to our project) with Alejandro
    %observing for 2 hours
    
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);

    % Use the meshgrid command to create our base dot coordinates
    dim = 5;
    [x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

    % Scale this by the distance in pixels we want between each dot
    pixelScale = screenYpixels / (dim * 4 + 2);
    x = x .* pixelScale;
    y = y.* pixelScale;

    % Calculate the number of dots
    numDots = numel(x);

    % Make the matrix of positions for the dots into two vectors
    xPosVector = reshape(x, 1, numDots);
    yPosVector = reshape(y, 1, numDots);

    % We can define a center for the dot coordinates to be relaitive to. Here
    % we set the centre to be the centre of the screen
    dotCenter = [screenXpixels / 2 screenYpixels / 2];

    % Set the color of our dot to be random
    dotColors = rand(3, numDots);

    % Set the size of the dots randomly between 10 and 30 pixels
    dotSizes = rand(1, numDots) .* 20 + 10;

    % Initializes the time 0
    time = 0;
    %We found the optimal speed for the task to be .15
    speed = screenYpixels * 0.15;

    % Sync us and get a time stamp
    vbl = Screen('Flip', window);
    waitframes = 1;

    % Maximum priority level
    topPriorityLevel = MaxPriority(window);
    Priority(topPriorityLevel);

    %The dot grid starts at the horizontal center of the screen
    gridPos = 0;

    %The only keys that can be pressed are leftarrow, rightarrow, and
    %escape
    RestrictKeysForKbCheck([KbName('LeftArrow') KbName('RightArrow') KbName('ESCAPE')]);

    %50/50 of getting 1 or -1, this determines direction of dots
    %1 will make the grid move right, -1 will make it move left
    coinflip = randi(2);
    if coinflip == 2
        coinflip = -1;
    end


    % Loop the animation until a key is pressed
    %Written by Josh with Alejandro observing as code was being pushed:
    %Alejandro debugged and fixed the KbCheck functions
    %this took about an hour to look for names of keycodes and correctly
    %restrict keys
        %2 hours to design the movement of the dotgrid and base it on the random
        %coinflip
        %1 hour to incoporate the keystroke checks to determine accuracy
    while ~KbCheck
        while (gridPos < 500) && (gridPos > -500)
            if ~KbCheck
                % Position of the square on this frame
                %coinflip makes gridPos positive if moving right and
                %negative if moving left
                gridPos = speed * time * coinflip;

                % Draws the dot grid, changing every value in the x
                % position vector by gridPos
                Screen('DrawDots', window, [xPosVector + gridPos; yPosVector],...
                    dotSizes, dotColors, dotCenter, 2);

                % Flip to the screen
                vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

                % Increment the time
                time = time + ifi;
            else
                %If a key was pressed, end the animation
                break
            end
        end
        %The animation ends, the grid has reached the edge of the screen
        %This resets the animation after a short pause
        if ~KbCheck
            time = 0;
            gridPos = 0;
            pause(1);
        else
            %If, while the animation is paused in its final frame, a key is
            %pressed, end the animation loop
            break
        end
    end

    %if right is pressed, pressed_right is 1, if left was pressed,
    %pressed_right is -1
    %if escape was pressed, Close All
    %Josh spent 45 minutes figuring out the KbCheck function and
    %determining and implementing the correct keyCodes while Alejandro
    %observed and did research on how to write it while code was being
    %pushed
    [keyIsDown, secs, keyCode] = KbCheck;
    if find(keyCode) == 79
        pressed_right = 1;
    elseif find(keyCode) == 41
        sca
    else
        pressed_right = -1;
    end

    %if the correct key is pressed, display correct and exit the
    %distraction
    %if the incorrect key is pressed, display incorrect and restart the
    %distraction
    if coinflip == pressed_right
        %display 'Correct'
        Screen('TextSize', window, 60);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, 'Correct' ,...
        'center', screenYpixels * 0.5, [0 1 0]);
        Screen('Flip', window);
        pause(1);
        correct = 1;
    else
        %display 'Incorrect'
        Screen('TextSize', window, 60);
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, 'Incorrect' ,...
        'center', screenYpixels * 0.5, [1 0 0]);
        Screen('Flip', window);
        pause(1);
    end
    
    
end
%Removes the key restrictions, now any key can be pressed as we return to
%the card sorting task
RestrictKeysForKbCheck([]);

