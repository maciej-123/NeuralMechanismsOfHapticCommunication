%Copyright Maciej Zajaczkowski

clearvars -except filepath n  
close all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG.etc.eeglabvers = '2021.1'; EEG = eeg_checkset( EEG );

n = '1';
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

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);4
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels', 'erp', 'on');
[~, erpdata] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp');
%%
% STUDY = std_erpplot(STUDY, ALLEEG, 'channels', {'FP1'});
%%
% erpdata = cellfun(@squeeze, erpdata, 'uniformoutput', false);

A=ALLEEG(1).chanlocs(25).labels;

%%
Channel_num = 25;
times=ALLEEG(1).times;

t_min = 14000/2;
t_max = 16000/2;
T = times(t_min:t_max);

figure
subplot(2,2,1);
ERP=cell2mat(erpdata(5,:));%3.000000_0.135300
plot(T,ERP(t_min:t_max,Channel_num));hold on
ERP=cell2mat(erpdata(4,:));%3.000000_0.029700
plot(T,ERP(t_min:t_max,Channel_num));
title('Condition 3 (TG) with 2 stiffness levels');
xlabel('time (ms)')
ylabel('amplitude (mV)')
legend('Stiffness 0.1353','Stiffness 0.0297')

subplot(2,2,2);
ERP=cell2mat(erpdata(7,:));%2.000000_0.135300
plot(T,ERP(t_min:t_max,Channel_num));hold on
ERP=cell2mat(erpdata(6,:));%2.000000_0.029700
plot(T,ERP(t_min:t_max,Channel_num));
title('Condition 2 (HP) with 2 stiffness levels');
xlabel('time (ms)')
ylabel('amplitude (mV)')
legend('Stiffness 0.1353','Stiffness 0.0297')

subplot(2,2,3);
ERP=cell2mat(erpdata(9,:));%1.000000_0.135300
plot(T,ERP(t_min:t_max,Channel_num));hold on
ERP=cell2mat(erpdata(8,:));%1.000000_0.029700
plot(T,ERP(t_min:t_max,Channel_num));
title('Condition 1 (RP) with 2 stiffness levels');
xlabel('time (ms)')
ylabel('amplitude (mV)')
legend('Stiffness 0.1353','Stiffness 0.0297')

subplot(2,2,4);
ERP=cell2mat(erpdata(1,:));%0 0 
plot(T,ERP(t_min:t_max,Channel_num));hold on
ERP=cell2mat(erpdata(2,:));%0 0_
plot(T,ERP(t_min:t_max,Channel_num));hold on
ERP=cell2mat(erpdata(3,:));%3.000000_0.296700
plot(T,ERP(t_min:t_max,Channel_num));
title('Solo and Passive Trajectory Guidance');
xlabel('time (ms)')
ylabel('amplitude (mV)')
legend('Solo Before','Solo After','Passive TG')


%% calculate RMS values

RMS = [];
for i = 1:9
ERP = cell2mat(erpdata(i,:));
rms_ = rms(ERP(3000:13000,:));
RMS = vertcat(RMS,rms_);
end

figure
plot(RMS(1,:),'Color',[0.5 0.5 0.5]);
hold on
plot(RMS(2,:),'Color',[1 1 0]);
hold on
plot(RMS(3,:),'Color',[0 0 0]);
hold on
plot(RMS(4,:),'Color',[1 0.5 0.5]);
hold on
plot(RMS(5,:),'Color',[1 0 0]);
hold on
plot(RMS(6,:),'Color',[0.5 1 0.5]);
hold on
plot(RMS(7,:),'Color',[0 1 0]);
hold on
plot(RMS(8,:),'Color',[0.5 0.5 1]);
hold on
plot(RMS(9,:),'Color',[0 0 1])

title(append('Solo and Passive Trajectory Guidance ',n));
xlabel('Channel Number')
ylabel('channel RMS')
legend('0 0 before','0 0 after','TG passive','TG loose','TG rigid','HP loose','HP rigid','RP loose','RP rigid')

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\RMS_graph\rmsgraph',n,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\RMS_graph\rmsgraph',n,'.eps'));

%% calculate similarity

uberX = zeros(9);
for chnum = 1:32
ERPchan_val = [];
for i = 1:9
ERP = cell2mat(erpdata(i,:));
ERPch = ERP(3000:end,chnum);
ERPchan_val = horzcat(ERPchan_val,ERPch);
end

X = corr(ERPchan_val);
uberX = uberX+X;
% figure
% imagesc(X)
% title(ALLEEG(1).chanlocs(chnum).labels)
% colormap jet
% caxis([0 0.3])
% colorbar
end


figure
L = uberX/32;
imagesc(L)
myColorMap = jet(256);
myColorMap(256,:) = 0;
colormap(myColorMap);
caxis([0 0.35])
colorbar
title(append('Average Correlations Between Conditions for Subject ',n))

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_Matrix',n,'.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_Matrix',n,'.eps'),'epsc');

%%
figure
for chnum = 1:32
ERP1 = cell2mat(erpdata(1,:));
ERP2 = cell2mat(erpdata(3,:));
X = xcorr(ERP1(:,chnum),ERP2(:,chnum));

plot(X)
xlim([0 26000])
hold on
end

eeglab redraw;

%%
% close all
