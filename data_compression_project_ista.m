clear all;
%read the image
Img=csvread('mnist_test.csv');      %read file
% Img=csvread('mnist_train.csv');      %read file
Img=im2double(Img/255);
real_number=Img(1,1);
row_number=[25,100,200,500];%different number of rows
% pic_flatten=Img(1,2:end);
% pic=reshape(pic_flatten,28,28);


%n_example=5;%number of image samples to show

%%
n_example=100;%number of image samples to show
m=1
error1=zeros(1,4)
for i=1:4 % decide matrix size of A
for n_e=1:n_example
%figure(1);
%     m=randi([1,60000]);

    pic_flatten=Img(m,2:end);%randomly choose one image from the training set
    m=m+1;
    pic=reshape(pic_flatten,28,28);

       
        %random matrix A
        n=row_number(i);
        A=randn(n,28*28);
        A=sqrt(1/n)*A;
        A=orth(A')';

    %main iteration
        x=zeros(28*28,1);
       %%%%%%%%%%%%%%%%%%%%%%%%%%
       %parameters used in iteration process
        num=3e3; %num pf iteration
        lam=2e-5;
        eps=1e-4;%threshold
       %%%%%%%%%%%%%%%%%%%%%%%%%
         y=sign(A*pic_flatten');
          for t=1:num
                x1=x;
                v=y-A*x;
                r=x+A'*v;
                x=soft_1(r,lam);

                if norm(x-x1)<eps
                fprintf('iteration ends (threshold reached)£¬num=%d\n',t);  
                break;
                end
                if j==num
                fprintf('iteration ends (max num reached)£¬num=%d\n',t);
                end
          end
          
          P=reshape(x,28,28); 
          subplot(n_example,5,5*(n_e-1)+i);   
          imshow(P');
%     dif = mse(pic_flatten- x');
%     error1(1,i)=error1(1,i)+dif;
end
subplot(n_example,5,5*n_e);%original image
imshow(pic');

 
end   
% error1=error1/100;
suptitle({'ISTA with different number of measurements';'(25,100,200,500 and orginal image)'});



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%other function used
function PSNR=psnr(I,K)

%I is transformed image£¬K is original
Diff = double(I)-double(K);
MSE = sum(Diff(:).^2)/numel(I);
PSNR=10*log10(1^2/MSE);
end

function soft=soft_1(r,lam)
[a,b]=size(r);

for i=1:a
    for j=1:b
if r(i,j)>0
    sgn1=1;
else
    sgn1=-1;
end
if (abs(r(i,j))-lam)>0
     r(i,j)=sgn1*(abs(r(i,j))-lam);
 else
     r(i,j)=0;
end
    end
end
soft=r;
end   

%%