% Entry code for evaluating demosaicing algorithms
% The code loops over all images and methods, computes the error and
% displays them in a table.
% 
%
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2017
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 1


% Path to your data directory
dataDir = fullfile('..','data','demosaic');

% Path to your output directory
outDir = fullfile('..','output','demosaic');
mkdir(outDir)

% List of images
imageNames = {'balloon.jpeg',	'cat.jpg',	'ip.jpg','puppy.jpg','squirrel.jpg', ...
              'pencils.jpg',	'house.png', 'light.png', 'sails.png', 'tree.jpeg'};
numImages = length(imageNames);

% List of methods you have to implement          
methods = {'baseline', 'nn'}; % add other methods to this list
numMethods = length(methods);

% Global variables
display = false;
error = zeros(numImages, numMethods);

% Loop over methods and print results
fprintf([repmat('-',[1 50]),'\n']); 
fprintf('# \t image \t')
for i = 1:numMethods
    fprintf('\t %s', methods{i});
end
fprintf('\n');

fprintf([repmat('-',[1 50]),'\n']); 
for i = 1:numImages,
    fprintf('%i \t %s ', i, imageNames{i});
    for j = 1:numMethods, 
        thisImage = fullfile(dataDir, imageNames{i});
        thisMethod = methods{j};
        [error(i,j), colorIm] = runDemosaicing(thisImage, thisMethod, display);
        fprintf('\t %f ', error(i,j)); 
        
        % Write the output
        outfileName = fullfile(outDir, [imageNames{i}(1:end-5) '-' thisMethod '-dmsc.jpg']);
        imwrite(colorIm, outfileName);
        
    end
    fprintf('\n');
end

% Compute average errors
fprintf([repmat('-',[1 50]),'\n']); 
fprintf(' \t %s ', 'average');
for j = 1:numMethods, 
        fprintf('\t %f ', mean(error(:,j)));     
end
fprintf('\n');
fprintf([repmat('-',[1 50]),'\n']); 
