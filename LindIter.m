function [LindernmayerString,len] = LindIter(system, N)
%LindIter
%   
%   The function calculates N iterations of the system specified by 
%   system according to the replacement rules for the Koch curve 
%   Sierpinski triangle, Koch curve (version 002) 
%   and dragon curve respectively.
%   For each system, a specific function is called.
%
%   [LindernmayerString,len] = LindIter(system, N)
%
%   INPUT
%   - system:       string, which L-system
%   - N:            Number of Iteration
%
%   OUTPUT
%   - LindernmayerString:     A string of symbols representing 
%                             the state of the system after 
%                             the Lindemayer iteration
%   - len:                    ratio
%

    if (strcmpi(system,'derive_tree_v1'))
        [LindernmayerString,len] = derive_string_v1(N);
    else
        fprintf(2,'Error!\n');
    end
end