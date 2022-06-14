%Copyright Maciej Zajaczkowski

N = ['1', '2', '3', '4','5','6'];

for n_var = 3:3
clearvars -except N n_var
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );


n = N(n_var)
% n = '4';
filepath = append('D:\\Documents_D\\Imperial_D\\EEG_data\\ConditionMergedDatasets\\Merge')


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
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath,'_0_0.set')},
    {'index',2,'load',append(filepath,'_0_0_.set')},
    {'index',3,'load',append(filepath,'_3_0.2967.set')},

    {'index',4,'load',append(filepath,'_3_0.0297.set')},%TG
    {'index',5,'load',append(filepath,'_3_0.1353.set')},
    
    {'index',6,'load',append(filepath,'_2_0.0297.set')},%HP
    {'index',7,'load',append(filepath,'_2_0.1353.set')},

    {'index',8,'load',append(filepath,'_1_0.0297.set')},%RP
    {'index',9,'load',append(filepath,'_1_0.1353.set')},

    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    {'index',2,'subject','1','session',0,'run',0,'condition','2','group','0'},
    {'index',3,'subject','1','session',0,'run',0,'condition','3','group','0'},
    {'index',4,'subject','1','session',0,'run',0,'condition','4','group','0'},
    {'index',5,'subject','1','session',0,'run',0,'condition','5','group','0'},
    {'index',6,'subject','1','session',0,'run',0,'condition','6','group','0'},
    {'index',7,'subject','1','session',0,'run',0,'condition','7','group','0'},
    {'index',8,'subject','1','session',0,'run',0,'condition','8','group','0'},
    {'index',9,'subject','1','session',0,'run',0,'condition','9','group','0'}
    
    },'updatedat','on','rmclust','on' );

% [STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
% EEG = eeg_checkset( EEG );

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
start_xpos = 0.022;
% width = 0.183;%[3 23]
width = 0.21;%[15 17]


% cfs = [0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2];
% cfs = [0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2]+0.05;

range_start = range(1)*100;
range_end = range(2)*100;
ch_num = 1;

figure; 

for i = 1:9
subplot(3,3,i)

%%testing part
% width = cfs(i); 
if i == 1 
    cond = 1;
    stif = 1;
elseif i == 2 
    cond = 9;
    stif = 9;
elseif i == 3 
    cond = find(condition == 3);
    stif = find(stifness == 0.2967);
elseif i == 4 
    cond = find(condition == 3);
    stif = find(stifness == 0.0297);
elseif i == 5 
    cond = find(condition == 3);
    stif = find(stifness == 0.1353);
elseif i == 6 
    cond = find(condition == 2);
    stif = find(stifness == 0.0297);
elseif i == 7 
    cond = find(condition == 2);
    stif = find(stifness == 0.1353);
elseif i == 8 
    cond = find(condition == 1);
    stif = find(stifness == 0.0297);
elseif i == 9 
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
TMPEEG = eeg_checkset(ALLEEG(i), 'loaddata');
% X = pop_newtimef_( Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo, 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);
% X = pop_newtimef_( Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo,'alpha',0.05, 'mcorrect', 'fdr', 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);
X = pop_newtimef_( Traj,width,start_xpos,TMPEEG, 1, ch_num, range*1000, [3 0.8] , 'topovec', 1, 'elocs', TMPEEG.chanlocs, 'chaninfo', TMPEEG.chaninfo, 'plotphase', 'off','plotitc' , 'off', options{:},'title',TMPEEG.setname, 'erspmax ',6.6);

end

a=ALLEEG(1).chanlocs;
a = a(ch_num).labels;
% title = append('Spectrogram for Subject ',n,' for channel ',a, 'for range: ', num2str(range(1)), 's to ',num2str(range(2)),'s');

title = append('ERP Spectrogram for Subject ',n,' for channel ',a, ' for range ', num2str(range(1)), ' s to ',num2str(range(2)),'s');


sgtitle(title) 
set(gcf, 'Position', get(0, 'Screensize'));

title = strrep(title, ' ', '_');

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\TimeFrequency\',title,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\TimeFrequency\',title,'.eps'));


%%

eeglab redraw
%%
% pop_precomp(STUDY, ALLEEG);
% pop_chanplot(STUDY, ALLEEG);
end

