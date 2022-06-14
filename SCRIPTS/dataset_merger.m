%Copyright Maciej Zajaczkowski

clearvars -except filepath n  
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

n1 = '1';
n2 = '2';
n3 = '3';
n4 = '4';
n5 = '5';
n6 = '6';

filepath1 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n1,'\\Pilot',n1,'_analysis\\Pilot');
filepath2 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n2,'\\Pilot',n2,'_analysis\\Pilot');
filepath3 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n3,'\\Pilot',n3,'_analysis\\Pilot');
filepath4 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n4,'\\Pilot',n4,'_analysis\\Pilot');
filepath5 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n5,'\\Pilot',n5,'_analysis\\Pilot');
filepath6 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n6,'\\Pilot',n6,'_analysis\\Pilot');

savepath = 'D:\Documents_D\Imperial_D\EEG_data\ConditionMergedDatasets';


Condition = '_0_0.set';
Condition = '_0_0_.set';
Condition='_3_0.2967.set';
Condition='_3_0.0297.set';
Condition='_3_0.1353.set';
Condition='_2_0.0297.set';
Condition='_2_0.1353.set';
Condition='_1_0.0297.set';
Condition='_1_0.1353.set';




%%
m = 9;
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);

[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath1,n1,Condition)},
    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    
    {'index',2,'load',append(filepath2,n2,Condition)},
    {'index',2,'subject','2','session',0,'run',0,'condition','1','group','0'},
    
    {'index',3,'load',append(filepath3,n3,Condition)},
    {'index',3,'subject','3','session',0,'run',0,'condition','1','group','0'},
    
    {'index',4,'load',append(filepath4,n4,Condition)},
    {'index',4,'subject','4','session',0,'run',0,'condition','1','group','0'},
    
    {'index',5,'load',append(filepath5,n5,Condition)},
    {'index',5,'subject','5','session',0,'run',0,'condition','1','group','0'},
    
    {'index',6,'load',append(filepath6,n6,Condition)},
    {'index',6,'subject','6','session',0,'run',0,'condition','1','group','0'}

    },'updatedat','on','rmclust','on' );


[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
%%

OUTEEG = pop_mergeset( ALLEEG(1),ALLEEG(2),1);
OUTEEG = pop_mergeset( OUTEEG,ALLEEG(3),1);
OUTEEG = pop_mergeset( OUTEEG,ALLEEG(4),1);
OUTEEG = pop_mergeset( OUTEEG,ALLEEG(5),1);
OUTEEG = pop_mergeset( OUTEEG,ALLEEG(6),1);

%%
eeglab redraw

OUTEEG = eeg_checkset( OUTEEG );
OUTEEG = pop_saveset( OUTEEG, 'filename',append('Merge',Condition),'filepath',savepath);
OUTEEG = eeg_checkset( OUTEEG );
eeglab redraw;

