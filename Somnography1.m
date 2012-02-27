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

% Last Modified by GUIDE v2.5 26-Feb-2012 16:42:30

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

defaultOptsFilters.lowpass = [25 0.3 0];
defaultOptsFilters.highpass = [25 0 0.7];
defaultOptsFilters.bandpass = [25 0.3 0.7];
defaultOptsFilters.bandstop = [25 0.3 0.7];

set(handles.SetDefaultsMenuItem,'UserData', defaultOptsFilters);


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
    newData = newData';
    % select only the first 10 values
    [nrCol, sizeCol] = size(newData);
    %newData
    set(handles.FileMenu, 'Userdata', strrep(file, '.mat', '_out.mat'))

    setGridProperties(nrCol, sizeCol, newData, handles)
    
end

function setGridProperties(aNrCol, aSizeCol, newData, handles)
% SETTING THE UITABLE PROPERTIES
    % TO DO the validity checking... 
    % init data for the ColumnName
    %newData = newData;
    
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
    
    
    % get the lowpass defaults...
    someOpts = get(handles.SetDefaultsMenuItem, 'UserData');
    
    dummy = {logical(0), ['Low Pass'], [someOpts.lowpass(1)], [someOpts.lowpass(2)], [someOpts.lowpass(3)], [someOpts.lowpass(1)], [someOpts.lowpass(2)], [someOpts.lowpass(3)]};

    % set the data
    initTableData = {};
    for i=1:aNrCol
        initTableData = cat(1, initTableData, dummy);
    end
    set(handles.uitable1,'Data', cat(2, initTableData, newData));
    
    
    
    
    info.newData = newData;
    info.lowpass = someOpts.lowpass;
    info.highpass = someOpts.highpass;
    info.bandpass = someOpts.bandpass;
    info.bandstop = someOpts.bandstop;
    set(handles.uitable1,'UserData',info)
    
    
    set(handles.uitable1,'Visible', 'on')
    set(handles.uiprocesstool,'Enable', 'on')
    
    
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

data = get(hObject,'Data'); % get the data cell array of the table

% now set the table's data to the updated data cell array
 
 % if the filter is low pass
 
colNames = get(hObject,'ColumnName');

if strcmp(colNames{eventdata.Indices(2)}, 'Order')
    if (data{eventdata.Indices(1), eventdata.Indices(2)} < 1) || (data{eventdata.Indices(1), eventdata.Indices(2)} > 1000) || isnan(data{eventdata.Indices(1), eventdata.Indices(2)})
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    end
end

% Stays 0 the Low Pass/bandPass 
if strcmp(colNames{eventdata.Indices(2)}, 'Low CutOff') && strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-3}, 'High Pass')
    %if  isnan(data{eventdata.Indices(1), eventdata.Indices(2)})
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    %end
end

if strcmp(colNames{eventdata.Indices(2)}, 'High CutOff') && strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-3}, 'Low Pass')
    %if  isnan(data{eventdata.Indices(1), eventdata.Indices(2)})
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    %end
end




%nonnegativity of the low pass/ band pass and < 1 and NaN

if strcmp(colNames{eventdata.Indices(2)}, 'Low CutOff') || strcmp(colNames{eventdata.Indices(2)}, 'High CutOff') 
    if  isnan(data{eventdata.Indices(1), eventdata.Indices(2)}) || (data{eventdata.Indices(1), eventdata.Indices(2)}<=0) || (data{eventdata.Indices(1), eventdata.Indices(2)}>=1)
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    end
end


%  order of the frequencies for the band pass/stop


if strcmp(colNames{eventdata.Indices(2)}, 'Low CutOff') && (strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-2}, 'Band Pass') || strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-2}, 'Band Stop'))
    if  (data{eventdata.Indices(1), eventdata.Indices(2)}>=data{eventdata.Indices(1), eventdata.Indices(2)+1} )
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    end
end

if strcmp(colNames{eventdata.Indices(2)}, 'High CutOff') && (strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-3}, 'Band Pass') || strcmp(data{eventdata.Indices(1), eventdata.Indices(2)-3}, 'Band Stop'))
    if   (data{eventdata.Indices(1), eventdata.Indices(2)}<=data{eventdata.Indices(1), eventdata.Indices(2)-1} )
        data{eventdata.Indices(1), eventdata.Indices(2)} = eventdata.PreviousData;
    end
