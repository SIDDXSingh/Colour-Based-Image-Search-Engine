clc
disp("Enter the input Image");
InpPath=uigetfile('*.jpg')
InpImage=imread(InpPath)
HistInp=Hist(InpImage)
disp('Enter the folder for searching the query image')
InpDirPath=uigetdir 
cd(InpDirPath)
Imgfile=dir ('*.jpg')
a=Hist(imread(Imgfile(1).name))
retval=chi(a-HistInp,767)

function h =Hist(image)    
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
end
function x = chi(d,k)
Prob=(sum(d)*sum(d))/e
x=1-chi2cdf(Prob,k)
end