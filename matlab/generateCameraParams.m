% Auto-generated by cameraCalibrator app on 29-Apr-2021
%-------------------------------------------------------


% Define images to process
imageFileNames = {'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3984.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3985.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3986.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3987.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3989.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3990.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3991.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3992.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3994.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3995.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3996.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3997.JPEG',...
    'C:\Users\kveen\OneDrive\NTNU\Øvinger\Robotsyn\Robotsyn-Final-Project\iCloud Photos\Calib23\IMG_3999.JPEG',...
    };
% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 14;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
