N_events_per_ICP = 300;

crop_start1 = 70; % remove right
crop_end1 = 86;
crop_start2 = 14; % remove up
crop_end2 = 44;
crop_start3 = 45; % remove up & right
crop_end3 = 69;
eventsNlabel_crop = [];
eventsNlabel_cropped_all = [];
event_labeled = [];
% eventsNlabel_cropped_all_cell

% temp_e_n(mn,2)<=n_max -- crop up
% temp_e_n(mn,1)<=m_max -- crop right side 

for i=1:length(cell_all)
    i
    if i>=crop_start1 && i<=crop_end1
        %generate event frames and do ICP
        eventsNlabel_crop_n = [];
        temp_e = cell_all{i};

        temp_indicies = 1:N_events_per_ICP:length(temp_e);
        for temp_j = 1:length(temp_indicies)-1
            temp_ind_start = temp_indicies(temp_j);
            temp_ind_end = temp_indicies(temp_j+1)-1;

            % remove the bind area
            temp_e_n = temp_e(temp_ind_start:temp_ind_end,:);
            [m,n] = find(temp_e_n(:,6)>0);
            m_max = max(temp_e_n(m,1));
            m_min = min(temp_e_n(m,1));
            n_min = min(temp_e_n(m,2));
            n_max = max(temp_e_n(m,2));

            for mn =1:length(temp_e_n)
                if temp_e_n(mn,1) <= m_max %temp_e_n(mn,2)<=n_max %&& temp_e_n(mn,2)>=n_min
                    eventsNlabel_crop_n = [eventsNlabel_crop_n; temp_e_n(mn,:)];
                end
            end 
        end
        eventsNlabel_crop_n_cell{i} = eventsNlabel_crop_n;
        eventsNlabel_crop = [eventsNlabel_crop; eventsNlabel_crop_n];
        events_n = eventsNlabel_crop_n;

    elseif i>=crop_start2 && i<=crop_end2
        eventsNlabel_crop_n = [];
        temp_e = cell_all{i};

        temp_indicies = 1:N_events_per_ICP:length(temp_e);
        for temp_j = 1:length(temp_indicies)-1
            temp_ind_start = temp_indicies(temp_j);
            temp_ind_end = temp_indicies(temp_j+1)-1;

            % remove the bind area
            temp_e_n = temp_e(temp_ind_start:temp_ind_end,:);
            [m,n] = find(temp_e_n(:,6)>0);
            m_max = max(temp_e_n(m,1));
            n_min = min(temp_e_n(m,2));
            n_max = max(temp_e_n(m,2));

            for mn =1:length(temp_e_n)
                if temp_e_n(mn,2)<=n_max%temp_e_n(mn,2)>=n_min %&& temp_e_n(mn,2)<=n_max %&& temp_e_n(mn,2)>=n_min
                    eventsNlabel_crop_n = [eventsNlabel_crop_n; temp_e_n(mn,:)];
                end
            end 
        end
        eventsNlabel_crop_n_cell{i} = eventsNlabel_crop_n;
        eventsNlabel_crop = [eventsNlabel_crop; eventsNlabel_crop_n];
        events_n = eventsNlabel_crop_n;
    elseif i>=crop_start3 && i<=crop_end3
        eventsNlabel_crop_n = [];
        temp_e = cell_all{i};

        temp_indicies = 1:N_events_per_ICP:length(temp_e);
        for temp_j = 1:length(temp_indicies)-1
            temp_ind_start = temp_indicies(temp_j);
            temp_ind_end = temp_indicies(temp_j+1)-1;

            % remove the bind area
            temp_e_n = temp_e(temp_ind_start:temp_ind_end,:);
            [m,n] = find(temp_e_n(:,6)>0);
            m_max = max(temp_e_n(m,1));
            n_min = min(temp_e_n(m,2));
            n_max = max(temp_e_n(m,2));

            for mn =1:length(temp_e_n)
                if temp_e_n(mn,2)<=n_max && temp_e_n(mn,1) <= m_max%temp_e_n(mn,2)>=n_min %&& temp_e_n(mn,2)<=n_max %&& temp_e_n(mn,2)>=n_min
                    eventsNlabel_crop_n = [eventsNlabel_crop_n; temp_e_n(mn,:)];
                end
            end 
        end
        eventsNlabel_crop_n_cell{i} = eventsNlabel_crop_n;
        eventsNlabel_crop = [eventsNlabel_crop; eventsNlabel_crop_n];
        events_n = eventsNlabel_crop_n;
        
    else
        events_n = cell_all{i};
    end
    eventsNlabel_cropped_all = [eventsNlabel_cropped_all; events_n]; 
    cell_croped_all{i} = events_n;
end
events_cell = cell_croped_all;

event_labeled = eventsNlabel_cropped_all;
eventsNlabel_cropped_all(end,4)-eventsNlabel_cropped_all(1,4)
