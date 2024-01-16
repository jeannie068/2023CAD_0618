clear; close all;
Case = ['case06_output.txt']; %改成你要跑的case即可
die = [0 0 0 0];
num_fix = 0;
num_soft = 0;
pins = 0;
switch Case
    case 'case01_output.txt'
        die = [0 0 11267 10450];
        num_fix = 5;
        num_soft = 15;
        pins = 38028;
    case 'case02_output.txt'
        die = [0 0 2300 2300];
        num_fix = 8;
        num_soft = 16;
        pins = 38662;
    case 'case03_output.txt' 
        die = [0 0 2500 3000];
        num_fix = 14;
        num_soft = 28;
        pins = 55350;
    case 'case04_output.txt'
        die = [0 0 4995 4407];
        num_fix = 8;
        num_soft = 20;
        pins = 55350;
    case 'case05_output.txt'
        die = [0 0 4620 3740];
        num_fix = 8;
        num_soft = 16;
        pins = 38662;
    case 'case06_output.txt'
        die = [0 0 3000 2700];
        num_fix = 13;
        num_soft = 21;
        pins = 38028;
    case 'case07out_1.txt'
        die = [0 0 17086320 6262020];
        num_fix = 175;
        pins = 38028;
    case 'case08out_1.txt'
        die = [0 0 12102240 10824300];
        num_fix = 253;
        pins = 38662;
    case 'case09out_1.txt' 
        die = [0 0 16545200 11761380];
        num_fix = 84;
        pins = 55350;
    case 'case10out_1.txt' 
        die = [0 0 16545200 11761380];
        num_fix = 84;
        pins = 55350;
    case 'case11out_1.txt'
        die = [0 0 12102240 10824300];
        num_fix = 253;
        pins = 38662;
    case 'case12out_1.txt'
        die = [0 0 17086320 6262020];
        num_fix = 175;
        pins = 38028;
    case 'case13out_1.txt'
        die = [0 0 17086320 6262020];
        num_fix = 175;
        pins = 38028;
    case 'case14out_1.txt'
        die = [0 0 12102240 10824300];
        num_fix = 253;
        pins = 38662;
    case 'case15out_1.txt' 
        die = [0 0 16545200 11761380];
        num_fix = 84;
        pins = 55350;
end

set (gca, 'xtick' ,[],'xticklabel',[], 'ytick' ,[],'yticklabel',[], 'xcolor' , 'w' , 'ycolor' , 'w' );
rectangle('Position',die,'FaceColor',"#FFFFFF"); 
% title(Case);
[data0,data1,data2,data3,data4]=textread(Case,'%s %n %n %n %n');

%data9-12是pins
% [data9,data10,data11,data12]=textread('case02out_pin.txt','%n %n %n %n');

% for i=1: pins
% d9 = data9(i);
% d10 = data10(i);
% d11 = data11(i); 
% d12 = data12(i); 
% rectangle('Position',[d9 d10 d11 d12],'EdgeColor','b');hold;
% end

for i=num_fix+1: num_fix+num_soft
d0 = data0(i);
d1 = data1(i);
d2 = data2(i);
d3 = data3(i); 
d4 = data4(i);
rectangle('Position',[d1 d2 d3 d4],'FaceColor',"#FAEEC7",'EdgeColor',"#000000",'LineWidth', 1.5);hold;
%rectangle('Position',[d1 d2 d3 d4],'FaceColor',"#4DBEEE");hold;
%rectangle('Position',[d1 d2 d3 d4],'FaceColor',"#C0FFEE");hold;
text(d1+d3/3,d2+d4/2,d0);
end

for i=1: num_fix
d0 = data0(i);
d1 = data1(i);
d2 = data2(i);
d3 = data3(i); 
d4 = data4(i); 
%rectangle('Position',[d1 d2 d3 d4],'FaceColor',"#FFFFFF",'EdgeColor',"#0072BD",'LineWidth', 2);hold;
rectangle('Position',[d1 d2 d3 d4],'FaceColor',"#4DBEEE",'EdgeColor',"#000000",'LineWidth', 1.5);hold;
text(d1+d3/3,d2+d4/2,d0);
end


