%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[P1P2_saved, P2P3_saved, P3P1_saved, Normal_normalized, P1P2_length, P2P3_length, P3P1_length, Area, alpha, beta, gamma, angles_sum, angles_max, angles_min, angles_avg] = Triangles()
%% General Hints:
% If you want to check your implementation you can:
% -) Set a breakpoint to access variables at a certain point in the 
% script. You can inspect their contents in the 'Workspace' window
% (The 'Workspace' window is usually on the right side of Matlab. 
%  If it is hidden, you can open it in the menu: Home/Environment/Layout/Show/Workspace).
% -) Leave out the ';' at the end of a statement/line so the result will be
% printed out idisp(v1)n the command window.
% -) Do not rename the predefined variables, or else our test-system won't
% work (which is bad for both parties ;) )
%% I. Triangles
%% 1) Construct 3 Vectors representing 3 Points that define a triangle.
% Create the points P1, P2 and P3 with the following coordinates
% P1 =
%      1+G      -(1+B)      -(1+C)
% P2 =
%      -(1+E)   -(1+A)      1+F
% P3 =
%      -(1+D)   1+C         -(1+B)
% Where A,B,C,D,E,F,G are digits of your matriculation number in the following order:
% matriculation number: 'ABCDEFG'
%                        1634068
A = 1;
B = 6;
C = 3;
D = 4;
E = 0;
F = 6;
G = 8;
P1 = [(1+G);-(1+B);-(1+C)];
P2 = [-(1+E);-(1+A);(1+F)];
P3 = [-(1+D);1+C;-(1+B)];

%% 2) Construct the 3 vectors of the triangle: P1P2, P2P3 and P3P1
% P1P2 is pointing from P1 to P2
% P2P3 is pointing from P2 to P3
% P3P1 is pointing from P3 to P1

P1P2 = P2 - P1; % TODO: edit this
P2P3 = P3 - P2; % TODO: edit this
P3P1 = P1 - P3; % TODO: edit this

% your results are saved for later evaluation:
P1P2_saved = P1P2; % DON'T OVERRIDE P1P2_saved !!!
P2P3_saved = P2P3; % DON'T OVERRIDE P2P3_saved !!!
P3P1_saved = P3P1; % DON'T OVERRIDE P3P1_saved !!!

%% 3) Calculate the length of each edge
% The positive length or magnitude of a vector is also known as the euclidian 
% 'norm' of this vector. 
% ATTENTION: you are not allowed to use the function 'norm' for this task,
% but you can compare the results of your calculation with the results you
% get by using the built-in Matlab function 'norm'.

P1P2_length = sqrt(P1P2(1) * P1P2(1) + P1P2(2) * P1P2(2) + P1P2(3) * P1P2(3));
P2P3_length = sqrt(P2P3(1) * P2P3(1) + P2P3(2) * P2P3(2) + P2P3(3) * P2P3(3));
P3P1_length = sqrt(P3P1(1) * P3P1(1) + P3P1(2) * P3P1(2) + P3P1(3) * P3P1(3));

% 4) Compute the face normal of the triangle
% You can use the functions from MatlabBasics.m
% equivalents(e.g. cross, dot, norm, etc.).
% normalize the normal!
% 
% A surface normal for a triangle can be calculated by taking the vector
% cross product of two edges of that triangle.
% The order of the vertices used in the calculation will affect the direction
% of the normal (in or out of the face w.r.t. winding).
%
% So for a triangle p1, p2, p3, if the vector U = p2 - p1 and the vector
% V = p3 - p1 then the normal N = U X V and can be calculated by:
%   Nx = UyVz - UzVy
%   Ny = UzVx - UxVz
%   Nz = UxVy - UyVx

Normal = cross(P1P2, P3P1);
Normal_normalized = norm(Normal); % TODO: normalize it!

%% 5) Compute the Area of your triangle
% You can use functions you have programmed until now or their Matlab
% equivalents(e.g. cross, dot, norm, etc.).
% Beware of the direction of your vectors!

Area = norm(cross(P1P2, P1 + P3)) / 2;

%% 6) Calculate the 3 angles of your triangle (in degrees)
% Name them 'alpha' at P1, 'beta' at P2 and 'gamma' at P3
% Beware of the direction and length of your vectors!
% You may use built-in Matlab functions.
% Use the matlab function 'acosd' to get the arccosine in degrees.
% Check your solution: Does the sum of your angles add up to the right amount?
% Save the exact sum of the three angles to 'angles_sum'.
% Save the maximum of the three angles to 'angles_max'.
% Save the minimum of the three angles to 'angles_min'.
% Save the arithmetic mean of the three angles to 'angles_avg' (Check the
% command 'mean)

% https://de.mathworks.com/matlabcentral/newsreader/view_thread/164569



alpha = acosd((P3P1_length^2 + P2P3_length^2 - P1P2_length^2)/(2*P3P1_length*P2P3_length));
beta = acosd((P1P2_length^2 + P2P3_length^2 - P3P1_length^2)/(2*P1P2_length*P2P3_length));
gamma = acosd((P1P2_length^2 + P3P1_length^2 - P2P3_length^2)/(2*P1P2_length*P3P1_length));

% check the sum
angles_sum = alpha + beta + gamma;
angles_max = max([alpha beta gamma]);
angles_min = min([alpha beta gamma]);
angles_avg = mean([alpha beta gamma]);



end
