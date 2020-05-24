clc
image=imread('bbt1.jpg')    
%Split into RGB Channels
    Red = image(:,:,1);
    Green = image(:,:,2);
    Blue = image(:,:,3);
    subplot(1,2,1),imshow(Red)