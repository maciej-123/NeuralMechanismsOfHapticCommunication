clear all
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

n = '4';
filepath = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n,'\\Pilot',n,'_analysis\\Pilot')

%%
STUDY = [];
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
    {'index',1,'load',append(filepath,n,'_0_0.set')},
    {'index',2,'load',append(filepath,n,'_0_0_.set')},
    {'index',3,'load',append(filepath,n,'_3_0.2967.set')},

    {'index',4,'load',append(filepath,n,'_3_0.0297.set')},%TG
    {'index',5,'load',append(filepath,n,'_3_0.1353.set')},
    
    {'index',6,'load',append(filepath,n,'_2_0.0297.set')},%HP
    {'index',7,'load',append(filepath,n,'_2_0.1353.set')},

    {'index',8,'load',append(filepath,n,'_1_0.0297.set')},%RP
    {'index',9,'load',append(filepath,n,'_1_0.1353.set')},

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


%%
eeglab redraw

for i = 1:9
figure
subplot(1,2,1)
EEG = ALLEEG(i);
pop_spectopo(EEG, 1, [12500  13500], 'EEG' , 'percent', 100, 'freq', [6 12 22], 'freqrange',[2 30],'electrodes','off');
title('fff')
subplot(1,2,2)
pop_spectopo(EEG, 1, [18500  19500], 'EEG' , 'percent', 100, 'freq', [6 12 22], 'freqrange',[2 30],'electrodes','off');
end

%%
% [STUDY ALLEEG] = std_checkset(STUDY, ALLEEG); 
% eeglab redraw
% 
% [STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
% CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','recompute','on','spec','on','specparams',{'specmode','fft','logtrials','off'});
% 
% STUDY = pop_specparams(STUDY, 'freqrange',[0 50] );
% STUDY = std_specplot(STUDY,ALLEEG,'channels',{'FP1'}, 'design', 1);
% eeglab redraw;
