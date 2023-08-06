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
rand_num=randperm(300)
X_train=X(rand_num(1:200),:)
Y_train=treat(rand_num(1:200),:)
X_test=X(rand_num(101:300),:)
Y_test=treat(rand_num(101:300),:)
%���ر�Ҷ˹
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
legend('��ʵ���','Ԥ�����')
xlabel('���Լ��������')
ylabel('���Լ��������')
string = {'���Լ����ر�Ҷ˹�㷨Ԥ�����Ա�';
          ['estimation value error= ' num2str(error_ratio) '%']};
title(string)