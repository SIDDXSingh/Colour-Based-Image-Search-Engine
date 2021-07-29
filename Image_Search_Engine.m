%pls do add the path of the images before Executing
clc
disp("Enter the input Image");
[InpFile,InpPath]=uigetfile('*.jpg')%To get the Query Image
addpath(InpPath)
InpImage=imread(InpFile)%Stores the Query Image
[HInp,HInpR,HInpG,HInpB]=Hist(InpImage)%Storing Feature vectors of Query Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Enter the folder for searching the query image')
InpDirPath=uigetdir 
addpath(InpDirPath)
cd(InpDirPath)
Imgfile=dir ('*.jpg')  %Contains Data of all the Image File in Given Folder
n=numel(Imgfile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1     %Count variable to store data in array q
q=[]    %to store the indices of the Matching Images
for i=1:n
    if(convertCharsToStrings(Imgfile(i).name)==convertCharsToStrings(InpFile))
        continue
    else
    [HQuery,HQueryR,HQueryG,HQueryB]=Hist(imread(Imgfile(i).name))
    r=bhattacharyya(HInpR,HQueryR)
    g=bhattacharyya(HInpG,HQueryG)
    b=bhattacharyya(HInpB,HQueryB)
    avgDist=(r+g+b)/3
        if(avgDist<=0.022)
            q(j)=i
            j=j+1
        end
    end
end
if(length(q)==0)
 clc
 disp("Sorry No Matching Image Found")
else    
l=length(q)+1  %number of rows for subplot
subplot(l,1,1)
imshow(InpImage)
title('Query Image')
    for i=1:length(q)
    subplot(l,1,i+1)
    imshow(imread(Imgfile(q(i)).name))
    title(strcat('Output Image',num2str(i)))
    end  
end

%Function For Feature Extraction
function [h,r1,g1,b1]=Hist(image) 
%Split into RGB Channels
Red = image(:,:,1);
Green = image(:,:,2);
Blue = image(:,:,3);
%Get histValues for each channel
r= imhist(Red);
g= imhist(Green);
b = imhist(Blue);
%Make a single vector
h=[r,g,b]
r1=r
g1=g
b1=b
end
%Function to calculate Bhattacharyya Distance between two vectors
function d=bhattacharyya(X1,X2)
% BHATTACHARYYA  Bhattacharyya distance between two Gaussian classes
%
% d = bhattacharyya(X1,X2) returns the Bhattacharyya distance between X1 and X2.
%
% Inputs: X1 and X2 are n x m matrices represent two sets which have n
%         samples and m variables.
%
% Output: d is the Bhattacharyya distance between these two sets of data.
%
% Example:
%{
N=100;
M=10;
e1=2;
e2=5;
c1=3;
c2=7;
X1 = c1*randn(N,M)+e1;
X2 = c2*randn(N,M)+e2;
d = bhattacharyya(X1,X2);
%}

error(nargchk(2,2,nargin));
error(nargoutchk(0,1,nargout));
[n,m]=size(X1);
% check dimension 
% assert(isequal(size(X2),[n m]),'Dimension of X1 and X2 mismatch.');
assert(size(X2,2)==m,'Dimension of X1 and X2 mismatch.');
mu1=mean(X1);
C1=cov(X1);%to find covariancr of X2
mu2=mean(X2);
C2=cov(X2);%to find covariancr of X2
C=(C1+C2)/2;
dmu=(mu1-mu2)/chol(C);
try
    d=0.125*dmu*dmu'+0.5*log(det(C/chol(C1*C2)));
catch
    d=0.125*dmu*dmu'+0.5*log(abs(det(C/sqrtm(C1*C2))));
    warning('MATLAB:divideByZero','Data are almost linear dependent. The results may not be accurate.');
end
% d=0.125*dmu*dmu'+0.25*log(det((C1+C2)/2)^2/(det(C1)*det(C2)));
end
