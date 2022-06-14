%Copyright Maciej Zajaczkowski

N = ['1', '2', '3', '4','5','6'];

clearvars -except N
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );



n1 = '1';
n2 = '2';
n3 = '3';
n4 = '4';
n5 = '5';
n6 = '6';

filepath1 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n1,'\\Pilot',n1,'_analysis\\Pilot')
filepath2 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n2,'\\Pilot',n2,'_analysis\\Pilot')
filepath3 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n3,'\\Pilot',n3,'_analysis\\Pilot')
filepath4 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n4,'\\Pilot',n4,'_analysis\\Pilot')
filepath5 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n5,'\\Pilot',n5,'_analysis\\Pilot')
filepath6 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n6,'\\Pilot',n6,'_analysis\\Pilot')


%% Import Trajectory information

events = tdfread('D:\Documents_D\Imperial_D\EEG_data\Pilot5\EventstoImport5.txt','\t');
event_times = events.latency;
types = events.type;

epoch_types = tdfread('D:\Documents_D\Imperial_D\EEG_data\Pilot5\Epoch_type5.txt','\t');
condition = epoch_types.condition;
stifness = epoch_types.stifness;


% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot1\P1_150721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot4\P4_160721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot2\P2_200721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot3\P3_210721_pilot_Datalog.tsv')
fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot5\P5_pilot_220721_Datalog.tsv')

% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_Datalog.tsv')%A
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_part2_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_part2bis_Datalog.tsv')

C = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'HeaderLines', 1);
fclose(fid);

raw_time = C{1};
raw_trial_num = C{2};
target_angle = C{3};
rest_active = C{40};
actual_time = C{39};

actual_time = actual_time-actual_time(1);

event_times1 = event_times;event_times1(2:4:end) = [];event_times1(2:3:end) = [];event_times1(2:2:end) = [];

event_times1 = event_times1-event_times1(1);
actual_time_round = round(actual_time,1);
%%
m = 9;
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);

