%   �p�����[�^�ɑ΂��āA�t�̏��ƃv���b�g�ɕK�v�ȏ���t������֐�
function Tree = func_add_info(Tree)
depth = 1;          %�؂̐[��
stkIndex = 1;
T = [0, 0, 0];      %�؂̃g�|���W�[�ۑ��p
Tree.surface = [];  %�t�̖ʍ��W
azimuth = pi/2; elevation = pi/2;
xT = 0; yT = 0; zT =0;
x_z_length = 0.4 / sqrt(2);     %x��z�̓��������B��ӂ�0.4�̏ꍇ�B���p�񓙕ӎO�p�`�̔䂾��I
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
            %3�~4�s�̗t�ł���ʂ̏���t��
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
