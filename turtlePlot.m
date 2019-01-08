function turtlePlot(turtleCommands,system,N)
%turtleGraph
%   
%   turtleCommands���v���b�g����֐��B
%   turtleCommands�̎d�l��[�p�A���ʊp�A�����A�p�A���ʊp�A�����A...] 1*n�̃x�N�g���ł���
%   �䂭�䂭��[�p�A���ʊp�A�����A�I�v�V����] 4*n�x�N�g���ŁA
%   �I�v�V����(0:���ł��Ȃ��A1:�t������A2: �v���b�g���Ȃ�)�Ɛ݌v������
%
%
%   turtleCommands = turtleGraph(LindenmayerString,system,len)
%
%   INPUT
%   - turtleCommands:           A row vector consisting of alternating 
%                               length and angle specifications
%
%   - system:                   A string telling which L-system.
%   - len:                      Ratio. Scaling the length of line
%
close all; 
x = 0; y = 0; z = 0;
i = 4;
v = turtleCommands;
figure(1)
xlim([0 5]);
while i<=length(v)
    [nextX, nextY, nextZ] = sph2cart(v(i-3), v(i-2), v(i-1));
    newX = x + nextX;
    newY = y + nextY;
    newZ = z + nextZ;
    %line([x(1), newX(1)],[x(2), newX(2)],'color',[0 0 1], 'linewidth',2);
    if v(i) == 0    %�Ȃ�ł������Ƃ�
        %plot3([x, newX],[y, newY],[z, newZ], 'y');
    elseif v(i) == 1    %���̂Ƃ�
        plot3([x, newX],[y, newY],[z, newZ], 'r', 'Linewidth', 5);
    elseif v(i) == 2    %�}�̂Ƃ�
        plot3([x, newX],[y, newY],[z, newZ], 'g', 'Linewidth', 3);
    elseif v(i) == 3    %�}�t�̂Ƃ�
        plot3([x, newX],[y, newY],[z, newZ], 'b');
    end
    hold on
    x = newX; y = newY; z = newZ;
    i = i+4;
end
ax = gca;
ax.FontSize = 16;
title(system)
xlabel(['x:Number of Iterations: ', num2str(N)]);
ylabel('y');
zlabel('z');
end