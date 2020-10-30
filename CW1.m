load('CT projections.mat')
load('CT projections modified.mat')

%task 1
img = squeeze(projections(100,:,:));%select 100th axial position
img_f = iradon(img,0:179); %filtered backprojection
img_uf = iradon(img,0:179,'none');%unfiltered back projection
figure('NumberTitle', 'off', 'Name', 'Task 1');
subplot(1,2,1)
imagesc(img_f),colormap gray,title('Filtered')
subplot(1,2,2)
imagesc(img_uf),colormap gray,title('Unfiltered');

%task 2
img_45 = iradon(img(:,1:45),0:44); %backprojection with 1 to 45 degrees
img_equ = iradon(img(:,1:4:180), 0:4:179); %backproject with angles equally spaced 
figure('NumberTitle', 'off', 'Name', 'Task 2');
subplot(1,2,1)
imagesc(img_45),colormap gray,title('1-45 degree')
subplot(1,2,2)
imagesc(img_equ),colormap gray,title('angles equally space');

%task 3
img_b = squeeze(blurredprojections(100,:,:));
img_b_f = iradon(img_b,0:179); %filtered blur image
edge1=edge(img_b_f,'Canny',0.2); %detect the edge of filtered blur image
edge1=0.08*double(edge1); %scale down the value of edge to fit the blur image
kernel = [-2, -2, -2; -2, 49, -2; -2, -2, -2]/ 9; %sharpen kernel
img_b_f_c = conv2(img_b_f,kernel,'same');%convolution the image with kernel and keep the size as origial
img_b_f_c_s = imsharpen(img_b_f_c,'Radius',0.5,'Amount',20);%apply unsharp masking
img_b_f_c_s2 = imsharpen(img_b_f_c,'Radius',0.5,'Amount',30);%apply a bigger amount to see difference
figure('NumberTitle', 'off', 'Name', 'Sharpen');
subplot(2,3,1)
imagesc(img_f),colormap gray,title('ground truth')
subplot(2,3,2)
imagesc(img_b_f),colormap gray,title('modified')
subplot(2,3,3)
imagesc(img_b_f_c),colormap gray,title('convolution with kernel')
subplot(2,3,4)
imagesc(img_b_f_c_s),colormap gray,title('apply unshrp masking')
subplot(2,3,5)
imagesc(img_b_f_c_s2),colormap gray,title('increase the amount of sharpening')
subplot(2,3,6)
imagesc(img_b_f_c_s2+edge1),colormap gray,title('outline the edge of the modified image');%add sharpen result with detected edge