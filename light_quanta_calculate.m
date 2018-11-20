% sun_position.csv ��2018/7/1�̃f�[�^
% ���q�����v�Z����X�N���v�g
% �Ƃ肠�����A�t���f���͍X�V�����Œ肳���A���q�����v�Z����֐�����������B


%�t���f���̖ʂ̒��_���W������

%���z�̓�����15�������ɍX�V�B

%���z�̒��S���W���v���b�g
figure;
[sun_x, sun_y, sun_z] = sph2cart(deg2rad(sunposition.Azimuth),deg2rad(sunposition.Elevation),10.0);
plot3(sun_x, sun_y, sun_z, "o")
xlabel("x (east or west)")
ylabel("y (north or south)")
zlabel("z (height)")
grid on;
hold on;


%���̗����𐶐�
%figure
tmp_rand = 10;  %�����𐶐����鐔�B��X�A���˗ʂɔ�Ⴕ�Đݒ肷��̂ŁA�ꎞ�I�Ȃ��
for n = 10:50
    rng(0,'twister')
    rvals = 2*rand(tmp_rand,1)-1;
    elevation = asin(rvals);

    azimuth = 2*pi*rand(tmp_rand,1);
    radii = 1*(rand(tmp_rand,1).^(1/3));
    [x_rand,y_rand,z_rand] = sph2cart(azimuth,elevation,radii);
    plot3(x_rand + sun_x(n), y_rand + sun_y(n), z_rand + sun_z(n),'.');
    hold on
    
    %�����Ő��������_�̒����̕`��
    direction_vector = [sun_x(n), sun_y(n), sun_z(n)];  %�����x�N�g���̕ێ�
    line_rand(x_rand, y_rand, z_rand, direction_vector);  %�������R�����g������ꉞ�y���Ȃ�B
    
end

%�����Ő��������_��ʂ钼���̕`��
function line_rand(x_rand, y_rand, z_rand, direction_vector)
    t = 0:1;
    
    for n = 1:length(x_rand)
        %if z_rand(n) + t*direction_vector(3) >= 0
            plot3(x_rand() + t*direction_vector(1), y_rand(n) + t*direction_vector(2),...
                z_rand(n) + t*direction_vector(3));
            hold on
        %end
    end
end

%�͋[���ˌ����̍쐬�i����i�K�j
%�l�b�g����B�v���ȁH
%{
figure
for n = 1:63
    point = [x(n), y(n), z(n)];
    normal = point; 
    %# a plane is a*x+b*y+c*z+d=0
    %# [a,b,c] is the normal. Thus, we have to calculate
    %# d and we're set
    d = -point*normal'; %'# dot product for less typing

    %# create x,y
    [xx,yy]=ndgrid(1:10,1:10);

    %# calculate corresponding z
    zz = (-normal(1)*xx - normal(2)*yy - d)/normal(3);
    
    surf(xx,yy,zz)
    
    grid on
    hold on
end
%}

%�͋[���ˌ����̍쐬�i����i�K�j
%meshgrid��p�������@�B�v���ȁH
%{
for n = 10:40
    [x_range,y_range]=meshgrid(x(n)-1:0.1:x(n)+1,y(n)-1:0.1:y(n)+1);
    z_range = ((x(n).^2 + y(n).^2 + z(n).^2 - x(n)*x_range - y(n)*y_range) / z(n));
    
    surf(x_range, y_range, z_range);
    hold on;
    
end
plot3(0, 0, 0, "o");
%}
