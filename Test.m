function varargout = Test(varargin)
% TEST MATLAB code for Test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test

% Last Modified by GUIDE v2.5 04-Jun-2020 00:30:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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


% --- Executes just before Test is made visible.
function Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test (see VARARGIN)

% Choose default command line output for Test
handles.output = hObject;

% Update handles structure
opengl('save', 'software');
setGlobalx(1);
set(gcf,'name','System Response');
movegui('center');
guidata(hObject, handles);
clc
% UIWAIT makes Test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
function nValue_Callback(hObject, eventdata, handles)
% hObject    handle to nValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nValue as text
%        str2double(get(hObject,'String')) returns contents of nValue as a double


% --- Executes during object creation, after setting all properties.
function nValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mValue_Callback(hObject, eventdata, handles)
% hObject    handle to mValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mValue as text
%        str2double(get(hObject,'String')) returns contents of mValue as a double


% --- Executes during object creation, after setting all properties.
function mValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    
%setting a global variable for the enter button conditions
function setGlobalx(val)
global x
x = val;

function r = getGlobalx
global x
r = x;


function enterTag_Callback(hObject, eventdata, handles)
r = getGlobalx;
if r == 1
    
%getting the n & m from the editable text field

    handles.n = str2num(get(handles.nValue, 'string'));
    handles.m = str2num(get(handles.mValue, 'string'));
    
%error message for n > m

    if handles.m > handles.n
        msgbox('Error, m should be less than or equal n');

    else 
        setGlobalx(2);
        r=2;
        
%hiding the input fields

        set(handles.nValue, 'Visible', 'Off');
        set(handles.mValue, 'Visible', 'Off');
        set(handles.text2, 'Visible', 'Off');
        set(handles.text3, 'Visible', 'Off');
        
%creating a text and editable field for the user to enter the a-s and b-s values

        for i= handles.n+1 : -1 : 1
            handles.textA{i} = uicontrol('Style','text','String',sprintf('%s%d','a',i-1),'Position',[-70+(120*(handles.n-i+2))-50 191 60 20]);
            handles.A{i} = uicontrol('style','edit','Position',[-70+(120*(handles.n-i+2)) 191 60 20]);
        end
        for i= handles.m+1 : -1 : 1
            handles.textB{i} = uicontrol('Style','text','String',sprintf('%s%d','b',i-1),'Position',[-70+(120*(handles.m-i+2))-50 136 60 20]);
            handles.B{i} = uicontrol('style','edit','Position',[-70+(120*(handles.m-i+2)) 136 60 20]);
        end  
    end
elseif r == 2
   setGlobalx(3);
   r = 3;
   
%initializing the a-s and b-s array to zero

   handles.a=zeros(1,10);
   handles.b=zeros(1,10);

%creating a variable to carry the highest y coefficient
   
   handles.nthcoeff = str2double(get(handles.A{handles.n+1} , 'String'));
   
%store the a-s and b-s coefficient and delete the created fields
   
    for i= handles.n+1 : -1 : 1
        handles.a(i) = str2double(get(handles.A{i} , 'String'));
        delete(handles.A{i});
        delete(handles.textA{i});
    end
    for i= handles.m+1 : -1 : 1
        handles.b(i) = str2double( get(handles.B{i} , 'String'));
        delete(handles.B{i});
        delete(handles.textB{i});
    end

%show selection field of input
    
    set(handles.inputType, 'Visible', 'on');
    
    elseif r == 3
    setGlobalx(4);
    r=4;
    
%initializing the beta array to zeros
    
   handles.beta = zeros(1,4);
   
%calculating the beta and store it in the array
   
   if handles.n > 0
   handles.beta(1) = -handles.b(handles.n+1)/handles.a(handles.n+1);
   end
   
   if handles.n > 1
   handles.beta(2) =(1/handles.a(handles.n+1))*(-handles.b(handles.n)+(handles.a(handles.n)/handles.a(handles.n+1)*handles.b(handles.n+1)));
   end
   
   if handles.n > 2
   handles.beta(3) = (1/handles.a(handles.n+1))*(-handles.b(handles.n-1)-(handles.a(handles.n)/handles.a(handles.n+1))*(-handles.b(handles.n)+(handles.a(handles.n)/handles.a(handles.n+1)*handles.b(handles.n+1)))+(handles.a(handles.n-1)/handles.a(handles.n+1))*handles.b(handles.n+1));
   end 
   
   if handles.n > 3 
   handles.beta(4)=(1/handles.a(handles.n+1))*(-handles.b(handles.n-2)-(handles.a(handles.n)/handles.a(handles.n+1))*(-handles.b(handles.n-1)-(handles.a(handles.n)/handles.a(handles.n+1))*(-handles.b(handles.n)+(handles.a(handles.n)/handles.a(handles.n+1))*handles.b(handles.n+1))+(handles.a(handles.n-1)/handles.a(handles.n+1))*handles.b(handles.n+1)-(handles.a(handles.n-1)/handles.a(handles.n+1))*(-handles.b(handles.n)+(handles.a(handles.n)/handles.a(handles.n+1))*handles.b(handles.n+1))+(handles.a(handles.n-2)/handles.a(handles.n+1))*handles.b(handles.n+1)));
   end

