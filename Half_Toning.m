File_Name='9.jpg';
Path = 'Images/';
RGB_Image=imread(strcat(Path, File_Name));                           % Import an image to matlab workspace
No_of_Levels=10;                                             % Determine the required number of levels
Gray_Scale_Image=rgb2gray(RGB_Image);   % Convert the imported image into a grayscale image
[rows,columns]=size(Gray_Scale_Image);      % Get the size

%% ==============================================================

% The following 3D matrix stores the equivalent values of each level as
% specified in the project discerption
Half_Toning_3D_Matrix= cat(3 , [0 0 0 ; 0 0 0 ; 0 0 0] , [0 1 0 ; 0 0 0 ; 0 0 0] , [0 1 0 ; 0 0 0 ; 0 0 1] , [1 1 0 ; 0 0 0 ; 0 0 1] , [1 1 0 ; 0 0 0 ; 1 0 1] , [1 1 1 ; 0 0 0 ; 1 0 1] , [1 1 1 ; 0 0 1 ; 1 0 1] , [1 1 1 ; 0 0 1 ; 1 1 1] , [1 1 1 ; 1 0 1 ; 1 1 1] , [1 1 1 ; 1 1 1 ; 1 1 1] );

% The following for loop shows the equivalent matrix for each level
%for i = 1 :10
%    subplot(2,5,i), imshow(Half_Toning_3D_Matrix(:,:,i))
%    title(strcat('Level',{' '},int2str(i-1)));  
%end

%% ==============================================================

% The following for loop scales the gray scale image into the desired scale
% level
for n=1:rows
    for m =1:columns
        Gray_Scale_Image_Scaled(n,m)=floor(Gray_Scale_Image(n,m)/floor(256/No_of_Levels));
        if (Gray_Scale_Image_Scaled(n,m)>(No_of_Levels-1))
            Gray_Scale_Image_Scaled(n,m)=(No_of_Levels-1);
        end
    end
end

%% ==============================================================

Half_Toned_Image= ones(3*rows,3*columns);       % Create a matrix to store the half toned image. Its size must be equal to image size multiplied by 9 

% The following for loop puts the equivalent matrix of each level in its
% correct location and stores it in output image.
for n=1:rows
    for m =1:columns
        n_scaled=1+3*(n-1);
        m_scaled=1+3*(m-1);
        Half_Toned_Image(n_scaled:(n_scaled+2),m_scaled:(m_scaled+2))=Half_Toning_3D_Matrix(:,:,Gray_Scale_Image_Scaled(n,m)+1);
    end
end


%% ==============================================================
% Show the result
%figure
%figure,subplot(1,1,1),imshow(Gray_Scale_Image);
%figure,subplot(1,1,1),imshow(Half_Toned_Image);
imwrite(Half_Toned_Image,strcat('Results/Half Toned ',File_Name));