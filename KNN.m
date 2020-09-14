function [label, TocVaule]=KNN(training,testing,D,K)

[row, column]=size(training);
[row1]=size(testing);
distance=[];

  
for i=1:row1
    for j=1:row
        temp=[training(j,(1:(column-1)));testing(i,:)];
        d=pdist(temp);
        distance(i,j)=d;
    end
end


tic;
label=[];
for i=1:row1
    [a,b]=sort(distance(i,:));
    neighbors=b(1:K)';
    neighbors_D=training(neighbors,column);
    [x,y]=sort(neighbors_D);
    temp=find(diff(x)~=0);        
    nei_d=[x(1);x(temp+1)];
    Num_D=[];
    for j=1:length(nei_d)
        num=length(find(neighbors_D==nei_d(j)));
        Num_D=[Num_D,num];
    end
    [a,b]=max(Num_D);
    label(i,1)=nei_d(b);
end
TocVaule = toc;

        