end


 info = get(handles.uitable1, 'UserData');
 if strcmp(data{eventdata.Indices(1), eventdata.Indices(2)}, 'Low Pass')

    data{eventdata.Indices(1), eventdata.Indices(2)+4} = info.lowpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+1} = info.lowpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+5} = info.lowpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+2} = info.lowpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+6} = info.lowpass(3);
    data{eventdata.Indices(1), eventdata.Indices(2)+3} = info.lowpass(3);
 end
 if strcmp(data{eventdata.Indices(1), eventdata.Indices(2)}, 'High Pass')

    data{eventdata.Indices(1), eventdata.Indices(2)+4} = info.highpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+1} = info.highpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+5} = info.highpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+2} = info.highpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+6} = info.highpass(3);
    data{eventdata.Indices(1), eventdata.Indices(2)+3} = info.highpass(3);
 end
 if strcmp(data{eventdata.Indices(1), eventdata.Indices(2)}, 'Band Pass')

    data{eventdata.Indices(1), eventdata.Indices(2)+4} = info.bandpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+1} = info.bandpass(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+5} = info.bandpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+2} = info.bandpass(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+6} = info.bandpass(3);
    data{eventdata.Indices(1), eventdata.Indices(2)+3} = info.bandpass(3);
 end
 if strcmp(data{eventdata.Indices(1), eventdata.Indices(2)}, 'Band Stop')

    data{eventdata.Indices(1), eventdata.Indices(2)+4} = info.bandstop(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+1} = info.bandstop(1);
    data{eventdata.Indices(1), eventdata.Indices(2)+5} = info.bandstop(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+2} = info.bandstop(2);
    data{eventdata.Indices(1), eventdata.Indices(2)+6} = info.bandstop(3);
    data{eventdata.Indices(1), eventdata.Indices(2)+3} = info.bandstop(3);
 end

set(hObject,'Data',data);

       


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


% --------------------------------------------------------------------
function SetDefaultsMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to SetDefaultsMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    result = questdlg('Are you sure you want to set all the filter parameters to their default values? This will erase all the changes you have so far.',...
    'Set default values!', 'Yes', 'No', 'Yes');
    if strcmp(result, 'Yes') 
        doSetDefaultValues(handles);
    end
    % get the default value for the low pas
    
    % GetDefaultOptsLowPas(handles)
    % Update handles structure..
    guidata(hObject, handles)
    



function doSetDefaultValues(handles)
    % errordlg('Setting defaults failed..', 'Not implemented')
    someOpts = get(handles.SetDefaultsMenuItem, 'UserData');
    % loop over the data in the table
    tableData = get(handles.uitable1, 'Data');
    [nrRows, nrCols] = size(tableData);
    for i = 1:nrRows
        if strcmp(tableData{i, 2}, 'Low Pass')
            tableData{i, 3} = someOpts.lowpass(1);
            tableData{i, 4} = someOpts.lowpass(2);
            tableData{i, 5} = someOpts.lowpass(3);
        end
        if strcmp(tableData{i, 2}, 'High Pass')
            tableData{i, 3} = someOpts.highpass(1);
            tableData{i, 4} = someOpts.highpass(2);
            tableData{i, 5} = someOpts.highpass(3);
        end
        if strcmp(tableData{i, 2}, 'Band Pass')
            tableData{i, 3} = someOpts.bandpass(1);
            tableData{i, 4} = someOpts.bandpass(2);
            tableData{i, 5} = someOpts.bandpass(3);
        end
        if strcmp(tableData{i, 2}, 'Band Stop')
            tableData{i, 3} = someOpts.bandstop(1);
            tableData{i, 4} = someOpts.bandstop(2);
            tableData{i, 5} = someOpts.bandstop(3);
        end
    end
    set(handles.uitable1, 'Data', tableData);


    
    
    
    
function [answer] = showPromptDefaults(handles);
%
prompt={'Enter the default order for the Low Pass:',...
        'Enter the default low CutOff Frequency:',...
        'Enter the default order for the High Pass:',...
        'Enter the default high CutOff Frequency:',...
        'Enter the default order for the Band Pass:',...
        'Enter the default low CutOff Frequency:',...
        'Enter the default high CutOff Frequency:',...
        'Enter the default order for the Low Pass:',...
        'Enter the default low CutOff Frequency:',...
        'Enter the default high CutOff Frequency:'};
name='Input the default filter parameters';
numlines=1;
oldDefaultsMenu = get(handles.SetDefaultsMenuItem, 'UserData');
defaultanswer={num2str(oldDefaultsMenu.lowpass(1)), num2str(oldDefaultsMenu.lowpass(2)), ...
    num2str(oldDefaultsMenu.highpass(1)), num2str(oldDefaultsMenu.highpass(3)), ...
    num2str(oldDefaultsMenu.bandpass(1)), num2str(oldDefaultsMenu.bandpass(2)), num2str(oldDefaultsMenu.bandpass(3)), ...
    num2str(oldDefaultsMenu.bandstop(1)), num2str(oldDefaultsMenu.bandstop(2)), num2str(oldDefaultsMenu.bandstop(3))};
