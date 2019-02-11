%   パラメータに対して、葉の情報とプロットに必要な情報を付加する関数
function Tree = func_add_info(Tree)
depth = 1;          %木の深さ
stkIndex = 1;
T = [0, 0, 0];      %木のトポロジー保存用
Tree.surface = [];  %葉の面座標
azimuth = pi/2; elevation = pi/2;
xT = 0; yT = 0; zT =0;
x_z_length = 0.4 / sqrt(2);     %xとzの動く距離。一辺が0.4の場合。直角二等辺三角形の比だよ！
for i = 1:length(Tree.str)
    switch Tree.str(i)
        case 'F'
            
            [newxT, newyT, newzT] = sph2cart(azimuth, elevation, Tree.param(i));
            xT = xT+newxT; yT = yT+newyT; zT = zT+newzT;
            T = [T; xT, yT, zT];
            %disp(i)
            %disp(T)
            %v = [v, azimuth, elevation, Tree.param(i)];
        case 'R'
            azimuth = 0;
            elevation = Tree.param(i);
            
        case 'L'
            azimuth = pi;
            elevation = Tree.param(i);
        case '+'
            azimuth = pi/2;
            elevation = Tree.param(i);
        case '-'
            azimuth = pi * 3/2;
            elevation = Tree.param(i);
        case '['
            stack(stkIndex).xT = xT;
            stack(stkIndex).yT = yT;
            stack(stkIndex).zT = zT;
            stkIndex = stkIndex + 1;
            depth = depth + 1;
        case ']'
            stkIndex = stkIndex - 1;
            xT = stack(stkIndex).xT;
            yT = stack(stkIndex).yT;
            zT = stack(stkIndex).zT;
            T = [T; xT, yT, zT];
            
        case 'Z'
            %3×4行の葉である面の情報を付加
            %Tree.surface = [Tree.surface; xT yT-0.1 zT; xT yT+0.1 zT;...
            %    xT+0.1 yT-0.1 zT+0.1; xT+0.1 yT+0.1 zT+0.1];
            %Tree.surface = [Tree.surface; xT yT-0.1 zT; xT+0.1 yT-0.1 zT+0.1;...
                %xT yT+0.1 zT; xT+0.1 yT+0.1 zT+0.1];
            Tree.surface = [Tree.surface; xT yT-0.2 zT; xT+x_z_length yT-0.2 zT+x_z_length;...
                xT yT+0.2 zT; xT+x_z_length yT+0.2 zT+x_z_length];
        otherwise
            disp("error");
            return
    end    
end
Tree.T = T;
end
