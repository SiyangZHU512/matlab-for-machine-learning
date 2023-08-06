clear all 
close all
clc
%%
logit=xlsread('D:\桌面\logit.xlsx',1,'A1:C301')
t=logit(:,1)
edu=logit(:,2)
income=logit(:,3)
Y=nominal(t)
figure(1)
gscatter(edu,income,Y,'kk','xo')
xlabel('受教育年限','fontsize',12)
ylabel('收入水平状况','fontsize',12)
title('数据可视化','fontsize',12)
set(gca,'linewidth',2)
[edu,ps]=mapminmax(edu,0,1)
[income,ps]=mapminmax(income,0,1)

X=[edu,income]
rand_num=randperm(300)
X_train=X(rand_num(1:200),:)
Y_train=Y(rand_num(1:200),:)
X_test=X(rand_num(201:300),:)
Y_test=Y(rand_num(201:300),:)
N=size(Y_test,1)
model = fitcsvm(X_train,Y_train,'KernelFunction','linear')
[lable,score]=predict(model,X_test)
Sim=double(lable)
Y_test=double(Y_test)
error1=sum(abs(Sim-Y_test))/N
SVMModel=fitcsvm(X_train,Y_train,'BoxConstraint',10,'KernelFunction','rbf','KernelScale',2^0.5*2)
[label,score1]=predict(SVMModel,X_test)
Sim2=double(label)
error2=sum(abs(Y_test-Sim2))/N
figure(2)
plot(1:100,Y_test,'r-*')
hold on
plot(1:100,Sim,'b:o')
grid on
legend('real class','predict')
xlabel('order')
ylabel('class')
string = {'SVM model 1 prediction';
          ['estimation value error= ' num2str(error1)]};
title(string)
figure(3)
plot(1:100,Y_test,'r-*')
hold on
plot(1:100,Sim2,'b:o')
grid on
legend('real class','predict')
xlabel('order')
ylabel('class')
string = {'SVM model 2 prediction';
          ['estimation value error= ' num2str(error2)]};
title(string)
figure(4)
cm=confusionchart(Y_test,Sim)
cm.Title='confusion matrix for SVM1 model'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'
figure(5)
cm=confusionchart(Y_test,Sim2)
cm.Title='confusion matrix for SVM2 model'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'


