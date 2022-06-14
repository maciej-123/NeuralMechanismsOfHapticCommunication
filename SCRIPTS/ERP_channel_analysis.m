clear all
close all
%%
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

n = '3';
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
[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
EEG = eeg_checkset( EEG );

%% Find location names
EEG = ALLEEG(7);
L = strings(1,32);
for i = 1:32
loc = EEG.chanlocs(i).labels;
L(i) = loc;
end
Electrode_to_plot = find(L == 'Pz');

%% FP1-1, Cz - 17, CP5 - 19, T7 - 14, Pz - 25

% v = [1 17 19 14 25];
v = [1 17];

%%
titles = ["Solo Before";"Solo After";"Passive TG";"Loose TG";"Rigid TG";"Loose HP";"Rigid HP";"Loose RP";"Rigid RP"];
    

ALLEEG__ = ALLEEG;
ALLEEG_1 = pop_eegfiltnew(ALLEEG, 'locutoff',30,'hicutoff',100,'plotfreqz',0);%ga
ALLEEG_2 = pop_eegfiltnew(ALLEEG, 'locutoff',13,'hicutoff',30,'plotfreqz',0);%bet
ALLEEG_3 = pop_eegfiltnew(ALLEEG, 'locutoff',8,'hicutoff',13,'plotfreqz',0);%alp
ALLEEG_4 = pop_eegfiltnew(ALLEEG, 'locutoff',4,'hicutoff',8,'plotfreqz',0);%theta

%%
for band = 1:5
   
ALLEEG = eeg_checkset( ALLEEG );

if band == 1
    ALLEEG_ = ALLEEG_1;
elseif band == 2
        ALLEEG_ = ALLEEG_2;
elseif band == 3
        ALLEEG_ = ALLEEG_3;
elseif band == 4
        ALLEEG_ = ALLEEG_4;
elseif band == 5
        ALLEEG_ = ALLEEG__;
end

ALLEEG_ = eeg_checkset( ALLEEG_ );

figure; 
for i = 1:9

TMPEEG = ALLEEG_(i);

subplot(3,3,i)
title = convertStringsToChars(titles(i));
pop_timtopo_(TMPEEG,v,title,[15850  16150],[15900 16000 16100]);

end

if band == 1
        title = append('Subject ',n,' ERPs for Gamma Frequencies');
        sgtitle(title) 
elseif band == 2
        title = append('Subject ',n,' ERPs for Beta Frequencies');
        sgtitle(title) 
elseif band == 3
        title = append('Subject ',n,' ERPs for Alpha Frequencies');
        sgtitle(title) 
elseif band == 4
        title = append('Subject ',n,' ERPs for Theta Frequencies');
        sgtitle(title)
elseif band == 5
        title = append('Subject ',n,' ERPs for All Frequencies');
        sgtitle(title) 
end
set(gcf, 'Position', get(0, 'Screensize'));

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\ChannelBandERPs\',title,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\ChannelBandERPs\',title,'.eps'));


eeglab redraw



end

%%

%%

% ALLEEG = pop_eegfiltnew(ALLEEG, 'locutoff',13,'hicutoff',30,'plotfreqz',1);%bet

%%
% [~, erpdata] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp');
% 
% erpdatamat = cell2mat(erpdata);
% 
% erpChan = erpdatamat(:,v(1));
% erpChan = reshape(erpChan,9,[])';
% figure
% plot(erpChan(7900:8100,:))