answer = inputdlg(prompt,name,numlines,defaultanswer);


%function doUpdateDefaultValues
%    errordlg('Setting defaults failed..', 'Not implemented')    
    
% --------------------------------------------------------------------
function EditDefaultsMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to EditDefaultsMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% errordlg('Editing defaults failed..', 'Not implemented')
% doUpdateDefaultValues

boolContinue = 1;

while boolContinue
    newVals = showPromptDefaults(handles);
    boolContinue = checkDefaults(newVals);
end

[newVals_x, newVals_y] = size(newVals);

if newVals_y>0
    % set the defaults
    oldDefaultsTable = get(handles.uitable1, 'UserData');
    oldDefaultsMenu = get(handles.SetDefaultsMenuItem, 'UserData');
    
    optsTableData = get(handles.uitable1, 'Data');
    [numRow, numCol] = size(optsTableData);
    oldDefaultsMenu.lowpass(1) = str2num(char(newVals(1)));
    oldDefaultsTable.lowpass(1) = str2num(char(newVals(1)));
  
    oldDefaultsMenu.lowpass(2) = str2num(char(newVals(2)));
    oldDefaultsTable.lowpass(2) = str2num(char(newVals(2)));
    oldDefaultsMenu.highpass(1) = str2num(char(newVals(3)));
    oldDefaultsTable.highpass(1) = str2num(char(newVals(3)));
    oldDefaultsMenu.highpass(3) = str2num(char(newVals(4)));
    oldDefaultsTable.highpass(3) = str2num(char(newVals(4)));
    oldDefaultsMenu.bandpass(1) = str2num(char(newVals(5)));
    oldDefaultsTable.bandpass(1) = str2num(char(newVals(5)));
    oldDefaultsMenu.bandpass(2) = str2num(char(newVals(6)));
    oldDefaultsTable.bandpass(2) = str2num(char(newVals(6)));
    oldDefaultsMenu.bandpass(3) = str2num(char(newVals(7)));
    oldDefaultsTable.bandpass(3) = str2num(char(newVals(7)));
    oldDefaultsMenu.bandstop(1) = str2num(char(newVals(8)));
    oldDefaultsTable.bandstop(1) = str2num(char(newVals(8)));
    oldDefaultsMenu.bandstop(2) = str2num(char(newVals(9)));
    oldDefaultsTable.bandstop(2) = str2num(char(newVals(9)));
    oldDefaultsMenu.bandstop(3) = str2num(char(newVals(10)));
    oldDefaultsTable.bandstop(3) = str2num(char(newVals(10)));
    for i = 1:numRow
        if strcmp(optsTableData{i, 2}, 'Low Pass')
            optsTableData{i, 6} = oldDefaultsMenu.lowpass(1);
            optsTableData{i, 7} = oldDefaultsMenu.lowpass(2);
        end
         if strcmp(optsTableData{i, 2}, 'High Pass')
            optsTableData{i, 6} = oldDefaultsMenu.highpass(1);
            optsTableData{i, 8} = oldDefaultsMenu.highpass(2);
         end
         if strcmp(optsTableData{i, 2}, 'Band Pass')
            optsTableData{i, 6} = oldDefaultsMenu.bandpass(1);
            optsTableData{i, 7} = oldDefaultsMenu.bandpass(2);
            optsTableData{i, 8} = oldDefaultsMenu.bandpass(3);
         end
        if strcmp(optsTableData{i, 2}, 'Band Stop')
            optsTableData{i, 6} = oldDefaultsMenu.bandstop(1);
            optsTableData{i, 7} = oldDefaultsMenu.bandstop(2);
            optsTableData{i, 8} = oldDefaultsMenu.bandstop(3);
        end
        
    end
    set(handles.uitable1, 'Data', optsTableData);
    set(handles.uitable1, 'UserData', oldDefaultsTable);
    set(handles.SetDefaultsMenuItem, 'UserData', oldDefaultsMenu);
end



function result = checkDefaults(someAnswer)
% check the validity of the fields

result = 0;
[x, y]= size(someAnswer);
if (x == 0)
    result = 0;
end 

if (x > 0)

% hard check on all the params... 
% order numeric and >0
if length(str2num(char(someAnswer(1))))== 0 
    result = 1;return
end
if str2num(char(someAnswer(1)))<= 0 
    result = 1;return
end

if length(str2num(char(someAnswer(3))))== 0 
    result = 1;return
