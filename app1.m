
clc;
clear;
close all;
f1=.01;
f2=.48;
 m=1:256;
  n=1:256;
        F1=128+127*cos(2*pi*f1*m')*cos(2*pi*f1*n);
        F2=128+127*cos(2*pi*f2*m')*cos(2*pi*f2*n);
subplot(1,2,1), imshow (uint8(F1),[]);title ('f=.01')
subplot(1,2,2), imshow (uint8(F2),[]);title ('f=.48')
 fft_img1 = fft2(F1);
  fft_img2 = fft2(F2);
    subplot(331); imshow(uint8(F1),[]); title(' original Image with f=.01');  
    subplot(332); imshow(log10(abs(fft_img1)),[]); title('FFT log Magnitude for f=.01 (not shifted)');
    subplot(333); imshow(fftshift(log10(abs(fft_img1))),[]); title('FFT log Magnitude for f=.01 (shifted)');
    subplot(334); imshow(fftshift((angle(fft_img1)+3.14)/6.28),[]); title('FFT Phase for f=.01 (shifted)');
    