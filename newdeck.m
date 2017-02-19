function [deck] = newdeck()
deck = randperm( 52 ); 
deck= mod(deck-1,13)+1;
deck=min(deck,10);
end
