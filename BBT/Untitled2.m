a=imread('md1.jpg')
b=imread('md3.jpg')
f1 = Hist(b)
f2 = Hist(a)
R=getCosineSimilarity(f1,f2)
r1=chi(f1,f2,767)
r3=bhattacharyya(f1,f2)
r4=distChiSq(f1,f2)
r5=Manhattan(f1,f2)
z=1-chi2cdf(r4,767)

function h =Hist(image)    
%Split into RGB Channels
Red = image(:,:,1);
Green = image(:,:,2);
Blue = image(:,:,3);
%Get histValues for each channel
r= imhist(histeq(Red,256));
g= imhist(histeq(Green,256));
b = imhist(histeq(Blue,256));
%Make a single vector
h=[r;g;b]'
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
function x = chi(o,e,k)
z=(o-e).*(o-e)
z=z./e
Prob=sum(z)
x=1-chi2cdf(Prob,k)
end
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
% Reference:
% Kailath, T., The Divergence and Bhattacharyya Distance Measures in Signal
% Selection, IEEE Trasnactions on Communication Technology, Vol. 15, No. 1,
% pp. 52-60, 1967
%
% By Yi Cao at Cranfield University on 8th Feb 2008.
%
%Check inputs and output
error(nargchk(2,2,nargin));
error(nargoutchk(0,1,nargout));
[n,m]=size(X1);
% check dimension 
% assert(isequal(size(X2),[n m]),'Dimension of X1 and X2 mismatch.');
assert(size(X2,2)==m,'Dimension of X1 and X2 mismatch.');
mu1=mean(X1);
C1=cov(X1);
mu2=mean(X2);
C2=cov(X2);
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
function D = distChiSq( X, Y )

%%% supposedly it's possible to implement this without a loop!
m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  yi = Y(i,:);  yiRep = yi( mOnes, : );
  s = yiRep + X;    d = yiRep - X;
  D(:,i) = sum( d.^2 ./ (s+eps), 2 );
end
D = D/2;
end
function D= Manhattan(X,Y)
D=sum(abs(X-Y))
end