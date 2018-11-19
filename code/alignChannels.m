function [im, predShift] = alignChannels(im, maxShift)
% Implement this
im = im;
red = im(:, :, 1);
green = im(:, :, 2);
blue = im(:, :, 3);

predShift = zeros(2,2);

min = inf;
for m = -15:15
    for n = -15:15
        temp = sum(sum((red - circshift(green, [m n])).^2));
        if temp < min
            min = temp;
            predShift(1) = m;
            predShift(3) = n;
        end
    end
end
green = circshift(green, [predShift(1) predShift(3)]);
min = inf;
for m = -15:15
    for n = -15:15
        temp = sum(sum((red - circshift(blue, [m n])).^2));
        if temp < min
            min = temp;
            predShift(2) = m;
            predShift(4) = n;
        end
    end
end
blue = circshift(blue, [predShift(2) predShift(4)]);

im = cat(3, green, red, blue);
% figure
% imshow(im)
end