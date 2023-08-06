clc
clear all
W=xlsread('D:\桌面\hhh.xlsx',1,'A1:I84')
X=W(:,2:8)
Y=W(:,1)
%%
temp=randperm(size(X,1))
P_train=X(temp(1:50),:)'
I_train=Y(temp(1:50),:)'
P_test=X(temp(51:end),:)'
I_test=Y(temp(51:end),:)'
M=size(P_train,2)
N=size(P_test,2)
%%
[P_train,ps_input]=mapminmax(P_train,0,1)
P_test=mapminmax('apply',P_test,ps_input)
[I_train,ps_output]=mapminmax(I_train,0,1)
I_test=mapminmax("apply",I_test,ps_output)
%%
P_test=P_test'
P_train=P_train'
I_test=I_test'
I_train=I_train'
%%
trees=200
leaf=5
OOBPrediction='on'
OOBpredictorImportance='on'
Method='regression'
net=TreeBagger(trees,P_train,I_train,'OOBpredictorImportance',OOBpredictorImportance,'Method',Method,'OOBPrediction',OOBPrediction,'minleaf',leaf)
importance=net.OOBPermutedPredictorDeltaError
%%
t_sim1=predict(net,P_train)
t_sim2=predict(net,P_test)
T_sim1=mapminmax('reverse',t_sim1,ps_output)
T_sim2=mapminmax('reverse',t_sim2,ps_output)
I_train=mapminmax('reverse',I_train,ps_output)
I_test=mapminmax('reverse',I_test,ps_output)
%%
MSE1=sqrt(sum((I_train-T_sim1).^2)/N)
MSE2=sqrt(sum((I_test-T_sim2).^2)/N)
%%
figure(1)
plot(1:N,I_test,'b:*',1:N,T_sim2,'r-o')
legend('original data','predict value')
title('BP network:process of prediction')
xlabel('order')
ylabel('value')
string = {'prediction VS real value';
          ['estimation value error= ' num2str(MSE2)]};
title(string)
figure(2)
plot(1:size(I_train,1),I_train,'b:*',1:size(I_train,1),T_sim1,'r-o')
legend('original data','fitted value')
title('random forest:process of fit')
xlabel('order')
ylabel('value')
string = {'fitted value VS real value';
          ['estimation value error= ' num2str(MSE1)]};
title(string)
%%
figure(3)
bar(importance)
legend("importance level")
xlabel("feature")
ylabel("level")
%%
figure(4)
plot(1:trees,oobError(net),'b-','LineWidth',1)
legend('error line')
xlabel("number of decision tree")
ylabel("error")
xlim([1,trees])
grid

