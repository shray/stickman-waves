for i = 40
    gp_vid = VideoWriter('gpdm_3.mp4');
    gp_vid.FrameRate = 10;
    open(gp_vid);
    
    X_sam = X_samples{i};
    [Y_gplvm, ~] = gpRegress( K, X_gpdm, [theta(2) 1/theta(1) 1/theta(3)], centered_data, X_sam );
    Y_gplvm = Y_gplvm + repmat(data_mean(1,:),256,1);
    
    for j=1:size(Y_gplvm,1)                
        disp_stick(Y_gplvm(j,:), STICK_LENS) 
        frame = getframe;writeVideo(gp_vid, frame);
        pause(.01)        
    end
    close
    gp_vid.close();
    
end