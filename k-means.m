%% 二维数据
load fisheriris
data=meas(:,1:2)
K=3
[idx,cen]=kmeans(data,2,'replicate',100,'display','final')
silhouette(data,idx)
color=['r','g','b']
dist=sum(cen.^2,2)
[dump,sortind]=sort(dist,'ascend');
newidx=zeros(size(idx));
for i=1:K
    newidx(idx==i)=find(sortind==i)
end
figure 
for i=1:3
    plot(data(newidx==i,1),data(newidx==i,2),'color',color(i),'linestyle','none','marker','*')
    hold on
end
a=cen(:,1)
b=cen(:,2)
plot(a,b,'color','linestyle','none','marker','bo')
grid on

%% 
load fisheriris
K=3
spec=findgroups(species)
meas=meas(:,1:3)
[kidx,cen]=kmeans(meas,K)
dist=sum(cen.^2,2)
[dump,sortind]=sort(dist,'ascend');
newidx=zeros(size(kidx));
for i=1:K
    newidx(kidx==i)=find(sortind==i)
end

figure
plot3(meas(kidx==1,1),meas(kidx==1,2),meas(kidx==1,3),'ro',...
    meas(kidx==2,1),meas(kidx==2,2),meas(kidx==2,3),'bo',...
    meas(kidx==3,1),meas(kidx==3,2),meas(kidx==3,3),'kd')
set(gca,'XTick',[0:1:10],'YTick',[0:1:10],'ZTick',[0:1:10])
xlabel('变量1','fontsize',12)
ylabel('变量2','fontsize',12)
zlabel('变量3','fontsize',12)
title('k-means 聚类分析')
C=confusionmat(spec,kidx)
Ac=(C(1,1)+C(2,2)+C(3,3))/numel(species)