% sun_position.csv ��2018/7/1�̃f�[�^
% ���q�����v�Z����X�N���v�g
% �Ƃ肠�����A�t���f���͍X�V�����Œ肳���A���q�����v�Z����֐�����������B


%�t���f���̖ʂ̒��_���W������
figure
[x, y, z] = sph2cart(deg2rad(sunposition.Azimuth),deg2rad(sunposition.Elevation),2.0);
plot3(x, y, z, "o")

grid on;

figure
for n = 1:63
    point = [x(n), y(n), z(n)];
    normal = -point; 
    %# a plane is a*x+b*y+c*z+d=0
    %# [a,b,c] is the normal. Thus, we have to calculate
    %# d and we're set
    d = -point*normal'; %'# dot product for less typing

    %# create x,y
    [xx,yy]=ndgrid(1:10,1:10);

    %# calculate corresponding z
    z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);

    %# plot the surface
    %figure
    surf(xx,yy,z)
    %plot3(x(n), y(n), z(n), "o")
    grid on
    hold on
    disp(n)
end