end
if str2num(char(someAnswer(3)))<= 0 
    result = 1;return
end

if length(str2num(char(someAnswer(5))))== 0 
    result = 1;return
end
if str2num(char(someAnswer(5)))<= 0 
    result = 1;return
end

if length(str2num(char(someAnswer(8))))== 0 
    result = 1;return
end
if str2num(char(someAnswer(8)))<= 0 
    result = 1;return
end


% lowpass/highpass lo/hi freq
if length(str2num(char(someAnswer(2))))== 0 
    result = 1;
    return
end
if ((str2num(char(someAnswer(2)))<= 0) || (str2num(char(someAnswer(2)))>=1))
    result = 1;return
end
if length(str2num(char(someAnswer(4))))== 0 
    result = 1;return
end
if (str2num(char(someAnswer(4)))<= 0) || (str2num(char(someAnswer(4)))>=1) 
    result = 1;return
end

% bandstop lo/hi freq
if length(str2num(char(someAnswer(9))))== 0 
    result = 1;return
end
if (str2num(char(someAnswer(9)))<= 0) || (str2num(char(someAnswer(9)))>=1)
    result = 1;return
end
if length(str2num(char(someAnswer(10))))== 0 
    result = 1;return
end
if (str2num(char(someAnswer(10)))<= 0) || (str2num(char(someAnswer(10)))>=1) || (str2num(char(someAnswer(10)))<= str2num(char(someAnswer(9))))
    result = 1;return
end



% bandpass lo/hi freq
if length(str2num(char(someAnswer(6))))== 0 
    result = 1;return
end
if (str2num(char(someAnswer(6)))<= 0) || (str2num(char(someAnswer(6)))>=1)
    result = 1;return
end
if length(str2num(char(someAnswer(7))))== 0 
    result = 1;return
end
if (str2num(char(someAnswer(7)))<= 0) || (str2num(char(someAnswer(7)))>=1) || (str2num(char(someAnswer(7)))<= str2num(char(someAnswer(6))))
    result = 1;return
end





end


% if the cancel button is given = > {}
    
    

% --------------------------------------------------------------------
function uiopentool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiopentool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.mat');
if ~isequal(file, 0)
    open(file);
newData = importdata(file);
newData = newData';
    % select only the first 10 values
    [nrCol, sizeCol] = size(newData);
    %newData
    set(handles.FileMenu, 'Userdata', strrep(file, '.mat', '_out.mat'))
%strrep(file, '.mat', '_out.mat');
setGridProperties(nrCol, sizeCol, newData, handles)


end


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
function uiprocesstool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiprocesstool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% errordlg('Editing defaults failed..', 'Not implemented')

infoData  = get(handles.uitable1, 'UserData');
processData = get(handles.uitable1, 'Data');
outputData = infoData.newData;
[nrSeries, nrCols] = size(processData);
[nrRows, nrColumns] = size(outputData);

for i=1:nrSeries
    if processData{i, 1}
        if strcmp(processData{i, 2}, 'Low Pass')
            

            h = fdesign.lowpass('N,Fc', processData{i, 3}, processData{i, 4});

            Hd = design(h, 'window');
            out = filter(Hd, [outputData{i, :}]);
            %outputData{i, :} = filter(Hd, [outputData{i, :}]);
            for j=1:nrColumns
                outputData{i, j} = out(1,j);
            end
            
        end
        
        if strcmp(processData{i, 2}, 'High Pass')
            

            h = fdesign.highpass('N,Fc', processData{i, 3}, processData{i, 5});

            Hd = design(h, 'window');
            out = filter(Hd, [outputData{i, :}]);
            for j=1:nrColumns
                outputData{i, j} = out(1,j);
            end
            
        end
        if strcmp(processData{i, 2}, 'Band Pass')
            

            h = fdesign.bandpass('N,Fc1,Fc2', processData{i, 3}, processData{i, 4},  processData{i, 5});

            Hd = design(h, 'window');
            out = filter(Hd, [outputData{i, :}]);
            for j=1:nrColumns
                outputData{i, j} = out(1,j);
            end
            
        end
        if strcmp(processData{i, 2}, 'Band Stop')
            

            h = fdesign.bandstop('N,Fc1,Fc2', processData{i, 3}, processData{i, 4},  processData{i, 5});

            Hd = design(h, 'window');
            out = filter(Hd, [outputData{i, :}]);
            for j=1:nrColumns
                outputData{i, j} = out(1,j);
            end
            
        end
    end
end

% save the processed info into a file...
 outputData = outputData';
 outFileName = get(handles.FileMenu, 'UserData');
 save(char(outFileName), 'outputData');



