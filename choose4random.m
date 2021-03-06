
%chooses numbers, color, shape

%1: blue, 2: green, 3: red, 4: yellow
card_colors = randperm(4);

%1: 1 shape, 2: 2, 3: 3, 4: 4
card_numbers = randperm(4);

%1:circle, 2:cross, 3:star, 4:triangle
card_shapes = randperm(4);

%each card number is determined by its position in each shape, number, and
%color range
card1number = card_colors(1) + 4 * (card_numbers(1) - 1) + 16 * (card_shapes(1) - 1);
card2number = card_colors(2) + 4 * (card_numbers(2) - 1) + 16 * (card_shapes(2) - 1);
card3number = card_colors(3) + 4 * (card_numbers(3) - 1) + 16 * (card_shapes(3) - 1);
card4number = card_colors(4) + 4 * (card_numbers(4) - 1) + 16 * (card_shapes(4) - 1);

%card5 is a random one of the cards, but cannot be the same as one of the 4
%displayed cards
card5number = randi(64);
while (card5number == card1number) || (card5number == card2number) || ...
        (cardnumber == card3number) || (card5number == card4number)
    card5number = randi(64);
end



%allcards is an array of the names of image files in stimuli folder with
%stimuli/ added to the front
allcards = dir('stimuli');
allcards(1:2) = [];
allcards = {allcards.name};
allcards = string(allcards);
for ii = 1:64
    allcards(ii) = strcat('stimuli/', allcards(ii));
end

%each card file name is retrieved from the list in allcards
card1 = allcards(card1number);
card2 = allcards(card2number);
card3 = allcards(card3number);
card4 = allcards(card4number);
card5 = allcards(card5number);



%chooses new rule: 1 is shape, 2 is color, 3 is number
newrule = randi(3);

%makes sure the new rule is not the same as the old one
while newrule == rule
    newrule = randi(3);
end
rule = newrule;

cardnumbers = [card1number card2number card3number card4number];
if rule == 1
    correctcard = find(floor(cardnumbers./16), floor(card5number/16));
elseif rule == 2
    correctcard = find(floor(cardnumbers./16), floor(card5number/16));


