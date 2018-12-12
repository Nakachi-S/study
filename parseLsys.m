function [Lsystem,N] = parseLsys(system,M)
%parseLsys
%
%   This function ask the user to input a string and a number.
%   It also check for invalid input.
%   [Lsystem,N] = parseLsys(system,M)
%
%   INPUT  
%   - system:       A string (which L-system)
%   - M:            An integer (number of iteration)
%
%   OUTPUT
%   - Lsystem:      The choosen L-system
%   - N:            The choosen number of iteration
%
    optLsys = {'derive_tree_v1(suggested iteration: 1..5)',...
                'notavailable', 'notavailable'};

    % print L-system options
    while true
        printOpt(optLsys);
        whichSys = input('Please enter a valid L-system: ', 's');
        whichSys = str2double(whichSys);
        if (whichSys==1)
            Lsystem = 'derive_tree_v1';
            break;
        elseif (whichSys==5)
            Lsystem = system;
            N = M;
            fprintf(2,'Back to main options.\n');
            return;
        else
            fprintf(2,'WARNING: Unknown/invalid option. Please try again.\n');
        end
    end
    
    while true
        N = input('Please enter a reasonable number of iterations (1-5): ', 's');
        N = str2double(N);
        if isnan(N)
            fprintf(2,'WARNING: invalid input. Please try again.\n');
        elseif N>=0 && N<6
            break;
        elseif N>=6 && N<=25
            fprintf(2,'WARNING: Be aware of computational time!\n');
            break;
        else 
            fprintf(2,'WARNING: number of iteration too big.\nPlease consider to choose a reasonable number of iteration.\n');
        end
    end
    
end