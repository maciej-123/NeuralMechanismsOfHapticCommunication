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
    {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
    
    {'index',2,'load',append(filepath2,n2,'_0_0.set')},
    {'index',2,'subject','2','session',0,'run',0,'condition','1','group','0'},
    
    {'index',3,'load',append(filepath3,n3,'_0_0.set')},
    {'index',3,'subject','3','session',0,'run',0,'condition','1','group','0'},
    
    {'index',4,'load',append(filepath4,n4,'_0_0.set')},
    {'index',4,'subject','4','session',0,'run',0,'condition','1','group','0'},
    
    {'index',5,'load',append(filepath5,n5,'_0_0.set')},
    {'index',5,'subject','5','session',0,'run',0,'condition','1','group','0'},
    
    {'index',6,'load',append(filepath6,n6,'_0_0.set')},
    {'index',6,'subject','6','session',0,'run',0,'condition','1','group','0'}

    },'updatedat','on','rmclust','on' );

% [STUDY ALLEEG] = std_editset( STUDY, [], 'name','test','task','s','notes','s','commands',{
%     {'index',1,'load',append(filepath1,n1,'_0_0.set')},
%     {'index',2,'load',append(filepath1,n1,'_0_0_.set')},
%     {'index',3,'load',append(filepath1,n1,'_3_0.2967.set')},
%     {'index',4,'load',append(filepath1,n1,'_3_0.0297.set')},%TG
%     {'index',5,'load',append(filepath1,n1,'_3_0.1353.set')},
%     {'index',6,'load',append(filepath1,n1,'_2_0.0297.set')},%HP
%     {'index',7,'load',append(filepath1,n1,'_2_0.1353.set')},
%     {'index',8,'load',append(filepath1,n1,'_1_0.0297.set')},%RP
%     {'index',9,'load',append(filepath1,n1,'_1_0.1353.set')},
%     {'index',1,'subject','1','session',0,'run',0,'condition','1','group','0'},
%     {'index',2,'subject','1','session',0,'run',0,'condition','2','group','0'},
%     {'index',3,'subject','1','session',0,'run',0,'condition','3','group','0'},
%     {'index',4,'subject','1','session',0,'run',0,'condition','4','group','0'},
%     {'index',5,'subject','1','session',0,'run',0,'condition','5','group','0'},
%     {'index',6,'subject','1','session',0,'run',0,'condition','6','group','0'},
%     {'index',7,'subject','1','session',0,'run',0,'condition','7','group','0'},
%     {'index',8,'subject','1','session',0,'run',0,'condition','8','group','0'},
%     {'index',9,'subject','1','session',0,'run',0,'condition','9','group','0'},
%     
%     {'index',1+m,'load',append(filepath2,n2,'_0_0.set')},
%     {'index',2+m,'load',append(filepath2,n2,'_0_0_.set')},
%     {'index',3+m,'load',append(filepath2,n2,'_3_0.2967.set')},
%     {'index',4+m,'load',append(filepath2,n2,'_3_0.0297.set')},%TG
%     {'index',5+m,'load',append(filepath2,n2,'_3_0.1353.set')},   
%     {'index',6+m,'load',append(filepath2,n2,'_2_0.0297.set')},%HP
%     {'index',7+m,'load',append(filepath2,n2,'_2_0.1353.set')},
%     {'index',8+m,'load',append(filepath2,n2,'_1_0.0297.set')},%RP
%     {'index',9+m,'load',append(filepath2,n2,'_1_0.1353.set')},
%     {'index',1+m,'subject','2','session',0,'run',0,'condition','1','group','0'},
%     {'index',2+m,'subject','2','session',0,'run',0,'condition','2','group','0'},
%     {'index',3+m,'subject','2','session',0,'run',0,'condition','3','group','0'},
%     {'index',4+m,'subject','2','session',0,'run',0,'condition','4','group','0'},
%     {'index',5+m,'subject','2','session',0,'run',0,'condition','5','group','0'},
%     {'index',6+m,'subject','2','session',0,'run',0,'condition','6','group','0'},
%     {'index',7+m,'subject','2','session',0,'run',0,'condition','7','group','0'},
%     {'index',8+m,'subject','2','session',0,'run',0,'condition','8','group','0'},
%     {'index',9+m,'subject','2','session',0,'run',0,'condition','9','group','0'},
%     
%     {'index',1+2*m,'load',append(filepath3,n3,'_0_0.set')},
%     {'index',2+2*m,'load',append(filepath3,n3,'_0_0_.set')},
%     {'index',3+2*m,'load',append(filepath3,n3,'_3_0.2967.set')},
%     {'index',4+2*m,'load',append(filepath3,n3,'_3_0.0297.set')},%TG
%     {'index',5+2*m,'load',append(filepath3,n3,'_3_0.1353.set')},   
%     {'index',6+2*m,'load',append(filepath3,n3,'_2_0.0297.set')},%HP
%     {'index',7+2*m,'load',append(filepath3,n3,'_2_0.1353.set')},
%     {'index',8+2*m,'load',append(filepath3,n3,'_1_0.0297.set')},%RP
%     {'index',9+2*m,'load',append(filepath3,n3,'_1_0.1353.set')},
%     {'index',1+2*m,'subject','3','session',0,'run',0,'condition','1','group','0'},
%     {'index',2+2*m,'subject','3','session',0,'run',0,'condition','2','group','0'},
%     {'index',3+2*m,'subject','3','session',0,'run',0,'condition','3','group','0'},
%     {'index',4+2*m,'subject','3','session',0,'run',0,'condition','4','group','0'},
%     {'index',5+2*m,'subject','3','session',0,'run',0,'condition','5','group','0'},
%     {'index',6+2*m,'subject','3','session',0,'run',0,'condition','6','group','0'},
%     {'index',7+2*m,'subject','3','session',0,'run',0,'condition','7','group','0'},
%     {'index',8+2*m,'subject','3','session',0,'run',0,'condition','8','group','0'},
%     {'index',9+2*m,'subject','3','session',0,'run',0,'condition','9','group','0'},
%     
%     {'index',1+3*m,'load',append(filepath4,n4,'_0_0.set')},
%     {'index',2+3*m,'load',append(filepath4,n4,'_0_0_.set')},
%     {'index',3+3*m,'load',append(filepath4,n4,'_3_0.2967.set')},
%     {'index',4+3*m,'load',append(filepath4,n4,'_3_0.0297.set')},%TG
%     {'index',5+3*m,'load',append(filepath4,n4,'_3_0.1353.set')},   
%     {'index',6+3*m,'load',append(filepath4,n4,'_2_0.0297.set')},%HP
%     {'index',7+3*m,'load',append(filepath4,n4,'_2_0.1353.set')},
%     {'index',8+3*m,'load',append(filepath4,n4,'_1_0.0297.set')},%RP
%     {'index',9+3*m,'load',append(filepath4,n4,'_1_0.1353.set')},
%     {'index',1+3*m,'subject','4','session',0,'run',0,'condition','1','group','0'},
%     {'index',2+3*m,'subject','4','session',0,'run',0,'condition','2','group','0'},
%     {'index',3+3*m,'subject','4','session',0,'run',0,'condition','3','group','0'},
%     {'index',4+3*m,'subject','4','session',0,'run',0,'condition','4','group','0'},
%     {'index',5+3*m,'subject','4','session',0,'run',0,'condition','5','group','0'},
%     {'index',6+3*m,'subject','4','session',0,'run',0,'condition','6','group','0'},
%     {'index',7+3*m,'subject','4','session',0,'run',0,'condition','7','group','0'},
%     {'index',8+3*m,'subject','4','session',0,'run',0,'condition','8','group','0'},
%     {'index',9+3*m,'subject','4','session',0,'run',0,'condition','9','group','0'},
%     
%     {'index',1+4*m,'load',append(filepath5,n5,'_0_0.set')},
%     {'index',2+4*m,'load',append(filepath5,n5,'_0_0_.set')},
%     {'index',3+4*m,'load',append(filepath5,n5,'_3_0.2967.set')},
%     {'index',4+4*m,'load',append(filepath5,n5,'_3_0.0297.set')},%TG
%     {'index',5+4*m,'load',append(filepath5,n5,'_3_0.1353.set')},   
%     {'index',6+4*m,'load',append(filepath5,n5,'_2_0.0297.set')},%HP
%     {'index',7+4*m,'load',append(filepath5,n5,'_2_0.1353.set')},
%     {'index',8+4*m,'load',append(filepath5,n5,'_1_0.0297.set')},%RP
%     {'index',9+4*m,'load',append(filepath5,n5,'_1_0.1353.set')},
%     {'index',1+4*m,'subject','5','session',0,'run',0,'condition','1','group','0'},
%     {'index',2+4*m,'subject','5','session',0,'run',0,'condition','2','group','0'},
%     {'index',3+4*m,'subject','5','session',0,'run',0,'condition','3','group','0'},
%     {'index',4+4*m,'subject','5','session',0,'run',0,'condition','4','group','0'},
%     {'index',5+4*m,'subject','5','session',0,'run',0,'condition','5','group','0'},
%     {'index',6+4*m,'subject','5','session',0,'run',0,'condition','6','group','0'},
%     {'index',7+4*m,'subject','5','session',0,'run',0,'condition','7','group','0'},
%     {'index',8+4*m,'subject','5','session',0,'run',0,'condition','8','group','0'},
%     {'index',9+4*m,'subject','5','session',0,'run',0,'condition','9','group','0'},
%     
%     {'index',1+5*m,'load',append(filepath6,n6,'_0_0.set')},
%     {'index',2+5*m,'load',append(filepath6,n6,'_0_0_.set')},
%     {'index',3+5*m,'load',append(filepath6,n6,'_3_0.2967.set')},
%     {'index',4+5*m,'load',append(filepath6,n6,'_3_0.0297.set')},%TG
%     {'index',5+5*m,'load',append(filepath6,n6,'_3_0.1353.set')},   
%     {'index',6+5*m,'load',append(filepath6,n6,'_2_0.0297.set')},%HP
%     {'index',7+5*m,'load',append(filepath6,n6,'_2_0.1353.set')},
%     {'index',8+5*m,'load',append(filepath6,n6,'_1_0.0297.set')},%RP
%     {'index',9+5*m,'load',append(filepath6,n6,'_1_0.1353.set')},
%     {'index',1+5*m,'subject','5','session',0,'run',0,'condition','1','group','0'},
%     {'index',2+5*m,'subject','5','session',0,'run',0,'condition','2','group','0'},
%     {'index',3+5*m,'subject','5','session',0,'run',0,'condition','3','group','0'},
%     {'index',4+5*m,'subject','5','session',0,'run',0,'condition','4','group','0'},
%     {'index',5+5*m,'subject','5','session',0,'run',0,'condition','5','group','0'},
%     {'index',6+5*m,'subject','5','session',0,'run',0,'condition','6','group','0'},
%     {'index',7+5*m,'subject','5','session',0,'run',0,'condition','7','group','0'},
%     {'index',8+5*m,'subject','5','session',0,'run',0,'condition','8','group','0'},
%     {'index',9+5*m,'subject','5','session',0,'run',0,'condition','9','group','0'}
%     
%     },'updatedat','on','rmclust','on' );

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
%%

