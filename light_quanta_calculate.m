%light_quanta_caluculate.m
% ���q�����v�Z����X�N���v�g
% �Ƃ肠�����A�t���f���͍X�V�����Œ肳���A���q�����v�Z����֐�����������B

%�t�̃��f���Ƃ��ēK���ȕ��ʂ𐶐�
figure;
[xx,yy]=ndgrid(-0.5:0.5,-0.5:0.5);
zz = zeros(size(xx));
surf(xx, yy, zz);
hold on;


%���z�̓�����15�������ɍX�V�B

%���z�̒��S���W���v���b�g�i2018/7/1 �k�C���E�D�y�j
figure;
[sun_x, sun_y, sun_z] = sph2cart(deg2rad(sunposition.Azimuth),deg2rad(sunposition.Elevation),10.0);
plot3(sun_x, sun_y, sun_z, "o")
xlabel("x (east or west)")
ylabel("y (north or south)")
zlabel("z (height)")
grid on;
hold on;

%���B�������q���̐��B���̐����ő剻����悤�Ȑ�����s���B
reached_q = 0;

%���̗����𐶐�
tmp_rand = 50;  %�����𐶐����鐔�B��X�A���˗ʂɔ�Ⴕ�Đݒ肷��̂ŁA�ꎞ�I�Ȃ��
all_quanta = 300;  %�P���ɕ��˂��鑍���q��
for n = 1:61
    n_q = time_quanta(n, solorradiation, all_quanta);   %n_q�Ɏ��ԕʂɔ�����������q������
    rng(n,'twister')    %��������
    rvals = 2*rand(n_q,1)-1;
    elevation = asin(rvals);
    azimuth = 2*pi*rand(n_q,1);
    radii = 1*(rand(n_q,1).^(1/3));
    [x_rand,y_rand,z_rand] = sph2cart(azimuth,elevation,radii);
    
    plot3(x_rand + sun_x(n), y_rand + sun_y(n), z_rand + sun_z(n),'.');
    hold on
    
    %�����ɒǉ����邼
    %���ꂼ��̔����������������A�t�ɒB���Ă��邩�`�F�b�N
    %{
    if shading_check(x_rand, y_rand, z_rand) == 1
        reached_q = reached_q + 1;  %�t�Ɍ��q���B���΁A�C���N�������g
    end
    %}
    
    %�����Ő��������_�̒����̕`��
    direction_vector = [sun_x(n), sun_y(n), sun_z(n)];  %�����x�N�g���̕ێ�
    line_rand(x_rand, y_rand, z_rand, direction_vector);  %�������R�����g������ꉞ�y���Ȃ�B
    
end



%%%%%%%%%%%%%%%%    �ȉ��֐��@�@�@%%%%%%%%%%%%%%%%%%

%�����Ő��������_��ʂ钼���̕`��
function line_rand(x_rand, y_rand, z_rand, direction_vector)
    t = 0:1;
    
    for n = 1:length(x_rand)
        %if z_rand(n) + t*direction_vector(3) >= 0
            plot3(x_rand(n) + t*direction_vector(1), y_rand(n) + t*direction_vector(2),...
                z_rand(n) + t*direction_vector(3));
            hold on
        %end
    end
end

%���ԕʂɔ�����������q�����v�Z����֐�
function n_q = time_quanta(n, solorradiation, all_quanta)
    switch n
        case {4, 5, 6, 7}
            tmp = solorradiation.Solor_radiation(1);
        case {8, 9, 10, 11}
            tmp = solorradiation.Solor_radiation(2);
        case {12, 13, 14, 15}
            tmp = solorradiation.Solor_radiation(3);
        case {16, 17, 18, 19}
            tmp = solorradiation.Solor_radiation(4);
        case {20, 21, 22, 23}
            tmp = solorradiation.Solor_radiation(5);
        case {24, 25, 26, 27}
            tmp = solorradiation.Solor_radiation(6);
        case {28, 29, 30, 31}
            tmp = solorradiation.Solor_radiation(7);
        case {32, 33, 34, 35}
            tmp = solorradiation.Solor_radiation(8);
        case {36, 37, 38, 39}
            tmp = solorradiation.Solor_radiation(9);
        case {40, 41, 42, 43}
            tmp = solorradiation.Solor_radiation(10);
        case {44, 45, 46, 47}
            tmp = solorradiation.Solor_radiation(11);
        case {48, 49, 50, 51}
            tmp = solorradiation.Solor_radiation(12);
        case {52, 53, 54, 55}
            tmp = solorradiation.Solor_radiation(13);
        case {56, 57, 58, 59}
            tmp = solorradiation.Solor_radiation(14);
        case {60, 61, 62, 63}
            tmp = solorradiation.Solor_radiation(15);
        otherwise
            tmp = 0;
    end
    n_q = round(all_quanta * (tmp / sum(solorradiation.Solor_radiation)));
    
end

function shading = shading_check()
    shading = 1;
    
end


%%%%%%%%%%%%%%%%    �ȉ��{�c�@�@�@%%%%%%%%%%%%%%%%%%
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
