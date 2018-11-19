function output = demosaicImage(im, method)
% DEMOSAICIMAGE computes the color image from mosaiced input
%   OUTPUT = DEMOSAICIMAGE(IM, METHOD) computes a demosaiced OUTPUT from
%   the input IM. Various interpolation METHOD can be used such as
%   'baseline', 'nn' 
%
% Author: Subhransu Maji
% Copyright 2014 

switch lower(method)
    case 'baseline'
        output = demosaicBaseline(im);
    case 'nn'
        output = demosaicNN(im);         % Implement this
end

%--------------------------------------------------------------------------
%                          Baseline demosacing algorithm. 
%                          The algorithm replaces missing values with the
%                          mean of each color channel.
%--------------------------------------------------------------------------
function mosim = demosaicBaseline(im)
mosim = repmat(im, [1 1 3]); % Create an image by stacking the input
[imageHeight, imageWidth] = size(im);

% Red channel (odd rows and columns);
redValues = im(1:2:imageHeight, 1:2:imageWidth);
meanValue = mean(mean(redValues));
mosim(:,:,1) = meanValue;
mosim(1:2:imageHeight, 1:2:imageWidth,1) = im(1:2:imageHeight, 1:2:imageWidth);

% Blue channel (even rows and colums);
blueValues = im(2:2:imageHeight, 2:2:imageWidth);
meanValue = mean(mean(blueValues));
mosim(:,:,3) = meanValue;
mosim(2:2:imageHeight, 2:2:imageWidth,3) = im(2:2:imageHeight, 2:2:imageWidth);

% Green channel (remaining places)
% We will first create a mask for the green pixels (+1 green, -1 not green)
mask = ones(imageHeight, imageWidth);
mask(1:2:imageHeight, 1:2:imageWidth) = -1;
mask(2:2:imageHeight, 2:2:imageWidth) = -1;
greenValues = mosim(mask > 0);
meanValue = mean(greenValues);
% For the green pixels we copy the value
greenChannel = im;
greenChannel(mask < 0) = meanValue;
mosim(:,:,2) = greenChannel;

function mosim = demosaicNN(im)

red = im(:, :, 1);
for m = 1:imageHeight
    for n = 1:imageWidth
        if mod(m, 2) == 1
            if mod(n, 2) == 0
                red(m, n) = red(m, n-1);
            end
        end
        if mod(m, 2) == 0
            red(m, n) = red(m-1, n);
        end
    end
end
green = im(:, :, 2);
for m = 1:imageHeight
    for n = 1:imageWidth
        if mod(m, 2) == 1
            if mod(n, 2) == 1
                if n > 1
                    green(m, n) = green(m, n-1);
                end
                if n == 1
                    if m == 1
                        green(m, n) = green(m+1, n);
                    end
                    if m > 1
                        green(m, n) = green(m-1, n);
                    end
                end
            end
        end
        if mod(m, 2) == 0
            if mod(n, 2) == 0
                green(m, n) = green(m, n-1);
            end
        end
    end
end
blue = im(:, :, 3);
for m = 1:imageHeight
    for n = 1:imageWidth
        if n == 1
            if m == 1
                blue(m, n) = blue(2, 2);    
            end
            if m > 1
                blue(m, n) = blue(m - mod(m, 2), 2);
            end
        end
        if n > 1
            if m == 1
                blue(m, n) = blue(2, n - mod(m, 2));
            end
            if m > 1
                blue(m, n) = blue(m - mod(m, 2), n - mod(m, 2));
            end     
        end
    end
end
im = cat(3, green, red, blue);
mosim = im; %replace this with your implementation
