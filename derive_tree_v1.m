function plotCommands = derive_tree_v1(LindenmayerString,system,len)
%turtleGraph
%   
%   This function translates the string of symbols in LindenmayerString 
%   into a sequence of turtle graphics commands.
%   turtleCommands = turtleGraph(LindenmayerString,system,len)
%
%   INPUT
%   - LindenmayerString:        A string of symbols representing 
%                               the state of the system after 
%                               the Lindemayer iteration.
%   - system:                   A string telling which L-system.
%   - len:                      Ratio. Scaling the length of line
%
%   OUTPUT
%   - turtleCommands:           A row vector containing the turtle graphics
%                               commands consisting of alternating length 
%                               and angle specifications
%                               [azimuth, elevation, r, opition]
%                               option: 1=���A2=�}�A3=�t�}�A4=�`�悵�Ȃ�
v = [0 0 0 0];
stack = 0;
l = 0;  %�}������o�Ă������H']'�p�@�䂭�䂭�͏���
%�ʂ�L-system����������̏ꍇ�����p
%{
if strcmp(system,'derive_string_v1');
    
end
%}
%���ƕ|�����炱���̓o�b�N�A�b�v�p
%{
for w=1:length(LindenmayerString)
    if LindenmayerString(w)=='M'
        v = [v, 0 pi/2 5];
    elseif LindenmayerString(w)=='A'
        
    elseif LindenmayerString(w)=='L'
        v = [v, pi pi/4 3];
    elseif LindenmayerString(w)=='B'
        
    elseif LindenmayerString(w)=='C'
        
    elseif LindenmayerString(w)=='S'
        v = [v, pi/2 pi/4 2];
    elseif LindenmayerString(w)=='D'
        
    elseif LindenmayerString(w)=='['
        
    elseif LindenmayerString(w)==']'
        
    end
end
%}

for w=1:length(LindenmayerString)
    if stack == 2   %S�̂Ƃ��̂�
        if LindenmayerString(w) == 'S'
            v = [v, pi/3 pi/5 2 3];
        elseif LindenmayerString(w) == ']'
            v = [v, pi/3+pi -pi/5 2 0];
            stack = stack - 1;
        end
    
    elseif stack == 1
        if LindenmayerString(w) == 'L'
            v = [v, pi/2 pi/4 3 2];
            l = l + 1;
        elseif LindenmayerString(w) == '['
            stack = stack + 1;
        elseif LindenmayerString(w) == ']'
            v = [v, -pi/2 -pi/4 3*l 0];
            stack = stack - 1;
            l = 0;
        else
            
        end
    else
        if LindenmayerString(w)=='M'
            v = [v, 0 pi/2 5 1];
        elseif LindenmayerString(w)=='['
            stack = stack + 1;
        elseif LindenmayerString(w)==']'
            
        end
        
    end
end
ratio = len;
indx = [3:4:length(v)];     %3�ڂ�r,�܂蒷���Ƀ��[�g�������Ē���
v(indx) = v(indx) * ratio;
plotCommands = v;
%disp(plotCommands);
end