function mosim = mosaicImage(im)
% MOSAICIMAGE computes the mosaic of an image.
%   MOSIM = MOSAICIMAGE(IM) computes the response of the image under a
%   Bayer filter. Given an image IM = NxMx3, the output is a NxM image
%   where the R,G,B channels are sampled according to RGRG on the top left.
%
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 1: Color images

[imageHeight, imageWidth, numChanels] = size(im);
assert(numChanels == 3); % Check that it is a color image
red = im(:, :, 1);
for m = 1:imageHeight
    for n = 1:imageWidth
        if mod(m, 2) == 1
            if mod(n, 2) == 0
                red(m, n) = 0;
            end
        end
        if mod(m, 2) == 0
            red(m, n) = 0;
        end
    end
end
green = im(:, :, 2);
for m = 1:imageHeight
    for n = 1:imageWidth
        if mod(m, 2) == 1
            if mod(n, 2) == 1
                green(m, n) = 0;
            end
        end
        if mod(m, 2) == 0
            if mod(n, 2) == 0
                green(m, n) = 0;
            end
        end
    end
end
blue = im(:, :, 3);
for m = 1:imageHeight
    for n = 1:imageWidth
        if mod(m, 2) == 1
            blue(m, n) = 0;
        end
        if mod(m, 2) == 0
            if mod(n, 2) == 1
                blue(m, n) = 0;
            end
        end
    end
end
im = cat(3, green, red, blue);
mosim = im;