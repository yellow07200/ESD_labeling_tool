%% P1--stereo-dvs & intel cobfigurations 
k_el = [349.60817472   0.         179.96134154;...
        0.         349.94740878 125.95477917;...
        0.           0.           1.        ];
m_el = [ 0.6308511  -0.04194963  0.77476907  0.0041838;...
        -0.77565985 -0.05914015  0.62837428  0.15558023;...
        0.01945989 -0.99736787 -0.06984727  0.10039507;...
        0.          0.          0.          1. ]     ;
d_el = [-3.40016570e-01 -4.16759407e-03  3.74480929e-05 -4.14482894e-04 5.43477741e-01];
%
k_er = [344.4324997    0.         161.91358016;...
        0.         344.63168706 124.92903904;...
        0.           0.           1.    ];
m_er = [ 0.77356643 -0.02081131  0.63337341  0.1565858 ;...
        -0.63353662 -0.04912395  0.77215166  0.00904179;...
        0.01504432 -0.99857585 -0.05118536  0.10344005;...
        0.          0.          0.          1.        ];
d_er = [-0.36338287  0.30069459 -0.00040538 -0.00137928 -0.39233062];

%
k_d = [613.087646484375, 0.0, 324.5477600097656;...
        0.0, 613.378173828125, 233.75576782226562;...
        0.0, 0.0, 1.0];
d_d = [0.0, 0.0, 0.0, 0.0, 0.0];

m_d = [0.71816448,  0.00808576,  0.69582641,  0.03926356;...
            -0.69540667, -0.02827723,  0.71805986,  0.08717657;...
            0.0254821,  -0.99956742, -0.01468481,  0.09887745;...
            0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  1.00000000e+00];

%
    
TCP_to_cam = [0.71816448,  0.00808576,  0.69582641,  0.03926356;...
            -0.69540667, -0.02827723,  0.71805986,  0.08717657;...
            0.0254821,  -0.99956742, -0.01468481,  0.09887745;...
            0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  1.00000000e+00];

%% P2--read h5 file
file_name = 'C:\Users\aric-ku\Documents\Huang\ESD_data\training\ok\2_obj_1speed_linear_goodlight_082height\2_obj_1speed_linear_goodlight_082height.hdf5';

left_info = h5info(file_name);
right_info = h5info(file_name);

left_image_e = h5read(file_name,'/left_image_e');
left_image_e = permute(left_image_e,[4,3,2,1]); %4-D
left_image_e_ts = h5read(file_name,'/left_image_e_ts');
left_events = h5read(file_name,'/left_events');

right_image_e = h5read(file_name,'/right_image_e');
right_image_e = permute(right_image_e,[4,3,2,1]);
right_image_e_ts = h5read(file_name,'/right_image_e_ts');
right_events = h5read(file_name,'/right_events');

tcp_vel_ts = h5read(file_name,'/tcp_vel_ts');
tcp_vel_linear = h5read(file_name,'/tcp_vel_linear');
tcp_vel_angular = h5read(file_name,'/tcp_vel_angular');

tcp_pos_ts = h5read(file_name,'/tcp_pose_ts');
tcp_pos_position = h5read(file_name,'/tcp_pose_position');
tcp_pos_orientation = h5read(file_name,'/tcp_pose_orientation');

intel_color_ts = h5read(file_name, '/image_raw_ts');
intel_color = h5read(file_name, '/image_raw');
intel_depth_ts = h5read(file_name, '/depth_ts');
intel_depth = h5read(file_name, '/depth');

%% p3--labeling
events = permute(right_events,[2,1]); 
dilate_para = 10;

start_page = 14;
end_page = 63;

folder_name_1 = 'C:\Users\aric-ku\Documents\Huang\ESD_data\training\ok';
folder_name_2 = '\2_obj_1speed_linear_goodlight_082height';
folder_name_3 = '\SegmentationClass\';
folder_name = strcat(folder_name_1, folder_name_2, folder_name_3);

d_t = 0.01;  % set the volumn range of events for initial labeling: [t0-d_t, t0+d_t]

eventsNlabel = [];
eventsNlabel_crop = [];

bag_start_t = intel_color_ts(1);

N_events_per_ICP = 300;
ind = [];

mask_e_all =[];
depth_output_all = [];

