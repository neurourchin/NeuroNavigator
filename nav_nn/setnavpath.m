savpath = 'C:\Users\turbotrack\Dropbox (MIT)\PD work\Presentations\Data\';
savpath2 = 'C:\Users\turbotrack\Dropbox (MIT)\PD work\Presentations\Data plots\';
dbpath = 'C:\Users\turbotrack\Dropbox (MIT)\';

if ~isempty(dir('c:\users\cm*'))
    savpath = 'C:\Users\cm\Dropbox\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\cm\Dropbox\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\cm\Dropbox\';
elseif ~isempty(dir('c:\users\turbourchin*'))
    savpath = 'C:\Users\turbourchin\Dropbox (MIT)\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\turbourchin\Dropbox (MIT)\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\turbourchin\Dropbox (MIT)\';
elseif ~isempty(dir('c:\users\coolio*'))
    savpath = 'C:\Users\coolio\Dropbox (MIT)\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\coolio\Dropbox (MIT)\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\coolio\Dropbox (MIT)\';
elseif ~isempty(dir('C:\Users\seaurch*'))
    savpath = 'C:\Users\seaurch\Dropbox (MIT)\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\seaurch\Dropbox (MIT)\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\seaurch\Dropbox (MIT)\';
elseif ~isempty(dir('C:\Users\Ni Ji'))
    savpath = 'C:\Users\Ni Ji\Dropbox (MIT)\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\Ni Ji\Dropbox (MIT)\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\Ni Ji\Dropbox (MIT)\';
elseif ~isempty(dir('C:\Users\seaur'))
    savpath = 'C:\Users\seaur\Dropbox (MIT)\PD work\Presentations\Data\';
    savpath2 = 'C:\Users\seaur\Dropbox (MIT)\PD work\Presentations\Data plots\';
    dbpath = 'C:\Users\seaur\Dropbox (MIT)\';
end

navpath = [dbpath 'ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\NavigationModels\'];
dtpath = [dbpath 'ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\NavigationModels\data\'];
plpath = [dbpath 'ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\NavigationModels\plots\'];