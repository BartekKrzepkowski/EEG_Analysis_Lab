%% skrypt z forum EEGlaba - dzielenie caglych danych na okna - np 1 sekundowe

EEG = eeg_regepochs(EEG,'recurrence',1,'limits',[0 1], 'rmbase', NaN,'eventtype', 'ciach');%, 'extractepochs', 'on');
EEG = eeg_checkset(EEG);
eeglab redraw

%% 
% OBJAŚNIENIA SKRYPTU: 
% 	limits - to dlusc okna w sekundach  np = [0 1] - 1 sekunda
% 		% 		
% 		'rmbase', NaN,  - nie usuwaj sredniego poziomu
% 		'eventtype', 'ciach', - nadaje nazwe wstawianemu wirtualnemu znacznikowi
%% 
%from help:
% eeg_regepochs() - Convert a continuous dataset into consecutive epochs of 
%                   a specified regular length by adding dummy events of type 
%                   'X' and epoching the data around these events.
%                   The mean of each epoch (or if min epochlimits arg < 0,
%                   the mean of the pre-0 baseline) is removed from each 
%                   epoch. May be used to split up continuous data for
%                   artifact rejection followed by ICA decomposition.
%                   The computed EEG.icaweights and EEG.icasphere matrices
%                   may then be exported to the continuous dataset and/or 
%                   to its epoched descendents.
% Usage:
%     >> EEGout = eeg_regepochs(EEG); % use defaults
%     >> EEGout = eeg_regepochs(EEG, recurrence_interval, epochlimits); 
%     >> EEGout = eeg_regepochs(EEG, recurrence_interval, epochlimits, rmbase); 
%
% Required input:
%     EEG                 - EEG continuous data structure (EEG.trials = 1)
%
% Optional inputs:
%     recurrence_interval - [in s] the regular recurrence interval of the dummay
%                           'X' events used as time-locking events for the 
%                           consecutive epochs {default: 1 s}
%     epochlimits         - [minsec maxsec] latencies relative to the time-locking
%                           events to use as epoch boundaries. Stated epoch length 
%                           will be reduced by one data point to avoid overlaps 
%                           {default: [0 recurrence_interval]}
%     rmbase              - [NaN|latency] remove baseline. NaN does not remove
%                           baseline. 0 remove the pre-0 baseline. To
%                           remove the full epoch baseline, enter a value
%                           larger than the upper epoch limit. Default is
%                           0.
%
% Outputs:
%     EEGout              - the input EEG structure separated into consecutive 
%                           epochs.
%
% See also: pop_editeventvals(), pop_epoch(), rmbase();

% Authors: Hilit Serby & Scott Makeig, SCCN/INC/UCSD, Sep 02, 2005

% Copyright (C) Hilit Serby, SCCN, INC, UCSD, Sep 02, 2005, hilit@sccn.ucsd.edu
