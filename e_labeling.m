function [labeled_events] = e_labeling(transformed_mask_e, transformed_depth_e, events_list)
%e_labeling Summary of this function goes here
%   Detailed explanation goes here

labeled_events = zeros(size(events_list,1), 6);

labeled_events(:, 1:4) = events_list;

for i=1:size(events_list,1) 
    x = events_list(i,1)+1;
    y = events_list(i,2)+1;
    labeled_events(i, 5) = transformed_depth_e(y,x);
    labeled_events(i, 6) = transformed_mask_e(y,x);
end