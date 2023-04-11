%mse derieved from different methods
mse_auto=[0.08724981236950832, 0.04762668902470006, 0.03732564984338715, 0.027959317697724546];
mse_ista=[0.4196,0.2295,0.1645,0.1192];
mse_omp=[0.4758,0.4771,0.2697,0.1018];
mse_mm=[0.494867522435962,0.496802187692124,0.313027877870653,0.084481337270949];
figure(1);
row_number=[25,100,200,500];%different number of rows\
plot(row_number,mse_auto,'m-o');hold on;
plot(row_number,mse_ista,'r-o');hold on;
plot(row_number,mse_omp,'k-o');hold on;
plot(row_number,mse_mm,'g-o');
title('MSE of recoverd image based on different methods');
xlabel('Number of measurements');
ylabel('Mean square errror of reconstructed image to original ones');
legend('auto-encoder','ista','omp','mm');

% 
% % Img=csvread('mnist_train.csv');  %read file
% Img=csvread('mnist_test.csv');  %read file
%  real_number=Img(:,1);
% Img=im2double(Img/255);
% figure(2);
% for i=6:9
%        pic_flatten=Img(i,2:end);
%     pic=reshape(pic_flatten,28,28);
%     subplot(2,2,i-5);
%    
%  title(fprintf('%d',real_number(i)));
% imshow(pic');
% end