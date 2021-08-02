
clc;
clear all;
close all;

f1=.03;
f2=0.45;
row=255;
col=255;
n  =0:(2*pi/(col)):2*pi;
m  =0:(2*pi/(row)):2*pi;
 F1=128+127*cos(2*pi*f1*m')*cos(2*pi*f1*n);
        F2=128+127*cos(2*pi*f2*m')*cos(2*pi*f2*n);

subplot(1,2,1), imshow (uint8(F1),[]);title ('f= 0.03')
subplot(1,2,2), imshow (uint8(F2),[]);title ('f= 0.45')

% Computing DFT :

fft_img1 = fft2(F1);
fft_img2 = fft2(F2);     
    subplot(331); imshow(uint8(F1),[]); title(' original Image with f=0.03');  
    subplot(332); imshow(log10(abs(fft_img1)),[]); title('FFT log Magnitude for f=0.03 (not shifted)');
    subplot(333); imshow(fftshift(log10(abs(fft_img1))),[]); title('FFT log Magnitude for f=0.03 (shifted)');
    subplot(334); imshow(fftshift((angle(fft_img1)+3.14)/6.28),[]); title('FFT Phase for f=0.03 (shifted)');
    
     subplot(335); imshow(uint8(F2),[]); title(' original Image with f=0.45');  
    subplot(336); imshow(log10(abs(fft_img2)),[]); title('FFT log Magnitude for f=0.45 (not shifted)');
    subplot(337); imshow(fftshift(log10(abs(fft_img2))),[]); title('FFT log Magnitude for f=0.45 (shifted)');
    subplot(338); imshow(fftshift((angle(fft_img2)+3.14)/6.28),[]); title('FFT Phase for f=0.45 (shifted)');
  
% interpolators of zero-order and bicubic of these two images:

 figure;
near1=imresize(F1,8,'nearest');
near2=imresize(F2,8,'nearest');
bicub1=imresize(F1,8,'bicubic');
bicub2=imresize(F2,8,'bicubic');
subplot(2,2,1), imshow (uint8(near1));title ('interpolates F1 by a factor 8 & method nearest');
subplot(2,2,2), imshow (uint8(near2));title ('interpolates F2 by a factor 8 & method nearest');
subplot(2,2,3), imshow (uint8(bicub1));title ('interpolates F1 by a factor 8 & method bicubic');
subplot(2,2,4), imshow (uint8(bicub2));title ('interpolates F2 by a factor 8 & method bicubic');

% The DFT Of Images:

figure;
fft_n1 = fft2(near1);
fft_n2 = fft2(near2);
fft_b1 = fft2(bicub1); 
fft_b2 = fft2(bicub2);
    subplot(331); imshow(fftshift(log10(abs(fft_n1))),[]); title('FFT log Magnitude for f=0.03 & nearest');
    subplot(332); imshow(fftshift((angle(fft_n1)+3.14)/6.28),[]); title('FFT Phase for f=0.03 & nearest');
    subplot(333); imshow(fftshift(log10(abs(fft_n2))),[]); title('FFT log Magnitude for f=0.45 & nearest');
    subplot(334); imshow(fftshift((angle(fft_n2)+3.14)/6.28),[]); title('FFT Phase for f=0.45 & nearest');
    subplot(335); imshow(fftshift(log10(abs(fft_b1))),[]); title('FFT log Magnitude for f=0.45 & bicubic');
    subplot(336); imshow(fftshift((angle(fft_b1)+3.14)/6.28),[]); title('FFT Phase for f=0.03 & bicubic');
    subplot(337); imshow(fftshift(log10(abs(fft_b2))),[]); title('FFT log Magnitude for f=0.45 & bicubic');
    subplot(338); imshow(fftshift((angle(fft_b2)+3.14)/6.28),[]); title('FFT Phase for f=0.45 & bicubic');
 
    


    
