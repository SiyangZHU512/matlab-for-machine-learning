clc
clear all
A=xlsread('D:\桌面\logit.xlsx',1,'A1:C4001')
treat=A(:,1)
edu=A(:,2)
income=A(:,3)
figure(1)
gscatter(edu,income,treat,'kk','xo')
xlabel('education level','fontsize',12)
ylabel('income','fontsize',12)
title('data visualization for prediction','fontsize',12)
set(gca,'linewidth',2)
X=[edu,income]
rand_num=randperm(300)
X_train=X(rand_num(1:200),:)
Y_train=treat(rand_num(1:200),:)
X_test=X(rand_num(101:300),:)
Y_test=treat(rand_num(101:300),:)
%朴素贝叶斯
Nb=fitcnb(X_train,Y_train)
Y_Nb=Nb.predict(X_test)
disp('result')
C_knn=confusionmat(Y_test,Y_Nb)
error_ratio=sum(abs(Y_test-Y_Nb))
figure(2)
plot(1:length(Y_test),Y_test,'r-*')
hold on
plot(1:length(Y_test),Y_Nb,'b:o')
grid on
legend('real class','predict class')
xlabel('order')
ylabel('class')
string = {'result of naive bayes method';
          ['estimation value error= ' num2str(error_ratio) '%']};
title(string)

figure(3)
cm=confusionchart(Y_test,Y_Nb)
cm.Title='confusion matrix for test data'
cm.ColumnSummary='column-normalized'
cm.RowSummary='row-normalized'
