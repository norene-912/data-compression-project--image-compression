clear all;
%read the image
Img=csvread('mnist_test.csv');      %read file
% Img=csvread('mnist_train.csv');      %read file
Img=im2double(Img/255);

row_number=[25,100,200,500];%different number of rows
i=100;
error=zeros(1,4);
% error=0;
%  figure(1); %plot 5 image as illustration
%  suptitle({'MM with different number of measurements';'(25,100,200,500 and orginal image)'});
for n_e=1:4
n=row_number(n_e);
dif=0;
for test=1:10
real_number=Img(test,1);

pic_flatten=Img(test,2:end);
pic=reshape(pic_flatten,28,28);


 A=randn(n,784);
 A=sqrt(1/n)*A;
b=sign(A*pic_flatten');
% b=A*pic_flatten';

x=RL_1(b,A,i);
    if test<7 && test>1 %plot 5 image as illustration
        x_image=reshape(x,28,28);
        subplot(5,5,5*(test-2)+n_e);
        imshow(x_image');
        subplot(5,5,5*(test-1));
        imshow(pic');
    else
    end
%     dif = mse(pic_flatten- x');
%     error(1,n_e)=error(1,n_e)+dif; % calculate the error between reconstructed and original image (mse) 
end
% error=error/100;
end



function xh=RL_1(y,A,iter)
N=max(size(A));
M=min(size(A));
Li=(M/(4*log(N/M)));
y=y(:);
W=ones(N,1);   %initialize weight
QW=diag(W);    %intialize 
% delta=0.01;
for i=1:iter
    QWt=inv(QW);
    At=A*QWt;
    x0=At'*y;  %approximate a solution
    xh=l1eq_pd(x0,At,[],y,1e-3);
    delta=max(norm(xh,Li),1e-3) ;%update delta
    xh=QWt*xh;
    QW=diag(1./(abs(xh)+delta));
end

end