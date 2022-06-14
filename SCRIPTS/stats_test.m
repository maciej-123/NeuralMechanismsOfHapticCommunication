clear all
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

n1 = '3';
filepath1 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n1,'\\Pilot',n1,'_analysis\\Pilot')

n2 = '5';
filepath2 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n2,'\\Pilot',n2,'_analysis\\Pilot')


%%
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath1,n1,'_0_0.set')},
    {'index',2,'load',append(filepath1,n1,'_0_0_.set')},


    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    {'index',2,'subject','1','session',0,'run',0,'condition','2','group','0'},

    
    },'updatedat','on','rmclust','on' );

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
eeglab redraw

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels', 'erp', 'on');