[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath1,n1,'_0_0.set')},
    {'index',2,'load',append(filepath1,n1,'_0_0_.set')},
    {'index',3,'load',append(filepath1,n1,'_3_0.2967.set')},
    {'index',4,'load',append(filepath1,n1,'_3_0.0297.set')},%TG
    {'index',5,'load',append(filepath1,n1,'_3_0.1353.set')},
    {'index',6,'load',append(filepath1,n1,'_2_0.0297.set')},%HP
    {'index',7,'load',append(filepath1,n1,'_2_0.1353.set')},
    {'index',8,'load',append(filepath1,n1,'_1_0.0297.set')},%RP
    {'index',9,'load',append(filepath1,n1,'_1_0.1353.set')},
    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    {'index',2,'subject','1','session',0,'run',0,'condition','2','group','0'},
    {'index',3,'subject','1','session',0,'run',0,'condition','3','group','0'},
    {'index',4,'subject','1','session',0,'run',0,'condition','4','group','0'},
    {'index',5,'subject','1','session',0,'run',0,'condition','5','group','0'},
    {'index',6,'subject','1','session',0,'run',0,'condition','6','group','0'},
    {'index',7,'subject','1','session',0,'run',0,'condition','7','group','0'},
    {'index',8,'subject','1','session',0,'run',0,'condition','8','group','0'},
    {'index',9,'subject','1','session',0,'run',0,'condition','9','group','0'},
    
    {'index',1+m,'load',append(filepath2,n2,'_0_0.set')},
    {'index',2+m,'load',append(filepath2,n2,'_0_0_.set')},
    {'index',3+m,'load',append(filepath2,n2,'_3_0.2967.set')},
    {'index',4+m,'load',append(filepath2,n2,'_3_0.0297.set')},%TG
    {'index',5+m,'load',append(filepath2,n2,'_3_0.1353.set')},   
    {'index',6+m,'load',append(filepath2,n2,'_2_0.0297.set')},%HP
    {'index',7+m,'load',append(filepath2,n2,'_2_0.1353.set')},
    {'index',8+m,'load',append(filepath2,n2,'_1_0.0297.set')},%RP
    {'index',9+m,'load',append(filepath2,n2,'_1_0.1353.set')},
    {'index',1+m,'subject','2','session',0,'run',0,'condition','1','group','0'},
    {'index',2+m,'subject','2','session',0,'run',0,'condition','2','group','0'},
    {'index',3+m,'subject','2','session',0,'run',0,'condition','3','group','0'},
    {'index',4+m,'subject','2','session',0,'run',0,'condition','4','group','0'},
    {'index',5+m,'subject','2','session',0,'run',0,'condition','5','group','0'},
    {'index',6+m,'subject','2','session',0,'run',0,'condition','6','group','0'},
    {'index',7+m,'subject','2','session',0,'run',0,'condition','7','group','0'},
    {'index',8+m,'subject','2','session',0,'run',0,'condition','8','group','0'},
    {'index',9+m,'subject','2','session',0,'run',0,'condition','9','group','0'},
    
    {'index',1+2*m,'load',append(filepath3,n3,'_0_0.set')},
    {'index',2+2*m,'load',append(filepath3,n3,'_0_0_.set')},
    {'index',3+2*m,'load',append(filepath3,n3,'_3_0.2967.set')},
    {'index',4+2*m,'load',append(filepath3,n3,'_3_0.0297.set')},%TG
    {'index',5+2*m,'load',append(filepath3,n3,'_3_0.1353.set')},   
    {'index',6+2*m,'load',append(filepath3,n3,'_2_0.0297.set')},%HP
    {'index',7+2*m,'load',append(filepath3,n3,'_2_0.1353.set')},
    {'index',8+2*m,'load',append(filepath3,n3,'_1_0.0297.set')},%RP
    {'index',9+2*m,'load',append(filepath3,n3,'_1_0.1353.set')},
    {'index',1+2*m,'subject','3','session',0,'run',0,'condition','1','group','0'},
    {'index',2+2*m,'subject','3','session',0,'run',0,'condition','2','group','0'},
    {'index',3+2*m,'subject','3','session',0,'run',0,'condition','3','group','0'},
    {'index',4+2*m,'subject','3','session',0,'run',0,'condition','4','group','0'},
    {'index',5+2*m,'subject','3','session',0,'run',0,'condition','5','group','0'},
    {'index',6+2*m,'subject','3','session',0,'run',0,'condition','6','group','0'},
    {'index',7+2*m,'subject','3','session',0,'run',0,'condition','7','group','0'},
    {'index',8+2*m,'subject','3','session',0,'run',0,'condition','8','group','0'},
    {'index',9+2*m,'subject','3','session',0,'run',0,'condition','9','group','0'},
    
    {'index',1+3*m,'load',append(filepath4,n4,'_0_0.set')},
    {'index',2+3*m,'load',append(filepath4,n4,'_0_0_.set')},
    {'index',3+3*m,'load',append(filepath4,n4,'_3_0.2967.set')},
    {'index',4+3*m,'load',append(filepath4,n4,'_3_0.0297.set')},%TG
    {'index',5+3*m,'load',append(filepath4,n4,'_3_0.1353.set')},   
    {'index',6+3*m,'load',append(filepath4,n4,'_2_0.0297.set')},%HP
    {'index',7+3*m,'load',append(filepath4,n4,'_2_0.1353.set')},
    {'index',8+3*m,'load',append(filepath4,n4,'_1_0.0297.set')},%RP
    {'index',9+3*m,'load',append(filepath4,n4,'_1_0.1353.set')},
    {'index',1+3*m,'subject','4','session',0,'run',0,'condition','1','group','0'},
    {'index',2+3*m,'subject','4','session',0,'run',0,'condition','2','group','0'},
    {'index',3+3*m,'subject','4','session',0,'run',0,'condition','3','group','0'},
    {'index',4+3*m,'subject','4','session',0,'run',0,'condition','4','group','0'},
    {'index',5+3*m,'subject','4','session',0,'run',0,'condition','5','group','0'},
    {'index',6+3*m,'subject','4','session',0,'run',0,'condition','6','group','0'},
    {'index',7+3*m,'subject','4','session',0,'run',0,'condition','7','group','0'},
    {'index',8+3*m,'subject','4','session',0,'run',0,'condition','8','group','0'},
    {'index',9+3*m,'subject','4','session',0,'run',0,'condition','9','group','0'},
    
    {'index',1+4*m,'load',append(filepath5,n5,'_0_0.set')},
    {'index',2+4*m,'load',append(filepath5,n5,'_0_0_.set')},
    {'index',3+4*m,'load',append(filepath5,n5,'_3_0.2967.set')},
    {'index',4+4*m,'load',append(filepath5,n5,'_3_0.0297.set')},%TG
    {'index',5+4*m,'load',append(filepath5,n5,'_3_0.1353.set')},   
    {'index',6+4*m,'load',append(filepath5,n5,'_2_0.0297.set')},%HP
    {'index',7+4*m,'load',append(filepath5,n5,'_2_0.1353.set')},
    {'index',8+4*m,'load',append(filepath5,n5,'_1_0.0297.set')},%RP
    {'index',9+4*m,'load',append(filepath5,n5,'_1_0.1353.set')},
    {'index',1+4*m,'subject','5','session',0,'run',0,'condition','1','group','0'},
    {'index',2+4*m,'subject','5','session',0,'run',0,'condition','2','group','0'},
    {'index',3+4*m,'subject','5','session',0,'run',0,'condition','3','group','0'},
    {'index',4+4*m,'subject','5','session',0,'run',0,'condition','4','group','0'},
    {'index',5+4*m,'subject','5','session',0,'run',0,'condition','5','group','0'},
    {'index',6+4*m,'subject','5','session',0,'run',0,'condition','6','group','0'},
    {'index',7+4*m,'subject','5','session',0,'run',0,'condition','7','group','0'},
    {'index',8+4*m,'subject','5','session',0,'run',0,'condition','8','group','0'},
    {'index',9+4*m,'subject','5','session',0,'run',0,'condition','9','group','0'},
    
    {'index',1+5*m,'load',append(filepath6,n6,'_0_0.set')},
    {'index',2+5*m,'load',append(filepath6,n6,'_0_0_.set')},
    {'index',3+5*m,'load',append(filepath6,n6,'_3_0.2967.set')},
    {'index',4+5*m,'load',append(filepath6,n6,'_3_0.0297.set')},%TG
    {'index',5+5*m,'load',append(filepath6,n6,'_3_0.1353.set')},   
    {'index',6+5*m,'load',append(filepath6,n6,'_2_0.0297.set')},%HP
    {'index',7+5*m,'load',append(filepath6,n6,'_2_0.1353.set')},
    {'index',8+5*m,'load',append(filepath6,n6,'_1_0.0297.set')},%RP
    {'index',9+5*m,'load',append(filepath6,n6,'_1_0.1353.set')},
    {'index',1+5*m,'subject','5','session',0,'run',0,'condition','1','group','0'},
    {'index',2+5*m,'subject','5','session',0,'run',0,'condition','2','group','0'},
    {'index',3+5*m,'subject','5','session',0,'run',0,'condition','3','group','0'},
    {'index',4+5*m,'subject','5','session',0,'run',0,'condition','4','group','0'},
    {'index',5+5*m,'subject','5','session',0,'run',0,'condition','5','group','0'},
    {'index',6+5*m,'subject','5','session',0,'run',0,'condition','6','group','0'},
    {'index',7+5*m,'subject','5','session',0,'run',0,'condition','7','group','0'},
    {'index',8+5*m,'subject','5','session',0,'run',0,'condition','8','group','0'},
    {'index',9+5*m,'subject','5','session',0,'run',0,'condition','9','group','0'}
    
    },'updatedat','on','rmclust','on' );

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
eeglab redraw

