img1=imread('md1.jpg')
img2=imread('md3.jpg')
a=Hist(img1)
b=Hist(img2)
R=getCosineSimilarity(a,b)
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

function Cs = getCosineSimilarity(x,y)
% 
% call:
% 
%      Cs = getCosineSimilarity(x,y)
%      
% Compute Cosine Similarity between vectors x and y.
% x and y have to be of same length. The interpretation of 
% cosine similarity is analogous to that of a Pearson Correlation
% 
% R.G. Bettinardi
% -----------------------------------------------------------------
if isvector(x)==0 || isvector(y)==0
    error('x and y have to be vectors!')
end
if length(x)~=length(y)
    error('x and y have to be same length!')
end
xy   = dot(x,y);
nx   = norm(x);
ny   = norm(y);
nxny = nx*ny;
Cs   = xy/nxny;
end