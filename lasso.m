clear all
A=xlsread('D:\桌面\热图像.xlsx',1,'A1:K4001')
covmat=corrcoef(A)
figure(1)
imagesc(covmat)
grid
colorbar
A1=A(:,1)
A2=A(:,2)
A3=A(:,3)
A4=A(:,4)
X=[ones(4000,1),A2,A2.^2,A3,A3.^2,A4,A4.^2,A4.^3];
error=[]
for i=1:30
rand_num=randperm(4000)
X_train=X(rand_num(1:3000),:)
y_train=A1(rand_num(1:3000),:)

X_test=X(rand_num(3001:4000),:)
y_test=A1(rand_num(3001:4000),:)
for n=1:10
    a=n/10
[B,fit]=lasso(X_train,y_train,'CV',5,'Alpha',a)
idx = fit.Index1SE;
coef = B(:, idx);
intercept = fit.Intercept(idx);
yhat = X_test * coef + intercept;
error(i,n)=sum(abs(y_test-yhat))
end
end
b=sum(error)
% alpha =0.6 have min error
[B,fit]=lasso(X_train,y_train,'CV',5,'Alpha',0.6)
idx = fit.Index1SE;
coef = B(:, idx);
intercept = fit.Intercept(idx);
yhat = X_test * coef + intercept;
axTrace = lassoPlot(B,fit)
axCV=lassoPlot(B,fit,'PlotType','CV');
r=y_test-yhat

%%
figure(2)
subplot(1,2,1)
plot(y_test,'bo')
hold on
plot(yhat,'r*')
grid on
xlabel('order')
ylabel('type')
legend('real value','predicted value')
set(gca,'fontsize',12)
subplot(1,2,2)
plot(X_test(:,2),yhat,'*')

figure(3)
subplot(2,2,1)
plot([1:1000],r,'*-')
hold on
plot([1:1000],r,'-+')
hold on
plot([1:1000],r,'+-')
subplot(2,2,2)
qqplot(r)
subplot(2,2,3)
plot(yhat,r,'*')
subplot(2,2,4)
boxplot(r)

