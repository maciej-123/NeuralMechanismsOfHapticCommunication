%Copyright Maciej Zajaczkowski


clear all
close all

%% global variables

n = '6';

% raw_file = 'RecordSession_P1_testpilot12021.07.15_14.58.56.set'
% raw_file = 'RecordSession_P2_testpilot12021.07.20_16.53.31.set'
% raw_file = 'RecordSession_P3_testpilot12021.07.21_14.51.04.set'
% raw_file = 'RecordSession_P4_testpilot12021.07.16_15.23.43.set'
% raw_file = 'RecordSession_P5_testpilot12021.07.22_11.37.51.set'
% raw_file = 'RecordSession_P6_testpilot12021.07.14_13.56.05.set'

filepath = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n,'\\')
epoch_types = tdfread(append('D:\Documents_D\Imperial_D\EEG_data\Pilot',n,'\Epoch_type',n,'.txt'),'\t');

condition = epoch_types.condition;
stifness = epoch_types.stifness;
%% filter the data
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; 
EEG = pop_loadset('filename',raw_file,'filepath',filepath);
[~, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw;

%filters
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'plotfreqz',0);%
EEG = pop_eegfiltnew(EEG, 'locutoff',47,'hicutoff',53,'revfilt',1,'plotfreqz',0);%,'filtorder',500
% EEG = pop_eegfiltnew(EEG, 'locutoff',97,'hicutoff',103,'revfilt',1,'plotfreqz',0);
EEG = pop_eegfiltnew(EEG, 'locutoff',147,'hicutoff',153,'revfilt',1,'plotfreqz',0);
% EEG = pop_eegfiltnew(EEG, 'locutoff',197,'hicutoff',203,'revfilt',1,'plotfreqz',0);
EEG = pop_eegfiltnew(EEG, 'hicutoff',240,'plotfreqz',0);%,'filtorder',500

% EEG = pop_eegfiltnew(EEG, 'locutoff',212,'hicutoff',218,'revfilt',1,'plotfreqz',0);



pop_spectopo(EEG, 1, [0  6625146], 'EEG' , 'percent', 30, 'freqrange',[0 250],'electrodes','off');

%%
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FilteringResults\FilteringResultSubj',n,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FilteringResults\FilteringResultSubj',n,'.eps'));

EEG.setname = append('1.0-Pilot',n,'filtered1Hz50Hz.set');
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('1.0-Pilot',n,'filtered1Hz50Hz.set'),'filepath',filepath);
EEG = eeg_checkset( EEG );
eeglab redraw;