%initializing the Matrices and calculating it
   
   A = zeros(handles.n);
    for r = 1 : handles.n
        for c = 1 : handles.n
         if r == handles.n
            A(handles.n,c) = -handles.a(c)/handles.nthcoeff;
         end
         if r == c-1
             A(r,c)=1;
         end
        end 
    end

   
   B = zeros(handles.n,1);
   
   B(handles.n,1) = (handles.b(1)+handles.a(handles.n)*handles.beta(handles.n))/handles.nthcoeff;
   
   for r= 1:handles.n-1
       B(r,1)=-handles.beta(r+1);
       B(handles.n,1) = B(handles.n,1) + (handles.a(r)*handles.beta(r))/handles.nthcoeff;       
   end

    
    C = zeros(1,handles.n);
    C(1,1) = 1;

    D(1,1) = -handles.beta(1); 

%displaying the matrices
    
    ff=figure ;
    UA=uicontrol('Style','text','String','A','Position',[30 320 30 30],'FontSize',20,'FontWeight','bold');
    TA=uitable(ff,'Data',A,'Position',[100 320 50*handles.n 20*handles.n+20]);
    set(TA,'ColumnName','','RowName','','ColumnWidth',{50});
    
    UB=uicontrol('Style','text','String','B','Position',[30 220 30 30],'FontSize',20,'FontWeight','bold');
    TB=uitable(ff,'Data',B,'Position',[100 200 50 20*handles.n+20]);
    set(TB,'ColumnName','','RowName','','ColumnWidth',{50});
   
    UC=uicontrol('Style','text','String','C','Position',[30 120 30 30],'FontSize',20,'FontWeight','bold');
    TC=uitable(ff,'Data',C,'Position',[100 120 50*handles.n 20+20]);
    set(TC,'ColumnName','','RowName','','ColumnWidth',{50});
    
    UD=uicontrol('Style','text','String','D','Position',[30 20 30 30],'FontSize',20,'FontWeight','bold');
    TD=uitable(ff,'Data',D,'Position',[100 20 50 20+20]);
    set(TD,'ColumnName','','RowName','','ColumnWidth',{50});
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 0.25 0.6]);
    movegui(ff,'center')
    set(gcf,'name','Matrices','numbertitle','off');
    
%setting the number of samples and the step between every sample
    
    N=100000;
    T=0.001;
    
%initializing the x-s array
    
    x1 = zeros(1,N);
    x2 = zeros(1,N);
    x3 = zeros(1,N);
    x4 = zeros(1,N);
    
%initializing the y array
    
    handles.y = zeros(1,N);
    
    x = {x1,x2,x3,x4};  
    
%initializing the first element of x
    
    for i=1:4
        x{i}(1) = 0;
    end
    
%initializing the time array
    
    t = (0:N-1)*T;

%initializing the y and I first element of the array

    handles.y(1) = 0;
    handles.I(1)= 0;
    
%update loop
    
    for k= 2:N
        for i= 1:handles.n
            if i == handles.n
            sum = B(handles.n,1);
                for j = 1 : handles.n-1        
                sum = sum + A(handles.n,j)*x{j}(k);
                end
            x{handles.n}(k) = (1/(1-T*A(handles.n,handles.n)))*(T*sum+x{handles.n}(k-1));
            else
                x{i}(k) = T*(x{i+1}(k-1)+B(i,1))+x{i}(k-1);
            end
        end
        handles.y(k) = x{1}(k) + D(1,1);
        handles.I(k) = (handles.y(k)-handles.y(k-1))/T;
    end
    handles.imp = zeros(1,2*N);
    handles.imp(1,N) = 1;
    timp =(-N+1:N);
    handles.step = zeros(1,N);
    for i =N:2*N
    handles.step(1,i) = 1;
    end
    
    f1=figure ;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 0.5 1]);
    movegui(f1,'east')
    set(gcf,'name','Input & output Plot','numbertitle','off');
    subplot(2,1,1);
    
    
    
    if handles.stepInput.Value == 1
        
%plots y

    plot (t+1,handles.y,'markersize',3,'linewidth',2);    
    title('step output')
    axis([min(t)-max(t)*0.1 max(t) min(handles.y) max(handles.y)*1.25])
    grid on;
    
%plots the step function
    
    subplot(2,1,2);
    tstep =(-N:N-1);
    plot (tstep,handles.step,'markersize',3,'linewidth',2);    
    title('Step')
    axis([min(tstep) max(tstep) 0 1.25])
    grid on;

    elseif handles.impulseInput.Value == 1
        
%plots y
        
    plot (t+1,handles.I,'markersize',3,'linewidth',2);
    title('Impulse output')
    axis([min(t)-max(t)*0.1 max(t) min(handles.I) max(handles.I)*1.25])
    grid on;
    
%plots the impulse function
    
    subplot(2,1,2);    
    stem (timp,handles.imp,'markersize',3,'linewidth',2);    
    title('Impulse')
    axis([min(timp) max(timp) min(handles.imp) max(handles.imp)*1.25])
    grid on;
    end
   
    f2=figure;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 0.5 1]);
    movegui(f2,'west');
    set(gcf,'name','X-s Plot','numbertitle','off')
    
%plots x-s
    
    for i=1:handles.n
        subplot(handles.n,1,i)
        plot(t,x{i},'linewidth',2)
        XText = strcat('X',num2str(i));
        title(XText)
        axis([min(t)-max(t)*0.1 max(t) min(x{i}) max(x{i})*1.25])
        grid on;
    end
    
%resetting the app
    
    set(handles.inputType, 'Visible', 'off');
    setGlobalx(1);
    r=1;
    set(handles.nValue, 'Visible', 'on','String','');
    set(handles.mValue, 'Visible', 'on','String','');
    set(handles.text2, 'Visible', 'on');
    set(handles.text3, 'Visible', 'on');
    grid ON

end

%updating the handles function

guidata(hObject, handles);
