function out_depth_image = tranaformDepthImage(in_depth_image, in_cam_mat, in_dist_coef, in_pose, out_cam_mat, out_dist_coef, out_pose, out_shape, mask_intel)
% [out_depth_image, out_u_e, out_v_e, label_e]
%TRANAFORMDEPTHIMAGE Summary of this function goes here
%   Detailed explanation goes here

out_depth_image = zeros(out_shape);
out_u_e = [];
out_v_e = [];
label_e = [];

for j=1:size(in_depth_image, 1)
    for i=1:size(in_depth_image, 2)
        %get x y coordinates
        in_z = double(in_depth_image(j, i))/1000.0;
        if in_z > 0
            [in_x, in_y] = px_to_m(i, j, in_z, in_cam_mat);

            %convert vector a from depth camera frame to out camera frame
            p_in_a = [in_x in_y in_z 1]';
            p_out_a = inv(out_pose) * in_pose * double(p_in_a);%TODO: more efficient conversion
            out_x = p_out_a(1);     out_y = p_out_a(2);     out_z = p_out_a(3);
            
            [out_u, out_v] = m_to_px(out_x, out_y, out_z, out_cam_mat);

            label_temp = mask_intel(j, i);

            if (out_u >= 0 && ...
                    out_u < out_shape(2) && ...
                        out_v >= 0 && ...
                            out_v < out_shape(1))
                out_depth_image(out_v+1, out_u+1) = out_z*1000;
                
                out_u_e=[out_u_e; out_u];
                out_v_e=[out_v_e; out_v];
                label_e=[label_e; label_temp];
                
            end
        end
        
    end
end

end

