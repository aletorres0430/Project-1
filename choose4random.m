
%chooses numbers, color, shape
card_numbers = randperm(4);
card_colors = randperm(4);
card_shapes = randperm(4);

card1 = card_numbers(1) + 4 * (card_colors(1) - 1) + 16 * (card_shapes(1) - 1);
card2 = card_numbers(2) + 4 * (card_colors(2) - 1) + 16 * (card_shapes(2) - 1);
card3 = card_numbers(3) + 4 * (card_colors(3) - 1) + 16 * (card_shapes(3) - 1);
card4 = card_numbers(4) + 4 * (card_colors(4) - 1) + 16 * (card_shapes(4) - 1);