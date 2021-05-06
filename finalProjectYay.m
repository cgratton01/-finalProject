function [] = finalProjectYay()
close all;
global gui

    gui.fig = figure('position',[500 300 600 420],'numbertitle','off','name','finalProjectYay'); %creates pop up window
    
    gui.titleText = uicontrol('style','text','position',[20 370 50 20],'string','Plot Title:','horizontalalignment','right'); %creates plot tital label
    gui.titleEdit = uicontrol('style','edit','position',[80 370 100 20]);                                                       % creates plot title input box
    
    gui.xDataText = uicontrol('style','text','position',[180 370 50 20],'string','X Values:','horizontalalignment','right'); %creates x value box title
    gui.xDataEdit = uicontrol('style','edit','position',[240 370 100 20]);                                              %creates x value input box 
    
    gui.yDataText = uicontrol('style','text','position',[340 370 50 20],'string','Y Values:','horizontalalignment','right'); %creates y value box title
    gui.yDataEdit = uicontrol('style','edit','position',[400 370 100 20]);                                                  %creates y value input box               
    
    gui.xLabelText = uicontrol('style','text','position',[180 320 50 20],'string','X Label:','horizontalalignment','right'); %creates x label box title
    gui.xLabelEdit = uicontrol('style','edit','position',[240 320 100 20]);                                                     %creates x label input box
    
    gui.yLabelText = uicontrol('style','text','position',[340 320 50 20],'string','Y Label:','horizontalalignment','right'); %creates y label box title
    gui.yLabelEdit = uicontrol('style','edit','position',[400 320 100 20]);                                                    %creates y label input box
    
    
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0 0.6 .15 .25],'selectionchangedfcn',{@radioSelect}); % creates button group for colors and sets the callback function
    gui.r1 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','r');
    gui.r2 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','b');
    gui.r3 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','g'); 
    
    gui.buttonGroup2 = uibuttongroup('visible','on','units','normalized','position',[0.13 0.6 .15 .25],'selectionchangedfcn',{@radioSelect2}); % same as the one above but changes shape of the point
    gui.r4 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','o');
    gui.r5 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','x');
    gui.r6 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','*');
    
    
    
    gui.checkXY = uicontrol('style','text','position',[20 390 400 20],'string','fill out feilds then select plot','horizontalalignment','left');% creates the text at the top that tells you if your x and y match
    
    gui.p = plot(0,0);
    gui.p.Parent.Position = [.1 .1 .8 .450]; % creates plot and chooses position
    
    gui.button = uicontrol('style','pushbutton','position',[530 260 50 30],'string','Plot'); % creates the plot button
    gui.button.String = 'Plot';  % names plot button
    gui.button.Callback = {@plotDataCallback,gui}; % sets call back for when plot button is pressed
    gui.resetButton = uicontrol('style','pushbutton','units','normalized','position',[.1 .6 .8 .3],'string','Reset','FontSize',90,'callback',{@reset}); % creates giant reset button and sets call back for when pressed
gui.resetButton.Visible = 'off'; % makes reset button invisible
   
end

function [] = radioSelect(~,~) % push button function defines what the word type means 
    global gui;
    type = gui.buttonGroup.SelectedObject.String;
    plotSelectedColor(type); % calls the function plotSelectedColor with type holing the selected color
    
end

function [] = radioSelect2(~,~) % same as above but with the shape
    global gui;
    type2 = gui.buttonGroup2.SelectedObject.String;
    plotSelectedPoint(type2);
end
function [c] = plotSelectedColor(type) % determines which color you have selected and stores your selection under variable "c"
   
    c = 'r';
    if strcmp(type,'b')
      c = 'b';
    elseif strcmp(type,'g')
       c = 'g';
    end
end
function [p] = plotSelectedPoint(type2)% same as above but with the point type
    
    p = 'o';
    if strcmp(type2,'x')
      p = 'x';
    elseif strcmp(type2,'*')
       p = '*';
    end
