function [] = HomographyVR(fileName)

% load dataset 
load(fileName);
bookCover = rgb2gray(imread('bookCover.jpg'));
figure('Position', [100 50 1200 600]);
for i=1:1:size(images,3)
    
    % calculate homography
    [rows, cols] = size(bookCover);
    srcPts = [0 0 cols cols; 0 rows rows 0];
    dstPts= corners(:,:,i);
    
    H = calcHomography(srcPts,dstPts);
    tform = projective2d(H');
    warpedBook = imwarp(bookCover, tform, 'OutputView',imref2d(size(images(:,:,i))));
    
    videoFilter = (warpedBook == 0) ;
    videoEmpty = images(:,:,i).*uint8(videoFilter);
    
    VR_scene = videoEmpty+warpedBook;
    
    % visualization
    subplot(2,2,1); 
    imshow(images(:,:,i)); 
    title('Tracking (MTF)'); hold on;
    line([corners(1,:,i) corners(1,1,i)], [corners(2,:,i) corners(2,1,i)], 'Color', 'r', 'LineWidth', 2); 
    
    subplot(2,2,2); 
    imshow(bookCover); title ('Book Cover'); 
    
    subplot(2,2,3);
    imshow(warpedBook); title ('Warped Book Cover');
    
    subplot(2,2,4);
    imshow(VR_scene); title('VR');
    
    pause(0.0001);
end

end

