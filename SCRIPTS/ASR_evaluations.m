%make sure that ddataset 1 is ICA before ASR and dataset 2 is an ASR
%filtered set.

%datasets
X1=ALLEEG(1).data;
X2=ALLEEG(2).data;
%ICA weight matrices
W1 = ALLEEG(1).icaweights;
W2 = ALLEEG(2).icaweights;

%classifiaction
classes1 = ALLEEG(1).etc.ic_classification.ICLabel.classifications;
classes2 = ALLEEG(2).etc.ic_classification.ICLabel.classifications;
classes = ALLEEG(2).etc.ic_classification.ICLabel.classes;

%obtain ICS pinv is the pseudo inverse
Y1 = W1*X1;
Y2 = W1*X2;


%% overall power reduction
%mean rms of components - where rms represents power
power1 = var(Y1');
power2 = var(Y2');
meanVar1 = mean(power1);
meanVar2 = mean(power2);

%calculate total average power reduction - if negative and set 2 is an ICA
%filtered set, then the overall power has been reduced
PowerReduction = meanVar2 - meanVar1;


%% Component Reduction
PowerReductionComp = power2-power1;
[corr,indx,indy,corrs]=matcorr(Y1,Y2);

v=zeros(1,32);
i=1:32;
v(i) = 100*var(Y1(i,:)')/sum(var(Y1'));

%change in classifications
format long
classes_diff = (classes2 - classes1)./classes1;
classes_change = classes_diff > 0;

%%

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

myColorMap = jet(256);
myColorMap(1,:) = 1;
colormap(myColorMap);

caxis([0 max])

colorbar



