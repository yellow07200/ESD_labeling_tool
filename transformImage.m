function [output_image1, output_image2] = transformImage(input_image1, input_image2, rotation_matrix, translation, output_shape)
%TRANASFORMIMAGE Summary of this function goes here
%   Detailed explanation goes here

output_image1 = zeros(output_shape);
output_image2 = zeros(output_shape);

for v=1:size(input_image1,1)
    for u=1:size(input_image1,2)
        a = round( rotation_matrix * [v u]' + translation)';
        out_v = a(1);
        out_u = a(2);
        if (out_v > 0) && (out_v <= output_shape(1)) ...
            && (out_u > 0) && (out_u <= output_shape(2))
        
            output_image1(out_v, out_u) = input_image1(v, u);
            output_image2(out_v, out_u) = input_image2(v, u);
        end 
    end
end

