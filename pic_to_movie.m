function pic_to_movie()
%UNTITLED ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
clear all;
close all;

aviobj = VideoWriter('image.avi');
aviobj.FrameRate = 5;

ImgN=80;
for i=1:ImgN
    %Image Read
    Imgfilename = strcat('mtm_fig/', 'file',num2str(i),'.jpg');
    A=imread(Imgfilename);
    image(A)
    axis off;
    drawnow;
    
    M = getframe(gcf);
    %aviobj = addframe(aviobj,M);
    open(aviobj);
    writeVideo(aviobj, M);
    
end

close(aviobj);
end
