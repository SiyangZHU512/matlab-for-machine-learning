%%
clear all
clc
A=xlsread('D:\桌面\热图像.xlsx',1,'A1:K4001')
covmat=corrcoef(A)
figure
imagesc(covmat)
grid
colorbar
A1=A(:,1)
A2=A(:,2)
plot(A1,A2,'*')
m2=LinearModel.fit(A1,A2)
X=[ones(4000,1),A1];
[b,bint,r,rint,s]=regress(A2,X)
%b:coefficient bint£ºconfident interval for coefficient r£ºresidual rint£ºCI for residual
%model check%
figure(1)
subplot(2,2,1)
plot([1:4000],r,'*-')
hold on
plot([1:4000],rint(:,1),'-+')
hold on
plot([1:4000],rint(:,2),'+-')
subtitle("residual plot")
subplot(2,2,2)
qqplot(r)
subtitle("qqplot for residual")
subplot(2,2,3)
yhat=X*b
plot(yhat,r,'*')
subtitle("residual VS fitted value")
subplot(2,2,4)
boxplot(r)
subtitle("boxplot for residual")
%% higher order fit
X=[ones(4000,1),A1,A1.^2];
[b,bint,r,rint,s]=regress(A2,X)
figure(2)
subplot(2,2,1)
plot([1:4000],r,'*-')
hold on
plot([1:4000],rint(:,1),'-+')
hold on
plot([1:4000],rint(:,2),'+-')
subtitle("residual plot")
subplot(2,2,2)
qqplot(r)
subtitle("qqplot for residual")
subplot(2,2,3)
yhat=X*b
plot(yhat,r,'*')
subtitle("residual VS fitted value")
subplot(2,2,4)
boxplot(r)
subtitle("boxplot for residual")
%% multiple regression
A1=A(:,1)
A2=A(:,2)
A3=A(:,3)
A4=A(:,4)
figure(3)
subplot(1,3,1),plot(A1,A2,'g*')
subtitle("scatter plot for A1 VS A4")
subplot(1,3,2),plot(A1,A3,'k+')
subtitle("scatter plot for A1 VS A3")
subplot(1,3,3),plot(A1,A4,'ro')
subtitle("scatter plot for A1 VS A4")
X=[ones(4000,1),A2,A2.^2,A3,A3.^2,A4,A4.^2,A4.^3];
[b,bint,r,rint,s]=regress(A1,X)
figure(4)
subplot(2,2,1)
plot([1:4000],r,'*-')
hold on
plot([1:4000],rint(:,1),'-+')
hold on
plot([1:4000],rint(:,2),'+-')
subtitle("residual plot")
subplot(2,2,2)
qqplot(r)
subtitle("qqplot for residual")
subplot(2,2,3)
yhat=X*b
plot(yhat,r,'*')
subtitle("residual VS fitted value")
subplot(2,2,4)
boxplot(r)
subtitle("boxplot for residual")
%% stepwise regression
AL=A(:,2:10)
A1=A(:,1)
stepwise(AL,A1,[1,2,3,4,5,6,7,8,9],0.05,0.1)
%% logit 
[~,idx]=sort(A(:,11))
A=A(idx,:)

F=A(:,11)
A1=A(:,1:10)
GM=fitglm(A1,F,'distribution','binomial','link','logit')
Y1=predict(GM,A1)
Y_hat=[]
for i=1:4000
    if Y1(i)>=0.5
       Y_hat(i)=1
    else
       Y_hat(i)=0
    end
end
figure(1)
plot([1:4000],F,'-kd')
hold on
scatter([1:4000],Y1,'b')
error=sum(abs(F-Y_hat))/4000
figure(2)
plot(1:4000,F,'r-*')
hold on
plot(1:4000,Y_hat,'b:o')
grid on
legend('real class','prediction class')
xlabel('order')
ylabel('classes')
string = {'GLM estimation result';
          ['estimation value error= ' num2str(error) '%']};
title(string)
