clc
clear all
close all
%%
load fisheriris
figure(1)
speciesNum=grp2idx(species)
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
xlabel('length')
ylabel('width')
title('classification')
set(gca,'fontsize',12)
%% 
data=[meas(:,3),meas(:,4)]
datalink=linkage(data,'average','euclidean')
figure(2)
dendrogram(datalink,10)
title('Tree diagram (10 nodes)')
%
figure(3)
dendrogram(datalink,0)
title('Tree diagram (all the nodes)')
%%
T1=cluster(datalink,'cutoff',1.5,'criterion','distance')
cen=[mean(data(T1==1,:));...
    mean(data(T1==2,:));...
    mean(data(T1==3,:))];
dist=sum(cen.^2,2);
[dump,sortind]=sort(dist,'ascend')
newT1=zeros(size(T1))
for i=1:3
    newT1(T1==i)=find(sortind==i)
end
%%
figure(4)
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
gscatter(data(:,1),data(:,2),newT1,['r','g','b'],'o',10)
scatter(cen(:,1),cen(:,2),300,'m*')
hold off 
xlabel('length')
ylabel('width')
title('classification')
set(gca,'fontsize',12)
%%
T2=cluster(datalink,'maxclust',3)
cen=[mean(data(T2==1,:));...
    mean(data(T2==2,:));...
    mean(data(T2==3,:))];
dist=sum(cen.^2,2)
[dump,sortind]=sort(dist,'ascend')
newT2=zeros(size(T2))
for i=1:3
    newT2(T2==i)=find(sortind==i)
end
%%
figure(5)
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
gscatter(data(:,1),data(:,2),newT2,['r','g','b'],'o',10)
scatter(cen(:,1),cen(:,2),300,'m*')
hold off 
xlabel('length')
ylabel('width')
title('classification')
set(gca,'fontsize',12)
%%混淆矩阵
figure(6)
cm=confusionchart(speciesNum,newT1)
cm.Title='confusion matrix for test data'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'
figure(7)
cm=confusionchart(speciesNum,newT2)
cm.Title='confusion matrix for test data'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'
