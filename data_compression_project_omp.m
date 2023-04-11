clear all;
% Img=csvread('mnist_train.csv');  %read file
Img=csvread('mnist_test.csv');  %read file
Img=im2double(Img/255);
% real_number=Img(:,1);
% pic_flatten=Img(1,2:end);
% pic=reshape(pic_flatten,28,28);

row_number=[25,100,200,500];%different number of rows\

n_example=100;%number of image samples to show
m=1;
error1=zeros(1,4);
for i=1:4
for t=1:n_example
    
%     m=randi([1,60000]);
    pic_flatten=Img(m,2:end);%randomly choose one image from the training set
    pic=reshape(pic_flatten,28,28);
  m=m+1;
%     figure(1);  
        n=row_number(i);
        A=randn(n,784);
         A=sqrt(1/n)*A;
        b=sign(A*pic_flatten');
        P=OMP(A,b,100);
        x=P;
        P=reshape(P,28,28);
%         subplot(n_example,5,5*(t-1)+i);
%         imshow(P');
dif = mse(pic_flatten- x');
error1(1,i)=error1(1,i)+dif;
    end
    
% subplot(n_example,5,5*t);
% imshow(pic');

end
error1=error1/100;
% suptitle({'OMP with different number of measurements';'(25,100,200,500 and orginal image)'});




function [x] = OMP(A,b,sparsity)
%Step 1
index = []; k = 1; [Am, An] = size(A); r = b; x=zeros(An,1);
cor = A'*r; 
while k <= sparsity
    %Step 2
    [Rm,ind] = max(abs(cor)); 
    index = [index ind]; 
    %Step 3
    P = A(:,index)*inv(A(:,index)'*A(:,index))*A(:,index)';
    r = (eye(Am)-P)*b; cor=A'*r;
    k=k+1;
end
%Step 5
xind = inv(A(:,index)'*A(:,index))*A(:,index)'*b;
x(index) = xind;
end
