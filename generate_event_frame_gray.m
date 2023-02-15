function im_mask_test = generate_event_frame_gray(t0, dt, events)
    ts_start = t0 - dt;
    ts_end = t0 + dt;

    im_mask_test = zeros(260, 346);

    for i = 1:length(events)
        x = events(i,1)+1;
        y = events(i,2)+1;
        if events(i,4)<=ts_end  && events(i,4)>ts_start
            im_mask_test(y,x) = 255; %209;
        end
    end

%     figure
%     imshow(im_mask_test)
%     imwrite(im_mask_test,'test.png')
end