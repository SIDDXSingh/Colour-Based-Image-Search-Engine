clc
disp("Enter the input Image");
InpPath=uigetfile('*.jpg')
InpImage=imread(InpPath)
HistInp=Hist(InpImage)
disp('Enter the folder for searching the query image')
InpDirPath=uigetdir 
cd(InpDirPath)
Imgfile=dir ('*.jpg')
n=numel(Imgfile)
q=[]
for i=1:n
   l=Hist(imread(Imgfile(i).name))
   res=chi(HistInp,l,(length(l)-1))
   if res >= 0.5
       q(i)=i
   end
end
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
function x = chi(o,e,k)
z=(o-e).*(o-e)
z=z./e
Prob=sum(z)
x=1-chi2cdf(Prob,k)
end