
%chooses numbers, color, shape

%1: blue, 2: green, 3: red, 4: yellow
card_colors = randperm(4);

%1: 1 shape, 2: 2, 3: 3, 4: 4
card_numbers = randperm(4);

%1:circle, 2:cross, 3:star, 4:triangle
card_shapes = randperm(4);

%each card number is determined by its position in each shape, number, and
%color range
card1 = card_colors(1) + 4 * (card_numbers(1) - 1) + 16 * (card_shapes(1) - 1);
card2 = card_colors(2) + 4 * (card_numbers(2) - 1) + 16 * (card_shapes(2) - 1);
card3 = card_colors(3) + 4 * (card_numbers(3) - 1) + 16 * (card_shapes(3) - 1);
card4 = card_colors(4) + 4 * (card_numbers(4) - 1) + 16 * (card_shapes(4) - 1);