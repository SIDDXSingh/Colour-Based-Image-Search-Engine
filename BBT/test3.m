 rgbImage=imread('bbt1.jpg')    
 rgbImage = imresize(rgbImage, [256 256]);
figure
imshow(rgbImage);
[rows, columns, numberOfColorChannels] = size(rgbImage);
hsvImage = rgb2hsv(rgbImage); % Ranges from 0 to 1.
hsvHist = zeros(16,4,4);
for col = 1 : columns
    for row = 1 : rows
        hBin = floor(hsvImage(row, col, 1) * 15.9999)+ 1;
        sBin = floor(hsvImage(row, col, 2) * 3.9999)+ 1;
        vBin = floor(hsvImage(row, col, 3) * 3.9999)+ 1;
        hsvHist(hBin, sBin, vBin) = hsvHist(hBin, sBin, vBin) + 1;
    end
end
