clear all
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

% filepath1 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n1,'\\')
% filepath2 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n2,'\\')
% filepath3 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n3,'\\')
% filepath4 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n4,'\\')
% filepath5 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n5,'\\')
% filepath6 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n6,'\\')

%%
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath1,n1,'_0_0.set')},
    {'index',2,'load',append(filepath2,n2,'_0_0.set')},
    {'index',3,'load',append(filepath3,n3,'_0_0.set')},
    {'index',4,'load',append(filepath4,n4,'_0_0.set')},
    {'index',5,'load',append(filepath5,n5,'_0_0.set')},
    {'index',6,'load',append(filepath6,n6,'_0_0.set')},

    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    {'index',2,'subject','1','session',0,'run',0,'condition','2','group','0'},
    {'index',3,'subject','1','session',0,'run',0,'condition','3','group','0'},
    {'index',4,'subject','1','session',0,'run',0,'condition','4','group','0'},
    {'index',5,'subject','1','session',0,'run',0,'condition','5','group','0'},
    {'index',6,'subject','1','session',0,'run',0,'condition','6','group','0'},
    
    },'updatedat','on','rmclust','on' );



% EEG = pop_loadset('filename',append('5.1-Pilot',n1,'_epoched_with_baseline.set'),'filepath',filepath1);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 1);EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('5.1-Pilot',n2,'_epoched_with_baseline.set'),'filepath',filepath2);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 2);EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('5.1-Pilot',n3,'_epoched_with_baseline.set'),'filepath',filepath3);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 3);EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('5.1-Pilot',n4,'_epoched_with_baseline.set'),'filepath',filepath4);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 4);EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('5.1-Pilot',n5,'_epoched_with_baseline.set'),'filepath',filepath5);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 5);EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('5.1-Pilot',n6,'_epoched_with_baseline.set'),'filepath',filepath6);EEG = eeg_checkset( EEG );
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, 6);EEG = eeg_checkset( EEG );

eeglab redraw

for i = 1:6
TMPEEG = ALLEEG(i);
figure; 
pop_spectopo(TMPEEG, 1, [0  25998], 'EEG' , 'percent', 50, 'freqrange',[2 250],'electrodes','off');
end