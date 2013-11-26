pca_points_x = data_vec * coeff(:,1);
pca_points_y = data_vec * coeff(:,2);

figure
scatter(pca_points_x, pca_points_y)