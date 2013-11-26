pca_points_x = data_vec * coeff(:,1);
pca_points_y = data_vec * coeff(:,2);
pca_points_z = data_vec * coeff(:,3);

figure
scatter3(pca_points_x,pca_points_y, pca_points_z)