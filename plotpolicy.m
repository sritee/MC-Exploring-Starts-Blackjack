% plotting function

function [opt_act]=plotpolicy(qvalues)

opt_act=zeros(size(qvalues,1),1);

for i=1:size(qvalues,1)

    [~,opt_act(i)]= max(qvalues(i,:));
   
end
 %First display usable ace plots. Following steps to display axes
 %correctly,i.e shape manipulating of matrix.
 usableace=flipud(reshape(opt_act(1:100),10,10)');
 
 xticks=linspace(1,10,10);
 yticks=linspace(21,12,10);
 imagesc(xticks,yticks,usableace);
 set(gca,'Ydir','normal');
 title('Plots for usable ace: Blue indicates Hit');
 pause;
 nousableace=flipud(reshape(opt_act(101:200),10,10)');
 
 xticks=linspace(1,10,10);
 yticks=linspace(21,12,10);
 imagesc(xticks,yticks,nousableace);
 set(gca,'Ydir','normal');
 title('Plots for no usable ace: Blue indicates Hit');
 
 
 
 
 
 
