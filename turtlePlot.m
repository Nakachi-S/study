function turtlePlot(turtleCommands,system,N)
%turtleGraph
%   
%   turtleCommandsをプロットする関数。
%   turtleCommandsの仕様は[仰角、方位角、長さ、仰角、方位角、長さ、...] 1*nのベクトルである
%   ゆくゆくは[仰角、方位角、長さ、オプション] 4*nベクトルで、
%   オプション(0:何でもない、1:葉をつける、2: プロットしない)と設計したい
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
    if v(i) == 0    %なんでも無いとき
        %plot3([x, newX],[y, newY],[z, newZ], 'y');
    elseif v(i) == 1    %幹のとき
        plot3([x, newX],[y, newY],[z, newZ], 'r', 'Linewidth', 5);
    elseif v(i) == 2    %枝のとき
        plot3([x, newX],[y, newY],[z, newZ], 'g', 'Linewidth', 3);
    elseif v(i) == 3    %枝葉のとき
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