end
function [] = plotDataCallback(source,event,gui) %the callback function for the plot button runs when plot button is pressed
global gui;

    gui.titleText.Visible = 'off';
    gui.titleEdit.Visible = 'off';
    gui.xDataText.Visible = 'off';
    gui.xDataEdit.Visible = 'off';
    gui.yDataText.Visible = 'off';
    gui.yDataEdit.Visible = 'off';
    gui.xLabelText.Visible = 'off';
    gui.xLabelEdit.Visible = 'off';
    gui.yLabelText.Visible = 'off';
    gui.yLabelEdit.Visible = 'off';
    gui.button.Visible = 'off';
    gui.checkXY.Visible = 'on';
    gui.buttonGroup.Visible = 'off';
    gui.buttonGroup2.Visible = 'off';
    gui.resetButton.Visible = 'on'; % these all make each selection box invisible keeping the checkxy text the plot and the reset button
   
    gui.fig.Name = gui.titleEdit.String;
    x = str2num(gui.xDataEdit.String); % these read the text box for your x and y value and store them in variable x and y
    y = str2num(gui.yDataEdit.String);
    
  c = plotSelectedColor(gui.buttonGroup.SelectedObject.String) ; % these run the  plotSelectedColor function to store color and point type in c and p
   p =  plotSelectedPoint(gui.buttonGroup2.SelectedObject.String);
    
    lengthY = numel(y); % these read the x and y array and determine how many items are stored in each and place them in the length variables
    lengthX = numel(x); 
    
    
   if lengthY == lengthX
       gui.checkXY.String = 'enjoy your figure';            % this checks to see if the x and y arrays have the same number of items in them and either 
   else                                                                         %produces an error prompt in the checkxy gui text or tells you your data has been plotted
       gui.checkXY.String = 'error x inputs not equal to y inputs';
   
    end
   
    scatter(x,y,c,p)                % in puts your x,y,c,p variables into a plot and graphs them
    xlabel(gui.xLabelEdit.String);
    ylabel(gui.yLabelEdit.String);
    title(gui.titleEdit.String);
    
    
    
end
   
function [] = reset(~,~) % this is the reset callback function that runs the code at the begining aggain reseting your plot and data and making all the input boxes reappear after clicking the rest button which is very hard to find
global gui;
 gui.titleText = uicontrol('style','text','position',[20 370 50 20],'string','Plot Title:','horizontalalignment','right');
    gui.titleEdit = uicontrol('style','edit','position',[80 370 100 20]);
    
    gui.xDataText = uicontrol('style','text','position',[180 370 50 20],'string','X Values:','horizontalalignment','right'); 
    gui.xDataEdit = uicontrol('style','edit','position',[240 370 100 20]);
    
    gui.yDataText = uicontrol('style','text','position',[340 370 50 20],'string','Y Values:','horizontalalignment','right');
    gui.yDataEdit = uicontrol('style','edit','position',[400 370 100 20]);
    
    gui.xLabelText = uicontrol('style','text','position',[180 320 50 20],'string','X Label:','horizontalalignment','right');
    gui.xLabelEdit = uicontrol('style','edit','position',[240 320 100 20]);
    
    gui.yLabelText = uicontrol('style','text','position',[340 320 50 20],'string','Y Label:','horizontalalignment','right');
    gui.yLabelEdit = uicontrol('style','edit','position',[400 320 100 20]);
    
    
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0 0.6 .15 .25],'selectionchangedfcn',{@radioSelect});
    gui.r1 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','r');
    gui.r2 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','b');
    gui.r3 = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','g');
    
    gui.buttonGroup2 = uibuttongroup('visible','on','units','normalized','position',[0.13 0.6 .15 .25],'selectionchangedfcn',{@radioSelect});
    gui.r4 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','o');
    gui.r5 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','x');
    gui.r6 = uicontrol(gui.buttonGroup2,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','*');
    
    
    
    gui.checkXY = uicontrol('style','text','position',[20 390 400 20],'string','fill out feilds then select plot','horizontalalignment','left');
    
    gui.p = plot(0,0);
    gui.p.Parent.Position = [.1 .1 .8 .450];
    
    gui.button = uicontrol('style','pushbutton','position',[530 260 50 30],'string','Plot');
    gui.button.String = 'Plot';
    gui.button.Callback = {@plotDataCallback,gui};
    
    gui.resetButton.Visible = 'off'; % makes the reset button invisible again
end



