A=xlsread('D:\桌面\logit.xlsx',1,'A1:C4001')
treat=A(:,1)
edu=A(:,2)
income=A(:,3)
figure(1)
gscatter(edu,income,treat,'kk','xo')
xlabel('受教育年限','fontsize',12)
ylabel('收入水平状况','fontsize',12)
title('数据可视化','fontsize',12)
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
figure(3)
plot(1:length(Y_test),Y_test,'r-*')
hold on
plot(1:length(Y_test),Y_Nb,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('测试集样本编号')
ylabel('测试集样本类别')
string = {'测试集朴素贝叶斯算法预测结果对比';
          ['estimation value error= ' num2str(error_ratio) '%']};
title(string)