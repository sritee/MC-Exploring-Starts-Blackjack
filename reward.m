function [rew] = reward(phv,dhv)

if( phv>21&& dhv>21 ) % player went bust
  rew = 0; 
  %disp('game tied');
  return; 
end

if phv >21
    rew=-1;
    %disp('player lost');
    return
end

if( dhv>21 ) % dealer went bust
  rew = +1; 
  %disp('player won');
  return; 
end

if( phv==dhv ) % a tie
  rew = 0; 
  %disp('game tied');
  return;
end

if( phv>dhv ) % the larger hand wins
  rew = +1; 
  %disp('player won');
else
  rew = -1; 
  %disp('player lost');

end

end