for n=start_page:end_page% 1:length(intel_color(1,1,1,:))
    
    file_name = strcat(num2str(n), '.png')
    label_name = strcat(folder_name, file_name);
    
    t_start = intel_color_ts(n); % timestamp of labeled initial rgb image 
    if n < length(intel_color)
        t_end = intel_color_ts(n+1);
    else
        t_end = intel_color_ts(end);
    end
    
    [t_close_e, ind_start] = find_closest_timestamp(t_start, events(:,4));
    [t_close_e, ind_end] = find_closest_timestamp(t_end, events(:,4));

    temp_indicies = ind_start:N_events_per_ICP:ind_end;
       
    % read mask of rgb image
    mask = read_label(label_name);
    
    % find the corresponding depth value
    [t_close, ind_depth] = find_closest_timestamp(t_start, intel_depth_ts);
    intel_depth_val = intel_depth(:,:,ind_depth);
    intel_depth_val = permute(intel_depth_val,[2,1]); 

    % image projection from rgbd camera to events camera
    out_shape = [260,346];

    grey_scale = rgb2gray(permute(intel_color(:,:,:,n),[3,2,1]));
    grey_edge = edge(grey_scale);
%     [depth_output, grey_edge_e] = tranaformDepthMaskImage(intel_depth_val, grey_edge, k_d, d_d, m_d, k_el,d_el, m_el,out_shape); %,mask);
%     [depth_output, mask_e] = tranaformDepthMaskImage(intel_depth_val, mask, k_d, d_d, m_d, k_el, d_el, m_el, out_shape);
    [depth_output, grey_edge_e] = tranaformDepthMaskImage(intel_depth_val, grey_edge, k_d, d_d, m_d, k_er,d_er, m_er,out_shape);
    [depth_output, mask_e] = tranaformDepthMaskImage(intel_depth_val, mask, k_d, d_d, m_d, k_er, d_er, m_er, out_shape);
    mask_e_all = [mask_e_all; mask_e];
    depth_output_all = [depth_output_all; depth_output];
    
    se = strel('line', dilate_para, dilate_para);
    mask_e = imdilate(mask_e, se);

    %generate event frames and do ICP
    eventsNlabel_nn = [];
    for temp_j = 1:length(temp_indicies)-1
        temp_ind_start = temp_indicies(temp_j);
        temp_ind_end = temp_indicies(temp_j+1)-1;
        object_mask = mask_e > 0;
        
        masked_edge_e = object_mask .* grey_edge_e;
        
        event_frame = generate_event_frame_gray(t_start, 200000000, events(temp_ind_start:temp_ind_end,:)); % 150000000
        [transformed_grey_edge_e, rotation_matrix, translation] = performICP(event_frame/255, masked_edge_e);

        [transformed_mask_e, transformed_depth_e] = transformImage(mask_e, depth_output, rotation_matrix, translation, [260, 346]);
        eventsNlabel_n = e_labeling(transformed_mask_e, transformed_depth_e, events(temp_ind_start:temp_ind_end,:));
  
        eventsNlabel_nn = [eventsNlabel_nn; eventsNlabel_n];
        eventsNlabel = [eventsNlabel; eventsNlabel_n];
        ind = [ind; n];  
    end
    cell_all{n}=eventsNlabel_nn;
    
%     % events_frame.mat
%     rgb_img = permute(intel_color(:,:,:,n),[3,2,1]);
%     event_frame_left = tranaformRGBImage(rgb_img, intel_depth_val, k_d, d_d, m_d, k_el, d_el, m_el, out_shape, mask);
%     event_frame_right = tranaformRGBImage(rgb_img, intel_depth_val, k_d, d_d, m_d, k_er, d_er, m_er, out_shape, mask);
%     
%     event_frame_left_list{n} = event_frame_left; % events_frame.mat  \\\\  mask_left--> mask_events_frame.mat
%     event_frame_right_list{n} = event_frame_right;
% 
%     % mask_events_frame.mat
%     [depth_output, mask_e_l] = tranaformDepthMaskImage(intel_depth_val, mask, k_d, d_d, m_d, k_el, d_el, m_el, out_shape); %,mask); 
%     mask_left{n} = mask_e_l; 
% 
%     [depth_output, mask_e_r] = tranaformDepthMaskImage(intel_depth_val, mask, k_d, d_d, m_d, k_er, d_er, m_er, out_shape);%,mask); 
%     mask_right{n} = mask_e_r;   
% %     
end
event_labeled = eventsNlabel;
intel_color_ts(end)-intel_color_ts(1)
events(end,4)-events(1,4)
event_labeled(end,4)-event_labeled(1,4)
events_cell = cell_all;
        