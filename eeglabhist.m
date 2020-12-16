% EEGLAB history file generated on the 14-Nov-2020
% ------------------------------------------------

%%  MSE491 - Signal Processing Assignment - Fall 2020 - EEGLAB History Script
%   Commented by: Junaid Jawed Khan
%   Prepared for: Benjamin & Dr.Faranak Farzan

%%  Common Functions in each section:
%      - Function 'eeg_checkset( EEG )': checks the consistency of the current dataset fields 
%      -  pop_newset (): Saves the changes made to current dataset as a new
%         dataset.   
%% Importing Subject 8 Data into EEGLAB

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig('EEG_Cat_Study5_Resting_S8.bdf');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','Subject8Data','gui','off'); 
EEG = eeg_checkset( EEG );

%% Remove DC Offset from Channel Data, Save New Dataset and Plot Channel Data 
EEG = pop_rmbase( EEG, [],[]); %Failed Removal of DC offset -> Done again using eeglab plot 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Subject8Data_RemovedDCOffset','savenew','Subject8_RemovedDCOffset.set','gui','off'); % Save the new datset - failed DC removal
EEG = eeg_checkset( EEG ); 
pop_eegplot( EEG, 1, 1, 1);   % Plot channel Data
EEG = eeg_checkset( EEG );

%% Extracting Epochs, Saving New Dataset, Removing DC Offset using Channel Plot 

EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'Subject8Data_RemovedDCOffSet Epochs', 'epochinfo', 'yes'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew','Subject8Data_RemovedDCOffset_ExtractedEpochs.set','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000 0] ,[]); % Eeglab didn't remove DC offset before, removed DC offset using Channel Plot
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','Subject8Data_RemovedDCOffSetEpochs','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochs.set','gui','off'); 

%% Uploading Channel Information, Storing Channel Information
EEG=pop_chanedit(EEG, 'lookup','eeglab2020_0/plugins/dipfit/standard_BESA/standard-10-5-cap385.elp'); %uploading channel information - location
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); %storing channel information to workspace
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [-1000      1996.0938], 'EEG' , 'percent', 50, 'freq', [6 10 22], 'freqrange',[2 128],'electrodes','off');
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo); %Plotting channel information with labels using 10-20 system
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'numpoint', 'chaninfo', EEG.chaninfo); % Plotting channel information with labels using numbers
EEG = eeg_checkset( EEG );

%% Calculating Average Reference - Excluding All EOG Channels, Saving the New Dataset
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [],'exclude',[65 66 68 69:71] ); % Calculating Average Reference excluding Channels M1, M2 and all EOG channels 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'setname','Subject8Data_RemovedDCOffSetEpochsAverageReferenceApplied','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceApplied.set','gui','off'); %Storing new dataset after applying average referencing
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1); % Plotting channel data after applying average referencing
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [-1000      1996.0938], 'EEG' , 'percent', 50, 'freq', [6 10 22], 'freqrange',[2 128],'electrodes','off'); %Plotting Channel PSD and Topographs of frequencies 6,10 and 22 Hz
EEG = eeg_checkset( EEG );

%% Applying High-pass Filter at 1Hz - To remove drifting effect from Channel Data, Saving the filtered Dataset
EEG = pop_eegfiltnew(EEG, 'locutoff',1); %Applying High-pass filter at 1Hz to remove drift effect from channel data
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'setname','Subject8Data_RemovedDCOffSetEpochsAverageReferenceAppliedRemoveDriftEffect','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffect.set','gui','off'); %Storing new dataset after applying high-pass filter at 1Hz
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1); % Plot channel data after removing drift effect
EEG = eeg_checkset( EEG );

%% Applying Notch Filter at [58Hz,62Hz]  - To remove 60Hz Line Noise, Saving the filtered Dataset
EEG = pop_eegfiltnew(EEG, 'locutoff',58,'hicutoff',62,'revfilt',1); % Applying notch filter to remove freqeuncies between 58-62Hz from the channel data 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'setname','Subject8Data_RemovedDCOffSetEpochsAverageReferenceAppliedRemoveDriftEffectRemovedLineNoise','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffectRemovedLineNoise.set','gui','off'); %Saving new dataset after applying notch filter to remove line noise
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1); %Plot channel data to look at the channel data after removing line noise. 
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [-1000      1996.0938], 'EEG' , 'percent', 50, 'freq', [6 10 22], 'freqrange',[2 128],'electrodes','off'); % Plot channel PSD to check if power aroundf 60Hz reduced. 
EEG = eeg_checkset( EEG );

%% Removing 'Bad Channels' - M1 and M2 do not follow the 10-20 Standard Electrode Placing System, Saving the new Dataset
EEG = pop_select( EEG, 'nochannel',{'M1','M2'}); % Removing channels M1 and M2 because they don't follow the 10-20 standard electrode naming convention
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'setname','Subject8Data_RemovedDCOffSetEpochsAverageReferenceAppliedRemoveDriftEffectRemovedLineNoiseRemovedChannelM1M2','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffectRemovedLineNoiseRemovedChannelM1AndM2.set','gui','off'); % Save as new dataset after removing channels M1 and M2
EEG = eeg_checkset( EEG );

