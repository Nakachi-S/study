function [tree_A, tree_T joint_p] = derive_tree_v1
%derive_tree_v1
%   
%   derive_string_v1より生成した文字列から
%   パラメータを考慮した3D spaceへの写像
%
%   INPUT  
%   - 
%
%   OUTPUT
%   - tree_A:   
%
%
%   - tree_T:          
%




axiom = derive_string_v2;
field1 = 'derivated_tree';
value1 = axiom;
field2 = 'parameters';
value2 = zeros(1, length(value1));
field3 = 'prior1';
value3 = zeros(1, length(value1));
field4 = 'prior2';
value4 = zeros(1, length(value1));
field5 = 'rederive';
value5 = zeros(1, length(value1));
value5(:) = 0;
shaft_length = 90;

% Give parameters
%for i = 1:length(axiom)    
    %hit = strfind(value1, 'F');
joint_p = 1;
hit = find(value1 == 'F' | value1 == '+' | value1 == '-' | value1 == '&' | value1 == '^');
    if length(hit) >= 1;
        for k = hit
			gaussv = randn(1, 1);
			
			if value1(k)=='F'
				gaussp = normpdf(gaussv, 0, 1);
				value2(k) = default_edge + edge_scale*gaussv;
			else
				gaussp = normpdf(gaussv, 0, 1);
				value2(k) = default_angle + angle_scale*gaussv;
			end
			value3(k) = gaussp;
			joint_p = joint_p * gaussp;
        end
    end
	

A =struct(field1,value1,field2, value2, field3, value3, field4, value4, field5, value5);
A.parameters(1) = shaft_length; % set the first edge
T = reconstruct_T_v2(A, 'off');
end