%%
c=C{9};
% range = [9 13];
% range = [6 26];
% range = [20 24];
range = [14 18];


% single graph start_xpos - CONSTANT
% start_xpos = 0.076;
% width = 0.71;

% 3x3 plot start_xpos - CONSTANT [3 23]d
start_xpos = 0.032;
% width = 0.183;%[3 23]
width = 0.30;%[15 17]

% cfs = [0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2];
% cfs = [0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2]+0.05;

range_start = range(1)*100;
range_end = range(2)*100;
ch_num = 1;


for C_ = 1:9
figure; 
for i = 1:6
subplot(3,2,i)

if C_ == 1 
    cond = 1;
    stif = 1;
elseif C_ == 2 
    cond = 9;
    stif = 9;
elseif C_ == 3 
    cond = find(condition == 3);
    stif = find(stifness == 0.2967);
elseif C_ == 4 
    cond = find(condition == 3);
    stif = find(stifness == 0.0297);
elseif C_ == 5 
    cond = find(condition == 3);
    stif = find(stifness == 0.1353);
elseif C_ == 6 
    cond = find(condition == 2);
    stif = find(stifness == 0.0297);
elseif C_ == 7 
    cond = find(condition == 2);
    stif = find(stifness == 0.1353);
elseif C_ == 8 
    cond = find(condition == 1);
    stif = find(stifness == 0.0297);
elseif C_ == 9 
    cond = find(condition == 1);
    stif = find(stifness == 0.1353);
end

k = intersect(cond,stif)

f = 20*(k-1);
n_ = randi([5+f 15+f],1,1);

A = round(event_times1(n_),1);
t = (range_start*10):(range_end*10);
[val,idx]=min(abs(actual_time_round-A));
minVal=actual_time_round(idx);
X=find(actual_time_round==minVal);
X = X(end);
Traj = c(X+(range_start-300):X+(range_end-300))';

% Compute newtimef on first dataset for channel 1
options = {'freqscale', 'linear', 'freqs', [3 30], 'nfreqs', 20, 'ntimesout', 2000, 'padratio', 1,'winsize',64,'baseline', 0};


TMPEEG = eeg_checkset(ALLEEG(9*(i-1)+C_), 'loaddata');


% X = pop_newtimef_( Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo, 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);
% X = pop_newtimef_( Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo,'alpha',0.05, 'mcorrect', 'fdr', 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);
X = pop_newtimef_(Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo,'alpha',0.05, 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);
end

a=ALLEEG(1).chanlocs;
a = a(ch_num).labels;
% title = append('Spectrogram for Subject ',n,' for channel ',a, 'for range: ', num2str(range(1)), 's to ',num2str(range(2)),'s');

Title = append('ERP Spectrogram for Condition ',num2str(C_),' for channel ',a, ' for range ', num2str(range(1)), ' s to ',num2str(range(2)),'s');


sgtitle(Title) 
set(gcf, 'Position', get(0, 'Screensize'));

Title = strrep(Title, ' ', '_');

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\TimeFrequency\',Title,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\TimeFrequency\',Title,'.eps'),'epsc');


%%

eeglab redraw
%%
% pop_precomp(STUDY, ALLEEG);
% pop_chanplot(STUDY, ALLEEG);
end

