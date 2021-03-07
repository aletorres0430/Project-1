
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
        (card5number == card3number) || (card5number == card4number)
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



%determines which card 1-4 is the correct card for the current rule and
%sets correctcard equal to that card's number
cardnumbers = [card1number card2number card3number card4number];
if rule == 1 %shapes, in blocks of 16
    correctcardnumber = find(floor(cardnumbers/16) == floor((card5number-1)/16));
elseif rule == 2 %colors, rotates every 4
    correctcardnumber = find(mod(cardnumbers, 4) == mod(card5number, 4));
else %number in blocks of 4
    correctcardnumber = find(floor(mod((cardnumbers-1), 16)/4) == floor((mod(card5number, 16)-1)/4));
end

correctcard = allcards(cardnumbers(correctcardnumber));
