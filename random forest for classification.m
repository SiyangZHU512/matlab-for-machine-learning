warning off
close all
clear 
clc
%%
A=xlsread('D:\桌面\热图像.xlsx',1,'A1:K4001')
Y=A(:,11)
X=A(:,1:10)
temp=randperm(size(X,1))
P_train=X(temp(1:3950),:)
I_train=Y(temp(1:3950),:)
P_test=X(temp(3951:end),:)
I_test=Y(temp(3951:end),:)
%%
[P_train,ps_input]=mapminmax(P_train,0,1)
[P_test,ps_input]=mapminmax(P_test,0,1)
%%
trees=100
leaf=2
OOBPrediction='on'
OOBpredictorImportance='on'
Method='classification'
net=TreeBagger(trees,P_train,I_train,'OOBpredictorImportance',OOBpredictorImportance,'Method',Method,'OOBPrediction',OOBPrediction,'minleaf',leaf)
importance=net.OOBPermutedPredictorDeltaError
%%
t_sim1=predict(net,P_train)
t_sim2=predict(net,P_test)
T_sim1=str2num(cell2mat(t_sim1))
T_sim2=str2num(cell2mat(t_sim2))
error1=sum(abs(T_sim1-I_train))/3950
error2=sum(abs(T_sim2-I_test))/50
%%
figure(1)
plot(1:trees,oobError(net),'b-','LineWidth',1)
legend('error line')
xlabel("number of decision tree")
ylabel("error")
xlim([1,trees])
grid
%%
figure(2)
bar(importance)
legend("importance level")
xlabel("feature")
ylabel("level")
%%
figure(3)
plot(1:50,I_test,'r-*')
hold on
plot(1:50,T_sim2,'b:o')
grid on
legend('original data','predict value')
title('decision tree:process of prediction')
xlabel('order')
ylabel('value')
string = {'predict value VS real value';
         ['estimation value error= ' num2str(error2) '%']};
title(string)
%%
figure(4)
cm=confusionchart(I_test,T_sim2)
cm.Title='confusion matrix for test data'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'