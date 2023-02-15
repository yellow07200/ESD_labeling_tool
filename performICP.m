function [output_image, rotation_matrix, translation] = performICP(target_image, input_image)
%PERFORMICP Summary of this function goes here
%   Detailed explanation goes here
[y_in, x_in] = find(input_image>0);
[y_source, x_source] = find(target_image>0);
[rotation_matrix, translation, shifted] = icp([y_source, x_source], [y_in, x_in]);

output_shape = size(target_image);
[output_image, output_image] = transformImage(input_image, input_image, rotation_matrix, translation, output_shape);

end

