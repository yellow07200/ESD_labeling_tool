The Matlab codes in this repository are the implementation of automatic labeling approach for asynchronous events data proposed in paper "A Neuromorphic Dataset for Object Segmentation in Indoor Cluttered Environment".

## Cite the article:
Huang, X., Sanket, K., Ayyad, A., Naeini, F. B., Makris, D., & Zweiri, Y. (2023). A Neuromorphic Dataset for Object Segmentation in Indoor Cluttered Environment. arXiv preprint arXiv:2302.06301.

## Dataset repository:
https://github.com/yellow07200/ESD

## Visualization
RGB frame:

<img src="https://github.com/yellow07200/ESD_labeling_tool/blob/main/examples/RGB.png" width=40% height=40%>

Annotated mask:

<img src="https://github.com/yellow07200/ESD_labeling_tool/blob/main/examples/Mask.png" width=40% height=40%>

Annotated events:

![1](https://github.com/yellow07200/ESD_labeling_tool/blob/main/examples/10_obj_1speed_linear_goodlight_082height_left_.gif)



## Dataset structure:

    |-- ESD-1 (training)
        |-- conditions_1
            |-- RGB
                |-- images                   (raw RGB images)
                |-- masks                    (annotated masks)
            |-- events
                |-- left.mat                 (events info from left event camera, RGBD info, camera's movement info)
                |-- right.mat                (events info from right event camera, RGBD info, camera's movement info)
                |-- events_frame.mat         (synchronous left and right image frames tranformed from RGBD coordinate)
                |-- mask_events_frame.mat    (synchronous left and right masks tranformed from RGBD coordinate)
        |-- conditions_2
            |-- ...
        ...

    |-- ESD-2 (testing)
        |-- conditions_1
            |-- RGB
                |-- images
                |-- masks
            |-- events
                |-- left.mat
                |-- right.mat
                |-- events_frame.mat
                |-- mask_events_frame.mat
        |-- conditions_2
            |-- ...
        ...
        
        

## Getting Started
execute the labeling_auto_clean_2.m file in Matlab
