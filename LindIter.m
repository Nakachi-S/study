function [LindernmayerString,len] = LindIter(system, N)
%LindIter
%   
%   The function calculates N iterations of the system specified by 
%   system according to the replacement rules for the derive_tree_v1,
%   他のLsystem追加の際、ここに条件分岐を記述。
%   For each system, a specific function is called.
%
%[LindernmayerString,len] = LindIter(system, N)
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

    if (strcmpi(system,'derive_string_v1'))
        [LindernmayerString,len] = derive_string_v1(N);
    else
        fprintf(2,'Error!\n');
    end
end