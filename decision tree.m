clc
clear all
close all
clc
warning off
%%
load fisheriris
species=grp2idx(species)
meas=mapminmax(meas)
temp=randperm(size(meas,1))
P_train=meas(temp(1:120),:)
I_train=species(temp(1:120),:)
P_test=meas(temp(121:end),:)
I_test=species(temp(121:end),:)
%different to BP network(in term of input feature(matrix form)--same with SVM)
%%
ctree=ClassificationTree.fit(P_train,I_train)
view(ctree)
view(ctree,'mode','graph')
I_sim=predict(ctree,P_test)
error=sum(abs(I_sim-I_test))/30
figure(1)
plot(1:30,I_test,'r-*')
hold on
plot(1:30,I_sim,'b:o')
grid on
legend('original data','predict value')
title('decision tree:process of prediction')
xlabel('order')
ylabel('value')
string = {'predict value VS real value';
          ['estimation value error= ' num2str(error)]};
title(string)
%%
figure
cm=confusionchart(I_test,I_sim)
cm.Title='confusion matrix for test data'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'
