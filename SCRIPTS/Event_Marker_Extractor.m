clear all


% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot1\P1_150721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot4\P4_160721_pilot_Datalog.tsv')
fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot2\P2_200721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot3\P3_210721_pilot_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot5\P5_pilot_220721_Datalog.tsv')

% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_Datalog.tsv')%A
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_part2_Datalog.tsv')
% fid = fopen('D:\Documents_D\Imperial_D\EEG_data\Pilot6\P6_pilot1_part2bis_Datalog.tsv')

% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot1\RecordSession_P1_testpilot12021.07.15_14.58.56.hdf5','//RawData/AcquisitionTaskDescription'));
% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot4\RecordSession_P4_testpilot12021.07.16_15.23.43.hdf5','//RawData/AcquisitionTaskDescription'));
data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot2\RecordSession_P2_testpilot12021.07.20_16.53.31.hdf5','//RawData/AcquisitionTaskDescription'));
% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot3\RecordSession_P3_testpilot12021.07.21_14.51.04.hdf5','//RawData/AcquisitionTaskDescription'));
% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot5\RecordSession_P5_testpilot12021.07.22_11.37.51.hdf5','//RawData/AcquisitionTaskDescription'));

% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot6\RecordSession_P6_testpilot12021.07.14_13.54.50.hdf5','//RawData/AcquisitionTaskDescription'));%A
% data = cell2mat(h5read('D:\Documents_D\Imperial_D\EEG_data\Pilot6\RecordSession_P6_testpilot12021.07.14_13.56.05.hdf5','//RawData/AcquisitionTaskDescription'));


C = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'HeaderLines', 1);
fclose(fid);

%Extract variables from cell
raw_time = C{1};
raw_trial_num = C{2};
target_angle = C{3};
rest_active = C{40};
actual_time = C{39};

trial_num_change = abs(conv(raw_trial_num,[1 -1])) > 0;%set trial change positions to 1 otherwise zero
trial_start_indicies = find(trial_num_change==1)%find indices of trial start time
trial_durations = diff(trial_start_indicies)%find duration of each trial - every 2300 samples
n = 1:(size(trial_start_indicies)-1)

trial_end_indicies = trial_start_indicies(2:end) - 1
trial_start_indicies = trial_start_indicies(1:end-1)

trial_start_times(n) = actual_time(trial_start_indicies(n))%find corresponding times of trial number change
trial_end_times(n) = actual_time(trial_end_indicies(n))%find corresponding times of trial number change

trial_time_durations = trial_end_times-trial_start_times%find corresponding change of time duration of trials - these are different
%same as above but for events (trial start times and motion begin/rest end
event_num_change = abs(conv(rest_active,[1 -1]));%find trial and event time changes
event_start_indicies = find(event_num_change==4)
event_durations = diff(event_start_indicies)
% start times for both trial start times and motion begin/rest

% event_start_indicies = event_start_indicies;
event_end_indicies = event_start_indicies(2:end)-1;

n = 1:(size(event_start_indicies)-1);
event_start_times(n) = actual_time(event_start_indicies(n));
event_end_times(n) = actual_time(event_end_indicies(n));

event_start_time_durations = diff(event_start_times);
event_time_end_durations = diff(event_end_times);

n = 30000
% plot(actual_time(1:n),target_angle(1:n),'m')
% hold on
% plot(actual_time(1:n),rest_active(1:n),'g')
% legend('target angle','rest or trial')

% plot(event_end_times(1:20),6,'-o')


time = cell2mat(extractBetween(data,strfind(data,'<RecordingDateBegin>')+20,strfind(data,'</RecordingDateBegin>')-1))

year = str2double(extractBetween(time,1,4))
month = str2double(extractBetween(time,6,7))
day = str2double(extractBetween(time,9,10))
hour = str2double(extractBetween(time,12,13))
minute = str2double(extractBetween(time,15,16))
second = str2double(extractBetween(time,18,19))
ms = str2double(extractBetween(time,21,27))/10000

D = datetime(year,month,day,hour,minute,second)

format long
EEGstarttime = (double(convertTo(D,'epochtime','Epoch','1904-01-01','TicksPerSecond',1000))+ms)/1000%%EEG start time
Eventstarttime=event_start_times(1)%%event start times
zero_calibration =  -EEGstarttime + Eventstarttime;

event_start_times = event_start_times - Eventstarttime+zero_calibration;
event_end_times = event_end_times-Eventstarttime+zero_calibration;


events = sort([event_start_times event_end_times]);%combine events

%write to file
a = events;
x = diff(events);
fileID = fopen('EventstoImport2.txt','w');
fprintf(fileID,'latency\ttype\n');

type = ""

for i = 1:size(a')
    
if mod(i,4) == 1
    type = "RestStart";
elseif mod(i,4) == 2
    type = "RestEnd";
elseif mod(i,4) == 3
    type = "MotionStart";
elseif mod(i,4) == 0
    type = "MotionEnd";
end
    
fprintf(fileID,'%f\t'+type+'\n',a(i));
type
a(i)
end

fclose(fileID);
