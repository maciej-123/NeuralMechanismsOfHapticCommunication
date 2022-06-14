% Coppyright Maciej Zajaczkowski 
%code desgined to plot time averaged scalpplots for intervals repeating
%every second (turn on trajectory)

clear all
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

filepath = append('D:\\Documents_D\\Imperial_D\\EEG_data\\ConditionMergedDatasets\\Merge')

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

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
eeglab redraw

%% 
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels', 'erp', 'on');
% , 'erpparams', {'rmbase' [0 3000]}

%%

x1 = 0:25;
x2 = 1:26;
times = vertcat(x1,x2)*1000;
times(1,1) = times(1,1) + 1;

times = times(:,8:26)-500;


% times(1,:) = times(1,:) + 500;
% times(2,:) = times(2,:) - 500;
%2222
a_ = times(:,1)';
a = [8000 10000];


position = [4 -3 0 -4 2 0 5 -2 1 -5 1 -2 5 0 2 -4 0 -3 4];


%%

Frequency_Band = [13 30];
for i = 1:19
    
%%Full bandwidth scalpplots
% STUDY = pop_statparams(STUDY, 'groupstats','off','method','perm','mcorrect','fdr');
STUDY = pop_statparams(STUDY, 'groupstats','on','condstats','on','singletrials','on');
% STUDY = pop_statparams(STUDY, 'groupstats','on','condstats','on','singletrials','on','mcorrect', 'fdr');

STUDY = pop_erpparams(STUDY, 'topotime',times(:,i)');
STUDY = std_erpplot(STUDY,ALLEEG,'channels',{'FP1','FP2','AF3','AF4','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6','T7','C3','C4','Cz','T8','CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8','PO7','PO3','PO4','PO8','Oz'}, 'plotsubjects', 'on', 'design', 1 );


%%Frequency banded scalpplots
% STUDY = pop_erspparams(STUDY,'topotime',times(:,i)','topofreq',Frequency_Band);
% STUDY = pop_statparams(STUDY, 'groupstats','on','condstats','on','singletrials','on');
% STUDY = std_erspplot(STUDY,ALLEEG,'channels',{'FP1','FP2','AF3','AF4','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6','T7','C3','C4','Cz','T8','CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8','PO7','PO3','PO4','PO8','Oz'}, 'plotsubjects', 'on', 'design', 1 );

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Scalpplots\MergerScalpplots\Scalpplottest',num2str(i),'P',num2str(position(i)),'t',num2str(times(1,i)),'_',num2str(times(2,i)),'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Scalpplots\MergerScalpplots\Scalpplottest',num2str(i),'P',num2str(position(i)),'t',num2str(times(1,i)),'_',num2str(times(2,i)),'.eps'),'epsc');


title(append('P',num2str(position(i))))
eeglab redraw;
end

%%
% pop_erspparams(STUDY)


%%
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','recompute','on','ersp','on','erspparams',{'cycles',[3 0.8] ,'nfreqs',100,'ntimesout',200},'itc','on');
% eeglab redraw;


%% 
% saveas(append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Scalpplots\Scalpplots',n,'\Scalpplottest.png'));

%%

% pop_chanplot(STUDY, ALLEEG);
% [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG,EEG,0);
% EEG = eeg_checkset( EEG );

% [STUDY ALLEEG] = pop_precomp(STUDY, ALLEEG);
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels','recompute','on','ersp','on','erspparams',{'cycles' [3 0.8] 'parallel' 'on' options{:} },'itc','on');
% [STUDY] = pop_clustedit(STUDY, ALLEEG);
% [STUDY] = std_topoplot(STUDY, ALLEEG, 'clusters', 2, 'mode', 'together');
% figure
% pop_topoplot(ALLEEG(1), 1, 1:3)

% STUDY = pop_erpparams(STUDY, 'topotime',[20000 22000]);
% STUDY = std_erpplot(STUDY,ALLEEG,'channels',{'FP1','FP2','AF3','AF4','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6','T7','C3','C4','Cz','T8','CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8','PO7','PO3','PO4','PO8','Oz'}, 'plotsubjects', 'on', 'design', 1 );
% eeglab redraw;
