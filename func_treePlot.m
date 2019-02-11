%   Treeの内容をプロットする関数
%   add_infoで更新されたあとに実行すること
function func_treePlot(Tree, i_no)
%   Tの内容を描画
%disp("Tの長さ"+length(Tree.T))
%assignin('base', 'Tree.T', Tree.T)
%disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
figure(1);


for i = 2:length(Tree.T)
    
    plot3([Tree.T(i-1, 1), Tree.T(i, 1)],[Tree.T(i-1, 2), Tree.T(i, 2)],...
        [Tree.T(i-1, 3), Tree.T(i, 3)], 'g', 'Linewidth', 2);
    hold on;
end
%disp(Tree.T);

%   Tree.surface、面の描画
for i = 4:4:length(Tree.surface)
    surf_x = [Tree.surface(i-3, 1) Tree.surface(i-2, 1);...
        Tree.surface(i-1, 1) Tree.surface(i, 1)];
    surf_y = [Tree.surface(i-3, 2) Tree.surface(i-2, 2);...
        Tree.surface(i-1, 2) Tree.surface(i, 2)];
    surf_z = [Tree.surface(i-3, 3) Tree.surface(i-2, 3);...
        Tree.surface(i-1, 3) Tree.surface(i, 3)];
    surf(surf_x, surf_y, surf_z, 'FaceColor', [0.4, 0.4, 0.4]);
    hold on;
end
xlabel("x");
ylabel("y");
zlabel("z");
%xlim([-1 3]);
%ylim([-1 3]);
%zlim([-1 3]);

%太陽の描画　なくても大丈夫
load('sun_info.mat');
[sun_x, sun_y, sun_z] = sph2cart(deg2rad(sunposition.Azimuth),deg2rad(sunposition.Elevation),10.0);
%plot3(sun_x, sun_y, sun_z, "o")
%hold on;

box on
hold off
%filename = strcat('/Users/nakachisoushi/workspace/study/mtm_fig/','file', num2str(i_no));
%saveas( gcf, filename, 'jpg'); 
end