clear all
clc
close all
%% if the data is limited, then GM is a good method 
X=[71.1,72.4,72.4,72.1,71.4,72,71.6]
n=7
grid on
figure(1)
plot(1:7,X,'ro')
W=[]
Q1=exp(-2/(n+1))
Q2=exp(2/(n+1))
for i=1:7
    if i==1
        W(i)=X(i)
    else
        W(i)=X(i-1)/X(i)
    end
end
figure(2)
plot(W(2:7),zeros(1,6),'bo')
hold on
x = [Q1,Q2]
y=[2,2]; 
stem(x,y,'Marker','none');
% if data in the range then it is ok to use GM method
%%
X1=cumsum(X)
for K=2:length(X)
    z(K)=1/2*(X1(K)+X1(K-1))
end
z
B=[(-z(2:end))',ones(length(z)-1,1)]
Y=(X(2:end))'
beta=inv(B'*B)*B'*Y
a=beta(1)
b=beta(2)
c=b/a
d=X1(1)-c
X1(length(X1)+1)=[X(1)-c]*exp(-a*length(X))+c
%fitted and resiudal
X2(1)=X1(1)
for m=1:length(X)-1
    X2(m+1)=(X(1)-c)*exp(-a*m)+c
end
X2
X3(1)=X2(1)
for m=1:length(X)-1
    X3(m+1)=X2(m+1)-X2(m)
end
X3
deta0=X-X3
deta1=abs(X-X3)
phi=deta1./X
mphi=mean(phi)
eta=(min(deta1)+0.5*max(deta1))./(deta1+0.5*max(deta1))
r=mean(eta)
%r vs 0.6 ，mphi vs 0.05
%residual test
mX=mean(X)
sX=std(X)
mdeta1=mean(deta1)
sdeta1=std(deta1)
C=sdeta1/sX
S0=0.6745*sX
e=abs(deta1-mdeta1)
p=length(find(e<S0))/length(e)
%if p >0.8 and C<0.05---model have excellent preformance 
%prediction
k=length(X):length(X)+2
X2(k+1)=(X(1)-c)*exp(-a*k)+c
X3(k+1)=X2(k+1)-X2(k)
t=1:length(X)
t1=1:length(X)+3
figure(3)
plot(t,X,'+',t1,X3,'-o')
legend('orignal data','predicted value')


