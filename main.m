%% Introduction to Programming and Data Processing
% Exam project
% Project 2D - Lindenmayer systems
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

optLsys = 1;
optPlots = 2;
optQuit = 3;
optListCmd = 4;

mainOpt = {'Choose the type of Lindenmayer system and the number of iterations',...
    'Generate plots',...
    'Quit',...
    'Print options'};

% Welcoming...
fprintf('************************************ \n');
fprintf('** ');
fprintf(2,'\tLindenmayer systems       ');
fprintf('**\n');
fprintf('************************************ \n');
fprintf('** A program to compute L-system  ** \n');
fprintf('************************************ \n');
fprintf('To select an option, please enter \nthe corresponding number of \nthat option. ');
fprintf('You can choose one \nof the following options: \n');
printOpt(mainOpt);

system = 'None';
N = -1;

% check which option
while true
    fprintf('------------------- Infos --------------------\n');
    fprintf(2,'L-system: %s\n',system);
    fprintf(2,'N-of-iterations: %d\n',N);
    fprintf('----------------------------------------------\n');
    % ask user for input
    fprintf('Main options > ');
    cmd = input('Please enter an option: ', 's');
    dcmd = str2double(cmd);
    % if is a double
    if ~isnan(dcmd) && isa(dcmd,'double')
        % option 3 - Quit
        if dcmd == optQuit
            fprintf(2,'> Quit.\n');
            % clear all; close all;
            break;
        % option 1 - Choose the type of Lindenmayer system and the number of iterations
        elseif dcmd == optLsys
            fprintf('Option 1: ');
            % check if input string is valid
            [system,N] = parseLsys(system,N);
            if ~isempty(system) && N>=0
                fprintf('Computing... ');
                [LindenmayerString,len] = LindIter(system,N);
                %Ç±Ç±Ç…ê∂ê¨Ç≥ÇÍÇΩï∂éöóÒÇégÇ¡ÇΩ3d spaceÇ…ïœä∑â¬î\Ç»
                %âΩÇ©ÇµÇÁÇÃä÷êîèàóùÇÅB
                turtleCommands = turtleGraph(LindenmayerString,system,len);
                fprintf('done!\n');
            end
        % option 2 - Generate plots
        elseif dcmd == optPlots
            fprintf('Option 2: Generating plot... ');
            if ((exist('LindenmayerString','var')==1) && ~isempty(LindenmayerString))
                turtlePlot(turtleCommands,system,N);
                fprintf('done!\n');
            else
                fprintf(2,'\nWARNING: No data found.\nPlease choose L-system and N iterations first.\n');
            end
        % options 4 - list options
        elseif dcmd == optListCmd
            fprintf('Available options: \n');
            printOpt(mainOpt);
        % otherwise try again
        else
            fprintf(2,'Unknown option "%s". Please choose a valid option.\n', cmd);
            fprintf(2,'To select an option, please enter the corresponding\nnumber (1..%d) of that option.\n', length(mainOpt));
            printOpt(mainOpt);
        end
    % if it is not a string
    else
        fprintf(2,'Unknown option "%s". Please choose a valid option.\n', cmd);
        fprintf(2,'To select an option, please enter the corresponding\nnumber (1..%d) of that option.\n', length(mainOpt));
        printOpt(mainOpt);
    end
end    