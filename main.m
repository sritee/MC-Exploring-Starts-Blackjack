%blackjack MC exploring starts
%Code by Sridhar
%Note, this version of blackjack is different from the book in that the cards are
%generated from a deck.Hence all sums are not equally likely, unlike in the
%book, which draws cards from an infinite deck.
clear;
clc; 

allstates= xlsread('states.xls');
num_iters=4e6; %might take 15-30 minutes.
num_states= size(allstates,1);
qvalues=zeros(num_states,2);
qcount=zeros(num_states,2);
for hi=1:num_iters,
 disp(hi);
  qvisit=zeros(num_states,2);
  
  deck = newdeck(); 
 
  % the player gets the first two cards: 
  p = deck(1:2); deck = deck(3:end); phv = handValue(p);
  % the dealer gets the next two cards (and shows his first card): 
 d= deck(1:2); deck = deck(3:end); 
  dhv = handValue(d); 
  showcard = d(1); 
  
  while(phv < 12) % always hit below 12
     p=[p,deck(1)];
     deck=deck(2:end);
     phv=handValue(p);
  end
  state=curstate(p,showcard);
  
   % implement the policy of the dealer
  while( dhv < 17 )
    d = [ d, deck(1) ]; deck = deck(2:end); % HIT
    dhv = handValue(d); 
  end
  
  % take the first action as random i.e Exploring Starts
  
  [~,idx]=ismember(state,allstates,'rows'); %index of the state to be updated
  if(rand(1) <0.5)
  [~,action]=min(qvalues(idx,:));
  else
   [~,action]=max(qvalues(idx,:));
  end
       
     if(action==1)
  p=[p,deck(1)];% hit
  deck=deck(2:end);
  phv=handValue(p);
  qvisit(idx,1)=1;
  qcount(idx,1)=qcount(idx,1)+1;
  % accumulate/store the first state action seen: 
 
     elseif action==2 % stick
  rew = reward(phv,dhv);
  qcount(idx,2)=qcount(idx,2)+1;
  qvalues(idx,2)=qvalues(idx,2)+(1/(qcount(idx,2))*(rew- qvalues(idx,2)));
  continue;
     end
  
 
  
  while(1)
       state=curstate(p,showcard);
  [~,idx]=ismember(state,allstates,'rows');
        if(phv>21)
            break
        end
         [~,action]=max(qvalues(idx,:));
         if (action==2) % chosen to stick
             qvisit(idx,2)=1;
             qcount(idx,2)=qcount(idx,2)+1;
             break
         else % HIT
          qvisit(idx,1)=1;
          qcount(idx,1)=qcount(idx,1)+1;
          p=[p,deck(1)];
          deck=deck(2:end);
          phv=handValue(p);
          if(phv>21)
              break
          end
          state=curstate(p,showcard);
          [~,idx]=ismember(state,allstates,'rows'); 
         end  
  end
 
  % determine the reward for playing this game:
  rew = reward(phv,dhv);
  
  %accumulate these values: 
   visited=find(qvisit==1);
   for i=1:size(visited,1)
   [r,c]=ind2sub(size(qvalues),visited(i,1));
   qvalues(r,c)=qvalues(r,c)+ (1/(qcount(r,c))*(rew-qvalues(r,c)));
   end
  end

save('qvalues'qvalues');
plotpolicy(qvalues);




 
