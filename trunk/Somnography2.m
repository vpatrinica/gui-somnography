function varargout = Somnography2(varargin)
% SOMNOGRAPHY2 M-file for Somnography2.fig
%      SOMNOGRAPHY2, by itself, creates a new SOMNOGRAPHY2 or raises the existing
%      singleton*.
%
%      H = SOMNOGRAPHY2 returns the handle to a new SOMNOGRAPHY2 or the handle to
%      the existing singleton*.
%
%      SOMNOGRAPHY2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOMNOGRAPHY2.M with the given input arguments.
%
%      SOMNOGRAPHY2('Property','Value',...) creates a new SOMNOGRAPHY2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Somnography2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Somnography2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Somnography2

% Last Modified by GUIDE v2.5 27-Feb-2012 09:48:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Somnography2_OpeningFcn, ...
                   'gui_OutputFcn',  @Somnography2_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before Somnography2 is made visible.
function Somnography2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Somnography2 (see VARARGIN)

% Choose default command line output for Somnography2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes Somnography2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Somnography2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile('*.mat');
if ~isequal(file, 0)
    open(fullfile(path, file));
    % C = textscan(file,'%s','delimiter','\n','whitespace','');

%To see the actual value of the cell array 'C' type the following
    newData = importdata(fullfile(path, file));
    
    % select only the first 10 values
    [sizeCol, nrCol] = size(newData);
    %newData
    % set(handles.FileMenu, 'Userdata', strrep(file, '.mat', '_out.mat'))
    plotData(handles, newData, nrCol)    
end


function plotData(handles, data, nCol)
%
subplot(1,1,1,'Parent',handles.uipanel1)
for i = 1:nCol
    aPlot = subplot(nCol,1,i); 
    plot(abs(fft([data{:, i}])));
    ylabel(strcat('Data_', int2str(i)));
end

%subplot(3,1,1);
%plot(rand(10,1));
%subplot(3,1,2);
%plot(rand(10,1));
%subplot(3,1,3);
%plot(rand(10,1));



% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --------------------------------------------------------------------
function OptionsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OptionsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%TO DO
% Get the figure size and position
% Figure_Size = get(hObject, 'Position');
 %set(handles.Contact_Name,'units','characters');

% Set the units of the Uitable to 'Normalized'
 
% Get its Position
%Table_pos = get(handles.uitable1,'Position');
% Reset it so that it's width remains normalized relative to figure
%set(handles.uitable1,'Position',...
%    [Figure_Size(1) Figure_Size(2)  Figure_Size(3) Figure_Size(4)])
%set(handles.Contact_Name,'units','characters')
%set(handles.uitable1,'units','normalized');
% Reposition GUI on screen
 %movegui(hObject, 'onscreen')
 %movegui(hObject, 'onscreen')


% --------------------------------------------------------------------
function uiopentool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiopentool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile('*.mat');
if ~isequal(file, 0)
    open(fullfile(path, file));
    % C = textscan(file,'%s','delimiter','\n','whitespace','');

%To see the actual value of the cell array 'C' type the following
    newData = importdata(fullfile(path, file));
    
    % select only the first 10 values
    [sizeCol, nrCol] = size(newData);
    %newData
    % set(handles.FileMenu, 'Userdata', strrep(file, '.mat', '_out.mat'))
    plotData(handles, newData, nrCol)     
end

