function [ ] = plot_pca( data_vec, basis_vec)
%PLOT_PCA Plot projection of data in the specified vector space

dim = size(basis_vec,2);

if dim > 3
    disp('Maximum dimensionality 3. Cant Plot more than those dimensions.')
    return
end


pca_points_x = data_vec * basis_vec(:,1);

if dim > 1
    pca_points_y = data_vec * basis_vec(:,2);
end

if dim > 2
    pca_points_z = data_vec * basis_vec(:,3);
end

if dim > 2
    scatter3(pca_points_x,pca_points_y, pca_points_z)
elseif dim > 1
    scatter(pca_points_x, pca_points_y)
else
    stem(pca_points_x)

end

