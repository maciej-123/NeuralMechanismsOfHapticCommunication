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

filepath1 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n1,'\\Pilot',n1,'_analysis\\Pilot')
filepath2 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n2,'\\Pilot',n2,'_analysis\\Pilot')
filepath3 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n3,'\\Pilot',n3,'_analysis\\Pilot')
filepath4 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n4,'\\Pilot',n4,'_analysis\\Pilot')
filepath5 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n5,'\\Pilot',n5,'_analysis\\Pilot')
filepath6 = append('D:\\Documents_D\\Imperial_D\\EEG_data\\Pilot',n6,'\\Pilot',n6,'_analysis\\Pilot')

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
    {'index',1+5*m,'subject','6','session',0,'run',0,'condition','1','group','0'},
    {'index',2+5*m,'subject','6','session',0,'run',0,'condition','2','group','0'},
    {'index',3+5*m,'subject','6','session',0,'run',0,'condition','3','group','0'},
    {'index',4+5*m,'subject','6','session',0,'run',0,'condition','4','group','0'},
    {'index',5+5*m,'subject','6','session',0,'run',0,'condition','5','group','0'},
    {'index',6+5*m,'subject','6','session',0,'run',0,'condition','6','group','0'},
    {'index',7+5*m,'subject','6','session',0,'run',0,'condition','7','group','0'},
    {'index',8+5*m,'subject','6','session',0,'run',0,'condition','8','group','0'},
    {'index',9+5*m,'subject','6','session',0,'run',0,'condition','9','group','0'}
    
    },'updatedat','on','rmclust','on' );

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);

% ALLEEG = pop_eegfiltnew(ALLEEG, 'locutoff',4,'hicutoff',8,'plotfreqz',0);%ga


%%
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels', 'erp', 'on');
%%
[~, erpdata1] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n1);
[~, erpdata2] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n2);

[~, erpdata3] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n3);
[~, erpdata4] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n4);
[~, erpdata5] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n5);
[~, erpdata6] = std_readdata(STUDY, ALLEEG, 'channels', {ALLEEG(1).chanlocs.labels }, 'design', 1, 'datatype', 'erp','subject',n6);

start_ = 3000;
end_ = 13000;

for i=1:9
e = erpdata1{i};erpdata1{i}=e(start_:end_,:);
e = erpdata2{i};erpdata2{i}=e(start_:end_,:);

e = erpdata3{i};erpdata3{i}=e(start_:end_,:);
e = erpdata4{i};erpdata4{i}=e(start_:end_,:);
e = erpdata5{i};erpdata5{i}=e(start_:end_,:);
e = erpdata6{i};erpdata6{i}=e(start_:end_,:);
end
%% preprocssing ERP data to make append all channels into a vector

for  i = 1:9
erpdata1{i} = reshape(erpdata1{i},[],1);
erpdata2{i} = reshape(erpdata2{i},[],1);

erpdata3{i} = reshape(erpdata3{i},[],1);
erpdata4{i} = reshape(erpdata4{i},[],1);
erpdata5{i} = reshape(erpdata5{i},[],1);
erpdata6{i} = reshape(erpdata6{i},[],1);
end

%% append all ERP vectors
Master_ERP = [];
for i = 1:9
% e = vertcat(cell2mat(erpdata3(i)),cell2mat(erpdata4(i)),cell2mat(erpdata5(i)),cell2mat(erpdata6(i)));

e = vertcat(cell2mat(erpdata1(i)),cell2mat(erpdata2(i)),cell2mat(erpdata3(i)),cell2mat(erpdata4(i)),cell2mat(erpdata5(i)),cell2mat(erpdata6(i)));

Master_ERP = [Master_ERP e];
end


%%

%%calculate similarity
X = corr(Master_ERP);

figure
% subplot(1,2,1)
imagesc(X)
myColorMap = jet(256);
myColorMap(256,:) = 0;
myColorMap(1,:) = 1;
colormap(myColorMap);
caxis([0 0.30])
colorbar
title(append('Appended Positive Correlations Between Conditions for all Subjects'))

% subplot(1,2,2)
% imagesc(-X)
% myColorMap = jet(256);
% myColorMap(256,:) = 0;
% myColorMap(1,:) = 1;
% 
% colormap(myColorMap);
% caxis([0 0.35])
% colorbar
% title(append('Appended Negative Correlations Between Conditions for all Subjects'))

% set(gcf, 'Position', get(0, 'Screensize'));

saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALL.png'));
saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALL.eps'),'epsc');

eeglab redraw

% sgtitle('Beta 13-30Hz Band')
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLBeta.png'));
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLBeta.eps'));


% sgtitle('Alpha 8-13Hz Band')
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLAlpha.png'));
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLAlpha.eps'));

% sgtitle('Gamma 30-100Hz Band')
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLGamma.png'));
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLGamma.eps'));

% sgtitle('Theta 4-8Hz Band')
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLTheta.png'));
% saveas(gcf,append('D:\Documents_D\Imperial_D\EEG_data\AnalysisImages_and_results\Correlation_Matrix\Correlation_MatrixALLTheta.eps'));
