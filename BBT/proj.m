clc
image=imread('bbt1.jpg')    
%Split into RGB Channels
Red = image(:,:,1);
Green = image(:,:,2);
Blue = image(:,:,3);
%Get histValues for each channel
r= imhist(Red);
g= imhist(Green);
b = imhist(Blue);
%Make a single vector
h=[r;g;b]
subplot (2,1,1),bar(h,'histc');
subplot(2,1,2),imshow(image)

 
    