%% Independent Component Analysis - FastICA to determine the independent sources in captured channel data 
% Commented this as I've included by dataset after performing the ICA, each
% time you run fastICA you get a different output so you might end up
% removing a different component than what I did for my report. 
% 

% EEG = eeg_checkset( EEG );
% EEG = pop_runica(EEG, 'icatype', 'fastica'); % Run ICA algorithm on dataset to identify statistically independent sources 
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); % store the identified sources as components in the EEG structure 
% EEG = eeg_checkset( EEG );
% EEG = pop_iclabel(EEG, 'default'); % Add labels to each ICA component identified by the decomposition using fastICA 
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); % Store labels in the EEG structure
% EEG = eeg_checkset( EEG );
% EEG = pop_subcomp( EEG, [1   3  12  15], 0); % Remove desired IC components from EEG data structure 
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'setname','Subject8Data_RemovedDCOffSetEpochsAverageReferenceAppliedRemoveDriftEffectRemovedLineNoiseRemovedChannelM1M2PrunedWithICARemovedComponents1_3_12_15','savenew','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffectRemovedLineNoiseRemovedChannelM1AndM2PrunedWithICARemovedComponents1_3_12_15.set','gui','off'); %Save as new dataset  
% EEG = eeg_checkset( EEG );
% pop_eegplot( EEG, 1, 1, 1); % Plot channel data after removing noise and eye artifacts from each channel
% EEG = eeg_checkset( EEG );

%% Feature Extraction - Time-Frequency Analysis
% Plotting time-frequency decomposition (function-> pop_newtimef()) for channels O2, Oz, O1, PO3, POz and PO4
% For each time-frequency decomposition I used '3' Cycle wavelet at the lowest 6Hz
% frequency and this wavelet cycle increases linearly by a factor of '0.5'
% as you go up the frequency axis (higher frequencies)
EEG = pop_loadset('filename','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffectRemovedLineNoiseRemovedChannelM1AndM2PrunedWithICARemovedComponents1_3_12_15.set','filepath',''); % Had to reload the previous section's dataset, i.e. dataset after removing IC components 
EEG = eeg_checkset( EEG ); 
figure; pop_newtimef( EEG, 1, 64, [-1000  1996], [3         0.5] , 'topovec', 64, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'O2', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 29, [-1000  1996], [3         0.5] , 'topovec', 29, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'Oz', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 27, [-1000  1996], [3         0.5] , 'topovec', 27, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'O1', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 26, [-1000  1996], [3         0.5] , 'topovec', 26, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO3', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 30, [-1000  1996], [3         0.5] , 'topovec', 30, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'POz', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);
EEG = eeg_checkset( EEG );
figure; pop_newtimef( EEG, 1, 63, [-1000  1996], [3         0.5] , 'topovec', 63, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO4', 'baseline',[0], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1, 'winsize', 256);

%% Cross-Channel Coherency plot between Channels Oz and O1 
%  Knowing each ICA run gives different results, I stored the dataset where
%  I removed IC 1, 3 12 and 15 from my channel
%  In this section I'm reusing that dataset, so i had to upload it into
%  eeglab - line 112

EEG = pop_loadset('filename','Subject8Data_RemovedDCOffset_ExtractedEpochsAverageReferenceAppliedRemovedDriftEffectRemovedLineNoiseRemovedChannelM1AndM2PrunedWithICARemovedComponents1_3_12_15.set','filepath',''); % Had to reload the previous section's data set as I carried out channel-coherency in a separate session
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 9 ); % Store the previous dataset in the EEG structure
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1); % Plot channel data just to be sure if I got the correct dataset
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [-1000      1996.0938], 'EEG' , 'percent', 50, 'freq', [6 10 22], 'freqrange',[2 128],'electrodes','off'); % Plot PSD from 0-128Hz (Nyquist frequency) to ensure no 60Hz noise - just double checking if I'm using the right dataset
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'numpoint', 'chaninfo', EEG.chaninfo); % Plot channel locoation by number - to ensure channels M1 and M2 are not included
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo); % Plot channel locoation by number - to ensure channels M1 and M2 are not included
figure; pop_newcrossf( EEG, 1, 29, 27, [-1000  1996], [3         0.5] ,'type', 'phasecoher', 'topovec', [29  27], 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'title','Channel Oz-O1 Phase Coherence','padratio', 1, 'plotphase', 'off'); % checking phase synchronization between channels Oz and O1 using a 3 cycle wavelet at lowest frequency (6Hz), followed by increase in cycles by a factor of 0.5
EEG = eeg_checkset( EEG );
%% End of EEGLAB Script
eeglab redraw;
