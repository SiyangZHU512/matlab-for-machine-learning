A=xlsread('D:\����\logit.xlsx',1,'A1:C4001')
treat=A(:,1)
edu=A(:,2)
income=A(:,3)
figure(1)
gscatter(edu,income,treat,'kk','xo')
xlabel('�ܽ�������','fontsize',12)
ylabel('����ˮƽ״��','fontsize',12)
title('���ݿ��ӻ�','fontsize',12)
set(gca,'linewidth',2)
X=[edu,income]
%%
error=[]
%find optimal n%
for i=1:10
rand_num=randperm(300)
X_train=X(rand_num(1:200),:)
Y_train=treat(rand_num(1:200),:)
X_test=X(rand_num(101:300),:)
Y_test=treat(rand_num(101:300),:)
for n=1:15
    knn=ClassificationKNN.fit(X_train,Y_train,'Distance','seuclidean','NumNeighbors',n);
   [Y_knn,Y_score]=knn.predict(X_test)
   Yscore_knn=Y_score(:,2)
   error(i,n)=sum(abs(Y_test-Y_knn))
end
end
b=sum(error)

%% 
knn=ClassificationKNN.fit(X_train,Y_train,'Distance','seuclidean','NumNeighbors',1);
[Y_knn,Y_score]=knn.predict(X_test)
Yscore_knn=Y_score(:,2)
disp('result')
C_knn=confusionmat(Y_test,Y_knn)
yhat=[]
figure(2)
gscatter(X_test(:,1),X_test(:,2),Y_knn,'kk','xo')
xlabel('�ܽ�������','fontsize',12)
ylabel('����ˮƽ״��','fontsize',12)
title('���ݿ��ӻ�','fontsize',12)
set(gca,'linewidth',2)
erro_ratio=sum(abs(Y_test-Y_knn))/length(Y_test)
figure(3)
plot(1:length(Y_test),Y_test,'r-*')
hold on
plot(1:length(Y_test),Y_knn,'b:o')
grid on
legend('��ʵ���','Ԥ�����')
xlabel('���Լ��������')
ylabel('���Լ��������')
string = {'���Լ�KNNԤ�����Ա�';
          ['estimation value error= ' num2str(erro_ratio) '%']};
title(string)


