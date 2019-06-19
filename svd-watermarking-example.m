clear all
close all
clc

a=0.1;

%% ENCODE
A=imread('cameraman.tif'); %orginal image

W=imread('rice.png'); 
W=rgb2gray(W);
W=imresize(W,[256 256]);
figure;

subplot(121),imshow(A);title('A  görüntüsü');
subplot(122),imshow(W);title('W gizlenecek görüntü');

[U1,S1,V1] = svd(double(A)); 
temp = S1+(a * double(W)); 
[Uw,Sw,Vw] = svd(temp); 
Aw = U1*Sw*(V1.'); 
% Aw(20:70,50:100)=0;
Aw=imnoise(uint8(Aw),'speckle',0.07);% Noise
figure;

subplot(121),imshow(uint8(Aw))
c1=corr2(A,Aw);
title(['A_{w} : Korelasyon (A,A_{w}): ',num2str(c1)]);

%% DECODE
Aw=double(Aw);
[Uw1,Sw1,Vw1] = svd(Aw);
D = Uw*Sw1*(Vw.') ;

W2 = (D-S1)/a;

subplot(122),imshow(uint8(W2))

c1=corr2(W,W2);
title(['W^{*} : Korelasyon (W,W_{*}): ',num2str(c1)]);