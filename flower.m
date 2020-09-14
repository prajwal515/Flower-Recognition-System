function varargout = flower(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flower_OpeningFcn, ...
                   'gui_OutputFcn',  @flower_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



function flower_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);





function varargout = flower_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
    [filename, pathname]=uigetfile('*.jpg','pick an image');
        if isequal(filename,0) || isequal(pathname,0)
            disp('User passed cancel')
        else
            filename=strcat(pathname,filename);
        a=imread(filename);
        axes(handles.axes1);
        imshow(a);
        handles.a=a;
        end
    guidata(hObject,handles);



function pushbutton2_Callback(hObject, eventdata, handles)
Image= handles.a;
th = graythresh(Image);
        Image_binarise = im2bw(Image,th);
       
        [nonZeroRows nonZeroColumns] = find(Image_binarise==0);
       
        topRow = min(nonZeroRows(:));
        bottomRow = max(nonZeroRows(:));
        leftColumn = min(nonZeroColumns(:));
        rightColumn = max(nonZeroColumns(:));
        
        
        croppedImage = Image_binarise(topRow:bottomRow, leftColumn:rightColumn);
        
        
        uint8Image = uint8(255 * Image_binarise);
    axes(handles.axes2);
    imshow(uint8Image);
    handles.a=uint8Image;
        
guidata(hObject,handles);
function pushbutton3_Callback(hObject, eventdata, handles)

DatabasePath = 'E:\cvpr\CVPR flower detection\crop img\';
     NumberOfClasses = 4;
     NumberOfSamplesPerClass = 30;
     NumberOfTrainingSamples = 30;
     
     NumberOfTestingSamples = 1;
     ClasswiseLbpFeatures = [];
     for index1 = 1 : NumberOfClasses             
         for index2 = 1 : NumberOfSamplesPerClass
           
             Image = imread(sprintf('%s%d\\%d.jpg',DatabasePath, index1, index2));
             
               LbpFeatures(index2,:)=extractLBPFeatures(Image);
               
         end
         
            
         ClasswiseLbpFeatures= cat(1,ClasswiseLbpFeatures,LbpFeatures);
     end
     
      k = 1;
      k1 = 1;
      k2 = 1;
      NumberOfFeaturesLbp = size(ClasswiseLbpFeatures,2);
   
      for index1 = 1 : NumberOfClasses
         for index2 = 1 : NumberOfTrainingSamples
             TrainingSetLbp(k1,1:NumberOfFeaturesLbp) = ClasswiseLbpFeatures(k,:);        
              TrainingSetLbp(k1,NumberOfFeaturesLbp+1)=index1;
              k = k + 1;
              k1 = k1 + 1;
          end
          
      end
     TestingSetLbp= extractLBPFeatures(handles.a);
     [ObtainedLabelLbp, TocVauleLbp] = KNN(TrainingSetLbp,TestingSetLbp,2,1)


     Label = [];
     for index1 = 1 : NumberOfClasses
         Label = cat(1,Label, ones(NumberOfTestingSamples,1)*index1);  
     end
     
     TempLbp = (ObtainedLabelLbp-Label);

     
     
     AccuracyLbp = ((size(find(TempLbp == 0),1))/(NumberOfClasses*NumberOfTestingSamples))*100;
     
     
