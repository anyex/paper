function varargout = untitled(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;


guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


%创建选择信道模型的多选框
function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%创建通信距离输入框
function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%创建信号频率输入框
function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%创建移动端速度输入框
function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%创建多径模型时延输入框
function edit10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%创建多径模型平均功率输入框
function edit11_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% 开始仿真
function pushbutton4_Callback(hObject, eventdata, handles)
d=str2num(get(handles.edit7,'string'));%通信距离
fc=str2num(get(handles.edit8,'string'));%载波频率
delayTime=str2num(get(handles.edit10,'string'));%频率选择性多径模型的相关延迟时间[ns]
averagePower=str2num(get(handles.edit11,'string'));%%频率选择性多径模型的平均功耗[dB]
v=str2num(get(handles.edit9,'string'));%获取输入的移动端速度
output=get(handles.edit6,'value');%确定要输出的信道模型
wireChanle(d,fc,v,delayTime,averagePower,output,handles);%根据输入参数调用相关信道模型

