function varargout = Somnography1(varargin)
% SOMNOGRAPHY1 M-file for Somnography1.fig
%      SOMNOGRAPHY1, by itself, creates a new SOMNOGRAPHY1 or raises the existing
%      singleton*.
%
%      H = SOMNOGRAPHY1 returns the handle to a new SOMNOGRAPHY1 or the handle to
%      the existing singleton*.
%
%      SOMNOGRAPHY1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOMNOGRAPHY1.M with the given input arguments.
%
%      SOMNOGRAPHY1('Property','Value',...) creates a new SOMNOGRAPHY1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Somnography1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Somnography1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Somnography1

% Last Modified by GUIDE v2.5 24-Feb-2012 21:13:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Somnography1_OpeningFcn, ...
                   'gui_OutputFcn',  @Somnography1_OutputFcn, ...
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

% --- Executes just before Somnography1 is made visible.
function Somnography1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Somnography1 (see VARARGIN)

% Choose default command line output for Somnography1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Somnography1.
%if strcmp(get(hObject,'Visible'),'off')
%    plot(rand(5));
%end

% UIWAIT makes Somnography1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Somnography1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
file = uigetfile('*.mat');
if ~isequal(file, 0)
    open(file);
    % C = textscan(file,'%s','delimiter','\n','whitespace','');

%To see the actual value of the cell array 'C' type the following
    newData = importdata(file);
    %handles.uitable1.Data
    %data=get(handles.uitable1,'Data')
    %data=get(handles.uitable1,'ColumnName')
    %data=get(handles.uitable1,'ColumnEditable')
    %data=get(handles.uitable1,'ColumnFormat')
    % select only the first 10 values
    [nrCol, sizeCol] = size(newData)
    %newData
    
    setGridProperties(nrCol, sizeCol, newData, handles)
    
end

function setGridProperties(aNrCol, aSizeCol, newData, handles)
% SETTING THE UITABLE PROPERTIES
    
    % init data for the ColumnName
    initColumnName = {'Selected', 'Type', 'Order', 'Low CutOff', 'High CutOff', 'Order(default)', 'Low CutOff(default)', 'High CutOff(default)'};
    
    % dynamically create the other column names
    newColumnName = initColumnName;
    for i = 1:aSizeCol
        newColumnName = cat(2, newColumnName, {strcat('Data row_', int2str(i))});
    end
    % set the column names
    set(handles.uitable1,'ColumnName', newColumnName);
    
    
    
    % set the rows
    initRowName = {};
    newRowName = initRowName;
    for i = 1:aNrCol
        newRowName = cat(2, newRowName, {strcat('Time series_', int2str(i))});
    end
    % set the column names
    set(handles.uitable1,'RowName', newRowName);
    
    
    % set the data
    dummy = {};
    for i=1:aNrCol
        dummy = cat(1, dummy, {logical(0), ['Low Pass'], [25], [0.4], [0], [25], [0.4], [0]})
    end
    set(handles.uitable1,'Data', cat(2, dummy, newData))
    dummy
    
    set(handles.uitable1,'Visible', 'on')
    
    % set size of the main window and table
    %get(handles.figure1, 'Position')
    %initPositionMainW = [10, 20, 300, 20];
    %initPositionTable = [10, 20, 300, 10];
    
    %newPositionMainW = initPositionMainW;
    %newPositionTable = initPositionTable;
    
    %newPositionMainW(4) = 20 + sizeCol * 2.5; 
    %newPositionTable(4) = 10 + sizeCol * 2.5;
    %newPositionMainW
    %set(handles.figure1, 'Position', newPositionMainW)
    %set(handles.uitable1, 'Position', newPositionTable)
    %handles.table1.setData(new_data);
    %handles.table1.setColumnNames(new_colnames);
    %handles.table1.setVisible('on');
    % who('newData')
    %newData.data
    % newData{1, :}
    % newData{:, 1}
    %D.data
    %data
    %newData
    % set(hObject, 'Data',newData)

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


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
%if(isempty(event.Error))
          %   Index = eventdata.Indices(1); 
             %ColumnNames = get(src, 'ColumnName');
             %Propname = ColumnNames{Index}; 
           %  data=get(hObject,'Data'); % get the data cell array of the table
%cols=get(hObject,'ColumnFormat'); % get the column formats
%if strcmp(cols(eventdata.Indices(2)),'logical') % if the column of the edited cell is logical
%   if eventdata.EditData % if the checkbox was set to true
%       data{eventdata.Indices(1),eventdata.Indices(2)}=true; % set the
%       data value to true%
%   else % if the checkbox was set to false
%       data{eventdata.Indices(1),eventdata.Indices(2)}=false; % set the data value to false
%   end
%end
 % now set the table's data to the updated data cell array
 % data{eventdata.Indices(1), 1}
 % data{eventdata.Indices(1), 2}
 % data{eventdata.Indices(1), eventdata.Indices(2)}
 % data{eventdata.Indices(1), 1} = false;
 % eventdata.Indices(1)
 %            set(hObject,'Data',data);
%end
       


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in processbutton.
function processbutton_Callback(hObject, eventdata, handles)
% hObject    handle to processbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in setdefaultsbutton.
function setdefaultsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to setdefaultsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in editdefaultsbutton.
function editdefaultsbutton_Callback(hObject, eventdata, handles)
% hObject    handle to editdefaultsbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OptionsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OptionsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function SetDefaultsMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to SetDefaultsMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    result = questdlg('Are you sure you want to set all the filter parameters to their default values? This will erase all the changes you have so far.',...
    'Set default values!', 'Yes', 'No', 'Cancel');
    if strcmp(result, 'Yes') 
        doSetDefaultValues;
    end
    % Update handles structure..
    guidata(hObject, handles)



function doSetDefaultValues
    errordlg('Setting defaults failed..', 'Not implemented')


% --------------------------------------------------------------------
function EditDefaultsMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to EditDefaultsMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
errordlg('Editing defaults failed..', 'Not implemented')

    
 
    
    

% --------------------------------------------------------------------
function Process_Callback(hObject, eventdata, handles)
% hObject    handle to Process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uiopentool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiopentool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.mat');
if ~isequal(file, 0)
    open(file);
newData = importdata(file);
[nrCol, sizeCol] = size(newData)
   setGridProperties(nrCol, sizeCol, newData, handles)
    
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the figure size and position
Figure_Size = get(hObject, 'Position');

% Set the units of the Uitable to 'Normalized'
set(handles.uitable1,'units','normalized')
% Get its Position
Table_pos = get(handles.uitable1,'Position');
% Reset it so that it's width remains normalized relative to figure
set(handles.uitable1,'Position',...
    [Table_pos(1)-5 Table_pos(2)-5  Table_pos(3)-5 Table_pos(4)-5])


% Reposition GUI on screen
movegui(hObject, 'onscreen')
