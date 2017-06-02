%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[v1, v2, v3, M, M_9x15, v_M_Product, M_v_Product, M_M_Product, M_M_componentwise, crossP, dotP] = MatlabBasics()
%% General Hints:
% If you want to check your implementation you can:
% -) Set a breakpoint to access variables at a certain point in the 
% script. You can inspect their contents in the 'Workspace' window
% (The 'Workspace' window is usually on the right side of Matlab. 
%  If it is hidden, you can open it in the menu: Home/Environment/Layout/Show/Workspace).
% -) Leave out the ';' at the end of a statement/line so the result will be
% printed out in the command window.
% -) Do not rename the predefined variables, or else our test-system won't
% work (which is bad for both parties ;) )
%% I. create basic data structures:
% 1) create a Row Vector 'v1' and a Column Vector 'v2' with 3 Elements and a 3by3 Matrix 'M' 
% containing digits of your matriculation number in the following order:
% matriculation number: 'ABCDEFG'
% Vector: 
% v1 =
%      F     B     E  
% v2 = 
%      G
%      C
%      D
% Matrix:
% M = 
%      C     B     G
%      F     D     B
%      E     C     A

v1 = [6 6 0];
v2 = [8; 3; 4];
M = [3 6 8; 6 4 6; 0 3 1];

% 2) create a sequence: create a Vector 'v3' with elements starting at the
% smallest digit of M to the largest, each element 0.2 greater than the one
% before. Use the sequence operator ':' and Matlab's
% min/max functions to accomplish this.
% !Use the matrix M for this task and not the same numbers as in M!
% Example: The matriculation number 1210233 should give you the following vector:
% v3 =
%       0  0.2  0.4  0.6  0.8  1  1.2  1.4  1.6  1.8  2  2.2  2.4  2.6  2.8  3
% for more information on how to use the sequence operator ':' (as well as 
% all other Matlab functions), type (in the matlab commandline):
% help :

v3 = min(min(M)):0.2:max(max(M));

% 3) create a 9-by-15 Matrix 'M_9x15' containing a checkerboard pattern of 
% tiles where each black tile contains the contents of matrix M and 
% every white tile contains zeros. Each tile, black or white, has the size 3x3.
% The corners must be white (i.e. contain 3x3 matrices out of zero).
% ( You have to accomplish this task using a maximum of 7
% assignment-commands.
% Commands that use the = operator for assignment (not comparison) are
% counted as assignment-commands.
% You have to reuse M and you must not use loops.
% For more information see 
% http://de.mathworks.com/help/matlab/matrices-and-arrays.html
% and
% http://de.mathworks.com/help/matlab/math/matrix-indexing.html
% and have a look at the zeros-command:
% help zeros

% M_9x15 =
%   000 CBG 000 CBG 000
%   000 FDB 000 FDB 000
%   000 ECA 000 ECA 000
%   CBG 000 CBG 000 CBG
%   FDB 000 FDB 000 FDB
%   ECA 000 ECA 000 ECA
%   000 CBG 000 CBG 000
%   000 FDB 000 FDB 000
%   000 ECA 000 ECA 000

Z = zeros(3);
M_9x15 = [Z M Z M Z; M Z M Z M; Z M Z M Z];

%% II. implement your own versions of the following built-in Matlab functions:
% *, .*, cross, dot

% ATTENTION: of course you are not allowed to use the function 'cross' or
% 'dot' as well as '.*' for this task. Furthermore you may only use 
% the '*' operator on single components (-> multiply one element of a 
% matrix or a vector with one other element). You may (and will probably)
% use loops.

% Hint: In order to check your solution, you can compare your results with
% the results you get by using the built-in Matlab functions.

% 1) Vector-Matrix-Multiplication (use v1 and M)
v_M_Product = vector_X_Matrix(v1, M);

% 2) Matrix-Vector-Multiplication (use M and v2)

M_v_Product = Matrix_X_vector(M, v2);

% 3) Matrix-Matrix-Multiplication 
% (use M and the transposed Matrix M2) 
M2 = M';
M_M_Product = Matrix_X_Matrix(M, M2);

% 4) Matrix-Matrix-Multiplication component wise
% (use M and M2 and implement component wise matrix multiplication)
M_M_componentwise = Matrix_Xc_Matrix(M, M2);

% 5) cross product of 2 vectors (use v1 and v2)
crossP = crossProduct(v1,v2);

% 6) dot product (use v1 and v2)
dotP = dotProduct(v1,v2);
end

function[result] = vector_X_Matrix(v1, M)
    L = length(v1);
    result = zeros(1, L);
    for hidx = 1:L
        for vidx = 1:L
            result(hidx) = result(hidx) + v1(vidx) * M(vidx, hidx);
        end
    end
end

function[result] = Matrix_X_vector(M, v2)
    L = length(v2);
    result = zeros(L, 1);
    for hidx = 1:L
        for vidx = 1:L
            result(hidx) = result(hidx) + M(hidx, vidx) * v2(vidx);
        end
    end
end 

function[result] = Matrix_X_Matrix(M, M2)
    S1 = size(M);
    S2 = size(M2);
    rows = S1(1);
    cols = S2(2);
    result = zeros(rows, cols);
    for hidx = 1:rows
        for vidx = 1:cols
            for idxM = 1:cols
                result(hidx, vidx) = result(hidx, vidx) + M(hidx, idxM) * M2(idxM, vidx);
            end
        end
    end
end

function[result] = Matrix_Xc_Matrix(M, M2)
    S = size(M);
    result = zeros(S(1), S(2));
    for idx = 1:numel(M)
        result(idx) = M(idx) * M2(idx);
    end
end

function[result] = crossProduct(v1,v2)
    L = length(v1);
    result = zeros(1, L);  
    for idx = 1:numel(v1)
        idx1 = idx + 1;
        if idx1 > L
            idx1 = mod(idx1, L);
        end
        idx2 = idx + 2;
        if idx2 > L
            idx2 = mod(idx2, L);
        end
        result(idx) = v1(idx1) * v2(idx2) - v1(idx2) * v2(idx1);
    end 
end

function[result] = dotProduct(v1,v2)
    result = 0;
    for idx = 1:numel(v1)
        result = result + v1(idx) * v2(idx);
    end
end




