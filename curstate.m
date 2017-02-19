function [st] = curstate(hand,showcard)

[hv,usableAce] = handValue(hand);
 
st = [ hv,showcard, usableAce]; 

return; 


