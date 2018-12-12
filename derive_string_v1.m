function [LMstring,len] = derive_string_v1(N)
%derive_string_v1
%   
%   This function computes the Lindenmayer string (symbols) 
%   based on some pre-defined rules and N iteration,
%   in order to display Any character string.
%   [LMstring,len] = derive_string_v1(N)
%
%   INPUT  
%   - N:            Number of Iteration
%
%   OUTPUT
%   - LMsystem:     A string of symbols representing 
%                   the state of the system after 
%                   the Lindemayer iteration
%   - len:          ratio
%
rule(1).before = 'A';
rule(1).after = 'LBC';

rule(2).before = 'B';
rule(2).after = '[S]';

rule(3).before = 'C';
rule(3).after = 'A';

rule(4).before = 'D';
rule(4).after = 'M[A]D';

nRules = length(rule);

%starting seed ‰Šú•¶Žš—ñ
axiom = 'M[A]D';

%number of repititions
nReps = N;

len = 1;
ratio = 1/3;

for i=1:nReps
    len = len*ratio;
    
    %one character/cell, with indexes the same as original axiom string
    axiomINcells = cellstr(axiom'); 
    
    for j=1:nRules
        %the indexes of each 'before' string
        hit = strfind(axiom, rule(j).before);
        if (length(hit)>=1)
            for k=hit
                axiomINcells{k} = rule(j).after;
            end
        end
    end
    %now convert individual cells back to a string
    axiom=[];
    for j=1:length(axiomINcells)
        axiom = [axiom, axiomINcells{j}];
    end
end
LMstring = axiom;
end

