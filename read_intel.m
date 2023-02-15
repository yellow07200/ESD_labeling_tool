function [intel_depth_val, intel_depth_img, intel_color_img, intel_ts] = read_intel(i,intel_depth, intel_depth_ts, intel_color, intel_color_ts) 
%     intel_depth_topic = select(bag, 'Time',...
%         [bag.StartTime+3 bag.StartTime + 4], 'Topic', '/camera/aligned_depth_to_color/image_raw');
%     intel_depth = readMessages(intel_depth_topic); % topic & msg of DAVIS_velocity_linear & angular
%     intel_depth_ts = timeseries(intel_depth_topic).Time;
    intel_ts = intel_depth_ts(i);

    p_max = max(intel_depth{i}.Data);
    intel_depth_val = readImage(intel_depth{i});

    intel_depth_img = double(intel_depth_val)/double(max(max(intel_depth_val)))*255;
    % figure
    % imshow(round(intel_depth_img));

    % read color image from RGBD camera
%     intel_color_topic = select(bag, 'Time',...
%         [bag.StartTime+3 bag.StartTime + 4], 'Topic', '/camera/color/image_raw');
%     intel_color = readMessages(intel_color_topic); % topic & msg of DAVIS_velocity_linear & angular
%     intel_color_ts = timeseries(intel_color_topic).Time;

    intel_color_img = readImage(intel_color{i});


end