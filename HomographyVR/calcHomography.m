function [H] = calcHomography(srcPts,dstPts)

mat_A = zeros(2*size(srcPts,2) ,9);
            
% compute homography
for i=1:1:size(srcPts,2)
    % construct sub-matrix
    u = srcPts(1,i);
    v = srcPts(2,i);
    u_dash = dstPts(1,i);
    v_dash = dstPts(2,i);

    sub_mat_A = [0 0 0 -u -v -1 v_dash*u v_dash*v v_dash;
                 u v 1 0 0 0 -u_dash*u -u_dash*v -u_dash];
    mat_A((i*2)-1: i*2,:) = sub_mat_A;
end

[U,S,V] = svd(mat_A);

h_extracted = V(:,9);
H = [h_extracted(1) h_extracted(2)  h_extracted(3);
     h_extracted(4) h_extracted(5)  h_extracted(6);
     h_extracted(7) h_extracted(8)  h_extracted(9)]; 

end

