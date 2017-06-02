%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[image_swapped, image_mark_green, image_masked, image_reshaped, image_convoluted, image_edge] = Images()

%% Initialization. Do not change anything here
input_path = 'lena_color.jpg';
output_path = 'lena_output.png';

image_swapped = [];
image_mark_green = [];
image_masked = [];
image_reshaped = [];
image_edge = [];


%% I. Images basics
% 1) Load image from 'input_path'
I = imread(input_path);
% 2) Convert the image from 1) to double format with range [0, 1]. DO NOT USE LOOPS.
D = im2double(I);

% 3) Use the image from 2) to create an image where the red and the green channel
% are swapped. The result should be stored in image_swapped. DO NOT USE LOOPS.

image_swapped(:, :, 1) = D(:, :, 2);
image_swapped(:, :, 2) = D(:, :, 1);
image_swapped(:, :, 3) = D(:, :, 3);


% 4) Display the swapped image

imshow(image_swapped);

% 5) Write the swapped image to the path specified in output_path. The
% image should be in png format.

imwrite(image_swapped,output_path);

% 6) Create logical image where every pixel is marked that has a green channel
% which is greater or equal 0.7. The result should be stored in image_mark_green. 
% Use the image from step 2 for this step.
% DO NOT USE LOOPS.
% HINT:
% see http://de.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html).

image_mark_green = D(:, :, 2) >= 0.7;

% 7) Set all pixels in the original image (the double image from step 2) to black where image_mark_green is
% true (where green >= 0.7). Store the result in image_masked. 
% You can use 'repmat' to complete this task. DO NOT USE LOOPS. 
image_masked(:, :, 1) = D(:, :, 1) - image_mark_green;
image_masked(:, :, 2) = D(:, :, 2) - image_mark_green;
image_masked(:, :, 3) = D(:, :, 3) - image_mark_green;

% 8) Convert the original image (the double image from step 2) to a grayscale image and reshape it from
% 512x512 to 1024x256. Cut off the right half of the image and attach it to the bottom of the left half.
% The result should be stored in 'image_reshaped' DO NOT USE LOOPS.
% (Hint: Matlab adresses matrices with "height x width")

GS = rgb2gray(D);
RS_left = GS(:, 1:256);
RS_right =  GS(:,257:512);
image_reshaped = [RS_left; RS_right];
% imshow(image_reshaped);



%% II. Filters and convolutions

% 1) Use fspecial to create a 5x5 gaussian filter with sigma=2.0
gauss_kernel = fspecial('gaussian',[5 5],2);

% 2) Implement the evc_filter function. You are allowed to use loops for
% this task. You can assume that the kernel is always of size 5x5.
% For pixels outside the image use 0. 
% Do not use the conv or the imfilter or similar functions here. The result should be
% stored in image_convoluted
% The output image should have the same size as the input image.
image_convoluted = evc_filter(image_swapped, gauss_kernel);
%figure, imshow(image_swapped), figure, imshow(image_convoluted), figure, imshow(imfilter(image_swapped, gauss_kernel));

% 3) Create a image showing the horizontal edges in image_reshaped using the sobel filter.
% For this task you can use imfilter/conv.
% Attention: Do not use evc_filter for this task!
% The result should be stored in image_edge. DO NOT USE LOOPS.
% The output image should have the same size as the input image.
% For this task it is your choice how you handle pixels outside the
% image, but you should use a typical method to do this.
sobel_kernel = fspecial('sobel');
image_edge = imfilter(image_reshaped, sobel_kernel, 'replicate');
%figure, imshow(image_edge);

end

% Returns the input image filtered with the kernel
% input: An rgb-image
% kernel: The filter kernel
function [result] = evc_filter(input, kernel)
    [height, width, channels] = size(input);
    result = input;

    [kernel_width, kernel_height] = size(kernel);

    border_x = ceil(kernel_width / 2);
    border_y = ceil(kernel_height / 2);
    offset_x = floor(kernel_width / 2);
    offset_y = floor(kernel_height / 2);

    % process for all 3 color channels
    for channel = 1:channels
        % 2 and -2 because we will leave the border untouched
        for x = border_x:height-border_x
            for y = border_y:width-border_y
                pixels = input(x-offset_x:x+offset_x, y-offset_y:y+offset_y, channel);
                value = 0;
                for idx = 1:numel(pixels)
                    value = value + pixels(idx) * kernel(idx);
                end
                result(x, y, channel) = value;
            end
        end
    end
end
