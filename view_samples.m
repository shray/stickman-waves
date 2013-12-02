for i = 1:size(X_samples,2)
    X_sam = X_samples{i};
    [Y_gplvm, ~] = gpRegress( K, X_gpdm, [theta(2) 1/theta(1) 1/theta(3)], centered_data, X_sam );
    Y_gplvm = Y_gplvm + repmat(data_mean(1,:),256,1);
    
    for j=1:size(Y_gplvm,1)                
        disp_stick(Y_gplvm(j,:), STICK_LENS)        
        pause(.01)        
    end
    close
end