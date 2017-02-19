function [hv,usableAce] = handValue(hand)

sv= sum(hand); 
% count ace as 11 if needed
if (any(hand==1)) && (sv<=11)
   sv = sv + 10;
   usableAce = 1; 
else
   usableAce = 0; 
end

hv = sv; 