eeglab redraw
% pop_chanplot(STUDY, ALLEEG);

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_settings( EEG,'hdmfile','C:\\Users\\Maciej\\Documents\\Imperial\\Courses\\Yr4\\4th Year Project\\EEGLAB\\eeglab2021.1\\plugins\\dipfit\\standard_BEM\\standard_vol.mat','coordformat','MNI','mrifile','C:\\Users\\Maciej\\Documents\\Imperial\\Courses\\Yr4\\4th Year Project\\EEGLAB\\eeglab2021.1\\plugins\\dipfit\\standard_BEM\\standard_mri.mat','chanfile','C:\\Users\\Maciej\\Documents\\Imperial\\Courses\\Yr4\\4th Year Project\\EEGLAB\\eeglab2021.1\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc','coord_transform',[0 -15 0 0 0 -1.57 105 87 102] ,'chansel',[1:32] );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_multifit( EEG,[],'threshold',100,'rmout','on','plotopt',{'normlen','on'});
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

STUDY = std_dipplot(STUDY,ALLEEG,'clusters',1, 'design', 1);
STUDY = std_dipplot(STUDY,ALLEEG,'clusters',1, 'design', 1, 'plotsubjects', 'on' );

[STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
eeglab redraw

%%

[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
[STUDY ALLEEG] = std_preclust(STUDY, ALLEEG, 1,{'dipoles','weight',1},{'moments','weight',1});
[STUDY] = pop_clust(STUDY, ALLEEG, 'algorithm','kmeans','clus_num',  23 );
eeglab redraw;


