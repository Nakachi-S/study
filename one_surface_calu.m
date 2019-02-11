function one_surface_calu(N, all_quanta)
%   比較実験のための関数。一枚の面の受光量を調べる。
%   入力引数：N＝面の数

surf_info = 0.04 * N;
length = sqrt(surf_info);

x = [-length/2, -length/2; length/2, length/2];
y = [-length/2, length/2; -length/2, length/2];
z = [0.5, 0.5; 0.5, 0.5];   %ここ変えたら、下も変えて。手動で
figure(1);
surf(x, y, z);
hold on;

output_surf = [-length/2 -length/2 0.5; length/2 -length/2 0.5;...
    -length/2 length/2 0.5; length/2 length/2 0.5];


%all_quanta = 1000;  %実験条件の確認必須
quanta = light_quanta_calu(output_surf, all_quanta);
disp(quanta);
end

