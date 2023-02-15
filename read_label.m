%% read label
function mask = read_label(label_name)
    label = imread(label_name); 
%     imshow(label)
    mask = zeros(size(label,1), size(label,2));
    a1=0;a2=0;
%     0:125,5,10::
%     1:209,35,69::
%     2:53,13,234::
    [len] = size(label);
    if length(len) == 3
        for i=1:size(label,1)
            for j=1:size(label,2)
                v1=label(i,j,1);
                v2=label(i,j,2);
                v3=label(i,j,3);

                if v1==51 && v2==221 && v3==255
                    mask(i,j)=1;
                    a1=a1+1;
                elseif v1==250 && v2==50 && v3==83
                    mask(i,j)=2;
                    a2=a2+1;
                elseif v1==52 && v2==209 && v3==183
                    mask(i,j)=3;
                elseif v1==255 && v2==0 && v3==124
                    mask(i,j)=4;
                elseif v1==255 && v2==96 && v3==55
                    mask(i,j)=5;
                elseif v1==221 && v2==255 && v3==51
                    mask(i,j)=6;
                elseif v1==36 && v2==179 && v3==83
                    mask(i,j)=7;
                elseif v1==184 && v2==61 && v3==245
                    mask(i,j)=8;
                elseif v1==102 && v2==255 && v3==102
                    mask(i,j)=9;
%                 elseif v1==255 && v2==204 && v3==51
                elseif v1==50 && v2==183 && v3==250
                    mask(i,j)=10;
                else
                    mask(i,j)=0;
                end
% 1:51,221,255::
% 10:255,204,51::
% 2:250,50,83::
% 3:52,209,183::
% 4:255,0,124::
% 5:255,96,55::
% 6:221,255,51::
% 7:36,179,83::
% 8:184,61,245::
% 9:102,255,102::

%-------------------ESD-2 test-------------------------%
%                 if v1==240 && v2==120 && v3==240     %
%                     mask(i,j)=1;                     %
%                     a1=a1+1;
%                 elseif v1==42 && v2==125 && v3==209
%                     mask(i,j)=2;
%                     a2=a2+1;
%                 elseif v1==178 && v2==80 && v3==80
%                     mask(i,j)=3;
%                 elseif v1==204 && v2==51 && v3==102
%                     mask(i,j)=4;
%                 elseif v1==204 && v2==153 && v3==51
%                     mask(i,j)=5;
%                 else
%                     mask(i,j)=0;
%                 end
%-------------------------------------------------------%                
            end
        end
    elseif length(len) == 2
        lb = unique(label);
        mask = label;
%         mask = zeros(480, 640);
%         for i=1:length(lb)
%             [c,r]=find(label==lb(i));
%             mask(c,r) = i-1;
%         end
%         unique(mask)
    else 
        disp('wrong dimension of label read!');
    end
        

end