%% ICA before ASR
%load locations
EEG=pop_chanedit(EEG, 'load',{'D:\Documents_D\Imperial_D\EEG_data\nautilus.locs','filetype','xyz'});EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');EEG = eeg_checkset( EEG );
EEG = pop_iclabel(EEG, 'default');EEG = eeg_checkset( EEG );
EEG.setname=append('1.1-Pilot',n,'_ICA_before_ASR.set.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('1.1-Pilot',n,'_ICA_before_ASR.set.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;

%% apply ASR
clearvars -except filepath n condition stifness   
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; 
EEG = pop_loadset('filename',append('1.0-Pilot',n,'filtered1Hz50Hz.set'),'filepath',filepath);
eeglab redraw;
EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off','Distance','Euclidian');EEG = eeg_checkset( EEG );
EEG.setname=append('2.0-Pilot',n,'_ASR.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('2.0-Pilot',n,'_ASR.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;

%% apply ICA weights to those after ASR
EEG = pop_loadset('filename',append('1.1-Pilot',n,'_ICA_before_ASR.set.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 2);
EEG = pop_loadset('filename',append('2.0-Pilot',n,'_ASR.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 3);

EEG=pop_chanedit(EEG, 'load',{'D:\Documents_D\Imperial_D\EEG_data\nautilus.locs','filetype','xyz'});EEG = eeg_checkset( EEG );
EEG = pop_editset(EEG, 'run', [], 'icaweights', 'ALLEEG(2).icaweights', 'icasphere', 'ALLEEG(2).icasphere', 'icachansind', 'ALLEEG(2).icachansind');
EEG = pop_iclabel(EEG, 'default');EEG = eeg_checkset( EEG );
EEG.setname = append('2.1-Pilot',n,'_ASR_with_pre_asr_weights.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('2.1-Pilot',n,'_ASR_with_pre_asr_weights.set'),'filepath',filepath);EEG = eeg_checkset( EEG );


%% evaluate percentage of data ASR has had an affect on
clearvars -except filepath n condition stifness    
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('1.1-Pilot',n,'_ICA_before_ASR.set.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
% EEG = pop_iclabel(EEG, 'default');EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 1);
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('2.1-Pilot',n,'_ASR_with_pre_asr_weights.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, 2);
eeglab redraw;

x=ALLEEG(1).data;
y=ALLEEG(2).data;
changed = abs(x - y)>0;
diff = (x - y);
num_change = sum(sum(changed));
Size = size(changed);
num_total = Size(1)*Size(2);
percentage_changed = 100*num_change/num_total;

%evaluate aplitude changes
diff(:,any(diff == 0))=[]; % removes column if there is any zero in the column
h=histogram(diff,200);
xlabel('Amplitude Changes')
ylabel('')
stdev = mean(std(diff'));
%percentage of large artifacts
changed = abs(diff)>1*stdev;%%sections of data above one standard deviation away from the changed data mean
num_change = sum(sum(changed));
percentage_changed_large1 = 100*num_change/num_total;

changed = abs(diff)>2*stdev;%%sections of data above one standard deviation away from the changed data mean
num_change = sum(sum(changed));
percentage_changed_large2 = 100*num_change/num_total;
clear num_change num_total x y Size

%% evaluate power reduction and effect on brain and non-brain components

X1=ALLEEG(1).data;
X2=ALLEEG(2).data;
%ICA weight matrices
W1 = ALLEEG(1).icaweights;

%classifiaction
classes1 = ALLEEG(1).etc.ic_classification.ICLabel.classifications;
classes2 = ALLEEG(2).etc.ic_classification.ICLabel.classifications;
classes = ALLEEG(2).etc.ic_classification.ICLabel.classes;

%obtain ICS pinv is the pseudo inverse
Y1 = W1*X1;
Y2 = W1*X2;

%overall power reduction
%mean rms of components - where rms represents power
power1 = rms(Y1');
power2 = rms(Y2');
meanVar1 = mean(power1);
meanVar2 = mean(power2);

%calculate total average power reduction - if negative and set 2 is an ASR
%filtered set, then the overall power has been reduced
PowerReduction = meanVar2 - meanVar1;

%Component Reduction
PowerReductionComp = power2-power1;
[corr,indx,indy,corrs]=matcorr(Y1,Y2);

v=zeros(1,32);
i=1:32;
v(i) = 100*var(Y1(i,:)')/sum(var(Y1'));

%change in classifications
format long
classes_diff = (classes2 - classes1)./classes1;
classes_change = classes_diff > 0;

figure
subplot(1,2,1)
imagesc(classes1)
title('Classification before ASR')
xticks([1 2 3 4 5 6 7])
xticklabels({'Brain','Muscle','Eye','Heart','Channel','Line','Other'})
xlabel('Classfication category')
ylabel('IC number')
colorbar
subplot(1,2,2)
imagesc(classes2)
title('Classification after ASR')
xticks([1 2 3 4 5 6 7])
xticklabels({'Brain','Muscle','Eye','Heart','Channel','Line','Other'})
xlabel('Classfication category')
ylabel('IC number')
colorbar
colormap hot

classes_diff_neg = classes_diff;
classes_diff_pos = classes_diff;

classes_diff_pos(classes_diff_pos < 0) = 0;
classes_diff_neg(classes_diff_neg > 0) = 0;

max = 1;
figure
subplot(1,2,1)
imagesc(abs(classes_diff_neg))
title('Negative Changes')
xticks([1 2 3 4 5 6 7])
xticklabels({'Brain','Muscle','Eye','Heart','Channel','Line','Other'})
xlabel('Classfication category')
ylabel('IC number')
caxis([0 max])
colorbar

subplot(1,2,2)
imagesc(classes_diff_pos)
title('Positive Changes')
xticks([1 2 3 4 5 6 7])
xticklabels({'Brain','Muscle','Eye','Heart','Channel','Line','Other'})
xlabel('Classfication category')
ylabel('IC number')
set(gcf, 'Position', get(0, 'Screensize'));


myColorMap = jet(256);
myColorMap(1,:) = 1;
colormap(myColorMap);
caxis([0 max])
colorbar

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\ICLabelBeforeAfter\ICLabelSubj',n,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\ICLabelBeforeAfter\ICLabelSubj',n,'.eps'),'epsc');

%% obtain ICA after ASR
clearvars -except filepath n condition stifness    
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('2.0-Pilot',n,'_ASR.set'),'filepath',filepath);EEG = eeg_checkset( EEG );

EEG=pop_chanedit(EEG, 'load',{'D:\Documents_D\Imperial_D\EEG_data\nautilus.locs','filetype','xyz'});EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');EEG = eeg_checkset( EEG );
EEG = pop_iclabel(EEG, 'default');EEG = eeg_checkset( EEG );
EEG.setname=append('3.0-Pilot',n,'_ICA_after_ASR.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('3.0-Pilot',n,'_ICA_after_ASR.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;


%% reject ICs with less than 6% brain activity or a large majority of definite non-brain (i.e. 80-99% eye). Do not reject components labeled as 'other'
classifications = EEG.etc.ic_classification.ICLabel.classifications;

reject = zeros(32,1);

for i = 1:32
    C=classifications(i,:);
    if C(1) < 0.06 || C(2) > 0.75 || C(3) > 0.75 || C(4) > 0.75 || C(5) > 0.75 || C(6) > 0.75
        reject(i) = 1;
    end
end

index = find(reject == 1);

EEG = pop_subcomp( EEG, index, 0);
EEG.setname=append('4.0-Pilot',n,'_remove_bad_components.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('4.0-Pilot',n,'_remove_bad_components.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;

%%
maxICnum = size(EEG.icawinv);maxICnum = maxICnum(2);
pop_selectcomps(EEG,[1:maxICnum]);
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FinalComponents\FinalComponentsSubj',n,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FinalComponents\FinalComponentsSubj',n,'.eps'));

%% manaully edit components


% clearvars -except filepath n condition stifness    
% close all
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
% EEG = pop_loadset('filename',append('4.0-Pilot',n,'_remove_bad_components.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
% eeglab redraw
% 
% %%
% %save edited dataset
% 
% pop_selectcomps(EEG,[1:20]);
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FinalComponents\FinalComponentsSubj',n,'.png'));
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\FinalComponents\FinalComponentsSubj',n,'.eps'));
% 
% EEG.setname=append('4.0-Pilot',n,'_remove_bad_components.set');EEG = eeg_checkset( EEG );
% EEG = pop_saveset( EEG, 'filename',append('4.0-Pilot',n,'_remove_bad_components.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
% eeglab redraw;





%% extract epochs
clearvars -except filepath n condition stifness    
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('4.0-Pilot',n,'_remove_bad_components.set'),'filepath',filepath);EEG = eeg_checkset( EEG );

eeglab redraw;
EEG = pop_importevent(EEG, 'append','no','event',append(filepath,'EventstoImport',n,'.txt'),'fields',{'latency','type'},'skipline',1,'timeunit',1,'align',NaN);EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'RestStart'  }, [0  26], 'newname', append('5.0-Pilot',n,'_epoched.set'), 'epochinfo', 'yes');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('5.0-Pilot',n,'_epoched.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;


%%baseline normalise data

EEG = pop_rmbase( EEG, [0 3000] ,[]);
EEG.setname=append('5.1-Pilot',n,'_epoched_with_baseline.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;


%% save epochs into bundles for each type of trial

a= 0;
b= -2;

%0.000000 0.000000 
clearvars -except filepath n condition stifness b
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[1:20+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_0_0.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_0_0.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%3.000000 0.296700 
clearvars -except filepath n condition stifness b
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[21+b:40+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(2)),'_',num2str(stifness(2)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(2)),'_',num2str(stifness(2)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

% 3.000000 0.135300 
clearvars -except filepath n condition stifness b  
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[41+b:60+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(3)),'_',num2str(stifness(3)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(3)),'_',num2str(stifness(3)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%2.000000 0.135300 
clearvars -except filepath n condition stifness b
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[61+b:80+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(4)),'_',num2str(stifness(4)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(4)),'_',num2str(stifness(4)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

% 2.000000 0.029700 
clearvars -except filepath n condition stifness b  
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[81+b:100+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(5)),'_',num2str(stifness(5)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(5)),'_',num2str(stifness(5)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%1.000000 0.029700 
clearvars -except filepath n condition stifness b  
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[101+b:120+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(6)),'_',num2str(stifness(6)),'.set');;EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(6)),'_',num2str(stifness(6)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%1.000000 0.135300 
clearvars -except filepath n condition stifness b 
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[121+b:140+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(7)),'_',num2str(stifness(7)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(7)),'_',num2str(stifness(7)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%3.000000 0.029700 
clearvars -except filepath n condition stifness b 
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[141+b:160+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_',num2str(condition(8)),'_',num2str(stifness(8)),'.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_',num2str(condition(8)),'_',num2str(stifness(8)),'.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;

%0.000000 0.000000 
clearvars -except filepath n condition stifness b
close all
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename',append('5.1-Pilot',n,'_epoched_with_baseline.set'),'filepath',filepath);EEG = eeg_checkset( EEG );
eeglab redraw;
EEG = pop_selectevent( EEG, 'epoch',[161+b:180+b] ,'deleteevents','off','deleteepochs','on','invertepochs','off');EEG = eeg_checkset( EEG );
EEG.setname=append('Pilot',n,'_0_0_.set');EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename',append('Pilot',n,'_0_0_.set'),'filepath',append(filepath,append('Pilot',n,'_analysis\\')));EEG = eeg_checkset( EEG );
eeglab redraw;


