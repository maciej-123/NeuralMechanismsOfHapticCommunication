% pop_timtopo() - call the timtopo() function for epoched EEG datasets. 
%                 Plots the epoch mean for each channel on a single axis,
%                 plus scalp maps of the data at specified latencies.
% Usage:
%   >> pop_timtopo( EEG, timerange, topotimes, title, 'key', 'val', ...);
%
% Inputs:
%   EEG         - input dataset
%   timerange   - [min max] epoch time range (in ms) to plot 
%   topotimes   - array of times to plot scalp maps {Default: NaN 
%                 = display scalp map at frame of max var()}
%
% Optional inputs:
%   title       - optional plot title
%   'key','val' - optional topoplot() arguments (see >> help topopleclot)
%
% Author: Arnaud Delorme, CNL / Salk Institute, 2001
%
% See also: timtopo()

function com = pop_timtopo_( EEG,chans,title, timerange, topotime, plottitle, varargin);

com = '';
if nargin < 1
	help pop_timtopo;
	return;
end;	

if nargin < 3
    uilist = { { 'style' 'text' 'string' 'Plotting time range (ms):' } ...
               { 'style' 'edit' 'string' '' 'tag' 'timerange' } ...
               { 'style' 'text' 'string' 'Scalp map latencies (ms, NaN -> max-RMS)' } ...
               { 'style' 'edit' 'string' 'NaN' 'tag' 'topotime' } ...
               { 'style' 'text' 'string' 'Plot title:' } ...
               { 'style' 'edit' 'string' '' 'tag' 'title'  } ...
               { 'style' 'text' 'string' 'Scalp map options (see >> help topoplot):' } ...
               { 'style' 'edit' 'string' '' 'tag' 'options' } };
    uigeom = { [2 1] [2 1] [2 1] [2 1] };
    evalstr = [ 'set(findobj(gcf, ''tag'', ''timerange''), ''string'', ''' [num2str( EEG.xmin*1000) ' ' num2str(EEG.xmax*1000)] ''');' ...
                'set(findobj(gcf, ''tag'', ''title''), ''string'', ''' ['ERP data and scalp maps' fastif(~isempty(EEG.setname), [' of ' EEG.setname ], '') ] ''');' ...
                ];
    args = { 'uilist', uilist, 'geometry', uigeom, 'helpcom', 'pophelp(''pop_timtopo'')', 'eval', evalstr };

	result       = inputgui( args{:} );
    
	if size(result,1) == 0 return; end
	timerange    = eval( [ '[' result{1} ']' ] );
	topotime     = eval( [ '[' result{2} ']' ] );
	plottitle    = result{3};
	options      = [ ',' result{4} ];
	figure;
else
	options = [];
	for i=1:length( varargin )
		if ischar( varargin{ i } )
			options = [ options ', ''' varargin{i} '''' ];
		else
			options = [ options ', [' num2str(varargin{i}) ']' ];
		end
	end;	
end
try, icadefs; set(gcf, 'color', BACKCOLOR, 'Name', ' timtopo()'); catch, end

if exist('plottitle') ~= 1
    plottitle = ['ERP data and scalp maps' fastif(~isempty(EEG.setname), [' of ' EEG.setname ], '') ];
end
    
if ~isempty(EEG.chanlocs)
    if ~isfield(EEG, 'chaninfo'), EEG.chaninfo = []; end
	SIGTMP = reshape(EEG.data, size(EEG.data,1), EEG.pnts, EEG.trials);
	posi = round( (timerange(1)/1000-EEG.xmin)/(EEG.xmax-EEG.xmin) * (EEG.pnts-1))+1;
	posf = round( (timerange(2)/1000-EEG.xmin)/(EEG.xmax-EEG.xmin) * (EEG.pnts-1))+1;
	if length( options ) < 2
%         timtopo_(mean(SIGTMP(:,posi:posf,:),3), EEG.chanlocs(:), 'limits', [timerange(1) timerange(2) 0 0], 'plottimes', topotime,'plotchans',chan, 'chaninfo', EEG.chaninfo);
        

        timtopo(mean(SIGTMP(:,posi:posf,:),3), EEG.chanlocs(:), 'limits', [timerange(1) timerange(2) 0 0], 'plottimes', topotime,'plotchans',chans,'title',title,'chaninfo', EEG.chaninfo);


        com = sprintf('figure; pop_timtopo(EEG, [%s], [%s], ''%s'');', num2str(timerange), num2str(topotime), plottitle);
	else
		com = sprintf('timtopo( mean(SIGTMP(:,posi:posf,:),3), EEG.chanlocs, ''limits'', [timerange(1) timerange(2) 0 0], ''plottimes'', topotime,''chaninfo'',EEG.chaninfo %s);', options);
		eval(com)
	    com = sprintf('figure; pop_timtopo(EEG, [%s], [%s], ''%s'' %s);', num2str(timerange), num2str(topotime), plottitle, options);
	end;		
else
	fprintf('Cannot make plot without channel locations\n');
	return;
end
return;

		