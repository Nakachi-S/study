function one_surface_calu(N, all_quanta)
%   ��r�����̂��߂̊֐��B�ꖇ�̖ʂ̎���ʂ𒲂ׂ�B
%   ���͈����FN���ʂ̐�

surf_info = 0.04 * N;
length = sqrt(surf_info);

x = [-length/2, -length/2; length/2, length/2];
y = [-length/2, length/2; -length/2, length/2];
z = [0.5, 0.5; 0.5, 0.5];   %�����ς�����A�����ς��āB�蓮��
figure(1);
surf(x, y, z);
hold on;

output_surf = [-length/2 -length/2 0.5; length/2 -length/2 0.5;...
    -length/2 length/2 0.5; length/2 length/2 0.5];


%all_quanta = 1000;  %���������̊m�F�K�{
quanta = light_quanta_calu(output_surf, all_quanta);
disp(quanta);
end

