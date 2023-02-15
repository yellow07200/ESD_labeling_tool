function [u, v] = m_to_px(x, y, z, cam_mat)
%PX_TO_M Converts a pixel location to its mcoordinates in meters using
%depth
%   Detailed explanation goes here

fx = cam_mat(1,1);
fy = cam_mat(2,2);
cx = cam_mat(1,3);
cy = cam_mat(2,3);

u = round(fx * x / z + cx);
v = round(fy * y / z + cy);

end

