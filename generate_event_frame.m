function im_mask_test = generate_event_frame(t0, dt, events) % [im_mask_test, initial_ind]
    ts_start = t0; % - dt;
    ts_end = t0 + dt;

    im_mask_test = zeros(260, 346, 3);
    count=0;
    count1=0;
    count2=0;
    
    events_t0 = 0;

    for i = 1:length(events)
        x = events(i,1)+1;
        y = events(i,2)+1;
        if events(i,4)<=ts_end  && events(i,4)>ts_start
            count = count + 1;
%             if count ==1
%                 initial_ind = i;
%             end

            if events(i,3)==1

                im_mask_test(y,x,1) = 255; %209;
                im_mask_test(y,x,2) = 0;%35;
                im_mask_test(y,x,3) = 0;%69;
                count1 = count1 + 1;
            elseif events(i,3) ==-1

                im_mask_test(y,x,1) = 0;%53;
                im_mask_test(y,x,2) = 255;%13;
                im_mask_test(y,x,3) = 0;%234;
                count2 = count2 + 1;
            end 

        end

    end
    count1
    count2

%     figure
%     imshow(im_mask_test)
%     imwrite(im_mask_test,'test.png')
    % imshow(label)

end