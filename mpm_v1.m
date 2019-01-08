%{  
    2018/12/21
    �ꎞ�I�ȃX�N���v�g�B�̂��̂��A�S�Ċ֐����B
    
%}
M = 11;     %max_depth
m_lam = 0.5;    %�}�̃p���[���^�̕���
s_lam = 0.2;    %   �A�A�@�@�@�@���U
m_ab = pi/6;
s_ab = pi/18;
%{
m_a = pi/6;
s_a = pi / 18;
m_b = 0;
s_b = pi/18;
%}
Tree.str = [];      %(X 1 <subtree>)�����ς݂̕�����
Tree.surface = [];  %�ʂ̏��
Tree.default = {m_lam, s_lam, m_ab, s_ab};  %�e�p�����[�^�̕��ςƕ��U
Tree.branch = [];     %F�̂Ƃ������̃p�����[�^
Tree.a = [];          %x���̊p�x�̃p�����[�^�iR�j
Tree.b = [];          %   �A�A           �iL�j
Tree.c = [];          %z���̊p�x�̃p�����[�^�i+�j
Tree.d = [];          %   �A�A           �i-�j

Tree = ini(Tree, 3);        %������ƃp�����[�^�̏�����
%Tree = add_surface(Tree);   %�������ꂽ������A�p�����[�^��p���ėt�̖ʐς�t�����鏈��
%Tree = mpm(Tree);
%������3d�X�y�[�X�֕`��̏�����
treePlot(Tree);     %Tree���v���b�g




%%%%%%%%%%%%%%%%%%%�ȉ��֐�%%%%%%%%%%%%%%%%%%%%

%   Metropolis Procedural Modeling
%   ���͂�Tree�A�o�͂�Tree
function Tree = mpm(Tree)
N = 10;     %�œK����
for i = 1:N
    tmp = diffusion_or_jump;
    switch tmp
        case 'diffusion'
            t = random_terminal(Tree);  %Tree�̒��̕�����̏I�[�L���������_����
            %disp("�I�΂ꂽ�C���f�b�N�X�ԍ��Ƃ��̕���:" + t + "��" + Tree.str(t));
            param = sample_diffusion(Tree, t);  %�I�΂ꂽ�I�[�L���ɑ΂��čăT���v�����O
            accept_pro = likehood_diffusion(Tree, param);   %�̑��m���A�ޓx�֐�
        case 'jump'
            %�����͂䂭�䂭
    end
    t = rand(1);
    if t < accept_pro
        Tree = copy_parme_tree(Tree, param);
    else
        
    end
    
end
end

%   difussion��jump�̕������Ԃ��֐�
%   �m����jump�̕����傫������\��
function tmp = diffusion_or_jump

tmp = 'diffusion';  %�ꎞ�I�Ȃ��
end

%   �I�[�L���������_���ɕԂ��֐�
%   ���͂�Tree�A�o�͂�t�iTree.str�̍ŐV�̕�����̒��ł̏I�[�L���̃C���f�b�N�X�ԍ��j�B
function t = random_terminal(Tree)
%str = Tree.str(length(Tree.str));  %����1�~1�����牺�̂ł������ATree.str���������
str = Tree.str;      %str�ɑΏۂ̕�������R�s�[
n = randi([1 length(Tree.str)], 1);

while(1)
    if str(n) == 'F' || str(n) == 'L' || str(n) == 'R' || str(n) == '+' || str(n) == '-'
        t = n;  %�C���f�b�N�X��Ԃ�
        break;
    else        %�I�[�����񂶂�Ȃ��ꍇ�A�����_����
        tmp = rand;
        if n == length(str)
            n = n-1;
        elseif n == 1
            n = n+1;
        else
            if tmp >= 0.5
                n = n+1;
            else
                n = n-1;
            end
        end
    end        
end
end

%   �ꎞ�I�Ȃ�BTree�̏������BTree.str�ɓK���ɕ������
function Tree = ini(Tree, N)
rule(1).before = 'X';
rule(1).after = 'F[LX][RX][+X][-X]';

rule(2).before = 'X';
rule(2).after = 'FZ';

%nRules = length(rule);

%starting seed ����������
axiom = 'X';

%number of repititions
nReps = N;


for i=1:nReps
    %len = len*ratio;
    
    %one character/cell, with indexes the same as original axiom string
    axiomINcells = cellstr(axiom'); 
    
    hit = strfind(axiom, rule(1).before);
    
    if length(hit) >= 1
        for k = hit
            l = rand;   
            %l = 0.4;
            
            if (l < i/nReps) && (length(axiomINcells)>1)
                axiomINcells{k} = rule(2).after;
            else
                axiomINcells{k} = rule(1).after;
            end
            
            %axiomINcells{k} = rule(1).after;
        end
    end
    
    %now convert individual cells back to a string
    axiom=[];
    for j=1:length(axiomINcells)
        axiom = [axiom, axiomINcells{j}];
    end
end

Tree.str = axiom;   %����������̃Z�b�g

%   �p�����[�^�̏����l��ݒ�
%   Tree.param�͈ꉞ�������B
for i = 1:length(Tree.str)
    switch Tree.str(i)
        case 'F'
            param = normrnd(Tree.default{1}, Tree.default{2});
            Tree.branch = [Tree.branch, param];
            Tree.param(i) = param;
        case 'R'
            param = normrnd(Tree.default{3}, Tree.default{4});
            Tree.a = [Tree.a, param];
            Tree.param(i) = param;
        case 'L'
            param = normrnd(Tree.default{3}, Tree.default{4});
            Tree.b = [Tree.b, param];
            Tree.param(i) = param;
        case '+'
            param = normrnd(Tree.default{3}, Tree.default{4});
            Tree.c = [Tree.c, param];
            Tree.param(i) = param;
        case '-'
            param = normrnd(Tree.default{3}, Tree.default{4});
            Tree.d = [Tree.d, param];
            Tree.param(i) = param;
        otherwise
            Tree.param(i) = -1;
    end
end
end

%   Tree�̓��e���v���b�g����֐�
%   2019/1/8�ɋC�Â��B�O���ƌ㔼�̏�����ʂ̊֐��ɕ����������ǂ��̂ł́H
function treePlot(Tree)
%   ���ꂼ�ꏉ����
v = [0 0 0];
depth = 1;
stkIndex = 1;
T = [0, 0, 0];
azimuth = pi/2; elevation = pi/2;
xT = 0; yT = 0; zT =0;
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
            
        otherwise
            disp("error");
            return
    end    
end

%   T�̓��e��`��

%disp("T�̒���"+length(T))
assignin('base', 'T', T)
%disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
figure(1);
for i = 2:length(T)
    
    plot3([T(i-1, 1), T(i, 1)],[T(i-1, 2), T(i, 2)],[T(i-1, 3), T(i, 3)], ...
        'g', 'Linewidth', 2);
    hold on
end
assignin('base', 'T', T)
%disp(T);
end
%   �������ꂽ������A�p�����[�^��p���ėt�̖ʐς�t������֐�
function add_surface(Tree)



end