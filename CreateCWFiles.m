function [] = CreateCWFiles(inputString,directory,folder)
%CREATECWFILES Creates input files for CoatingWriter
%   Using a guide_bot input string to create the input files for CW
%   This is usefull since the options varry from one segment type to
%   another

cd(folder)
directory=cd;
%% Make path windows-compatible
thisPath=cd;
nslash=length(strfind(thisPath,'/'));
nbackslash=length(strfind(thisPath,'\'));
if nslash<nbackslash
    slash='\';
else
    slash='/';
end


%% Load beginning of the file
fileID=fopen('InitHeader.m','r');
i = 1;
tline = fgetl(fileID);
A{i} = tline;   % A is the list of lines in the init-file.
 while ischar(tline)
    i = i+1;
    tline = fgetl(fileID);
    A{i} = tline;
end
fclose(fileID); 
L=length(inputString);
for i=1:L
    switch inputString(i)
        case 'P'
            A{end+1}=[''];
            A{end+1}=['    %Segment ' num2str(i) ' is type P - a parabolic guide section'];
            A{end+1}=['    CW_input.Input' num2str(i) '.type=''P''             % Guide_bot segmet type '];
            A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''      % Determines input variables. "specific" is advised in this version of CoatingWriter'];
            A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''power'' % The coating distribution. Choose from: ''constant'' ''exp'' ''linear'' and ''power'''];
            A{end+1}=['    CW_input.Input' num2str(i) '.minCenter=0;          % center of the distribution in relative coordinates (from 0 to 1)'];
            A{end+1}=['    CW_input.Input' num2str(i) '.maxCenter=1;'];
            A{end+1}=['    CW_input.Input' num2str(i) '.fixSides=''HV'';        % Optimize sides together. Options are: ''HV'', ''curve'', ''all'', ''none''. (''HV'' optimizes horizontal and vertical independantly)'];
            A{end+1}=['    CW_input.Input' num2str(i) '.deltaM=0.5;           % The lowest amount the m-value can change each step'];
            A{end+1}=['    CW_input.Input' num2str(i) '.mStepLength=0.5;      % The length of mirrors where m-value must be kept constant'];
            A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_under=1;    % Hard limit to lowest m-value'];
            A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_over=6;     % Hard limit to highest m-value'];
            A{end+1}=['    CW_input.Input' num2str(i) '.minPower=1;           % N is the power '];
            A{end+1}=['    CW_input.Input' num2str(i) '.maxPower=6;'];
            if i<3
                A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''RH''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
            else
                A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''BK''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
            end
        case 'E'
                A{end+1}=[''];
                A{end+1}=['    %Segment ' num2str(i) ' is type E - an elliptic guide section'];
                A{end+1}=['    CW_input.Input' num2str(i) '.type=''E''             % Guide_bot segmet type '];
                A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''      % Determines input variables. "specific" is advised in this version of CoatingWriter'];
                A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''power'' % The coating distribution. Choose from: ''constant'' ''exp'' ''linear'' and ''power'''];
                A{end+1}=['    CW_input.Input' num2str(i) '.minCenter=0;          % center of the distribution in relative coordinates (from 0 to 1)'];
                A{end+1}=['    CW_input.Input' num2str(i) '.maxCenter=1;'];
                A{end+1}=['    CW_input.Input' num2str(i) '.fixSides=''HV'';        % Optimize sides together. Options are: ''HV'', ''curve'', ''all'', ''none''. (''HV'' optimizes horizontal and vertical independantly)'];
                A{end+1}=['    CW_input.Input' num2str(i) '.deltaM=0.5;           % The lowest amount the m-value can change each step'];
                A{end+1}=['    CW_input.Input' num2str(i) '.mStepLength=0.5;      % The length of mirrors where m-value must be kept constant'];
                A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_under=1;    % Hard limit to lowest m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_over=6;     % Hard limit to highest m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.minPower=1;           % N is the power '];
                A{end+1}=['    CW_input.Input' num2str(i) '.maxPower=6;'];
                 if i<3
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''RH''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                else
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''BK''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                end
        case 'C'
                A{end+1}=[''];
                A{end+1}=['    %Segment ' num2str(i) ' is type C - a curved guide section'];
                A{end+1}=['    CW_input.Input' num2str(i) '.type=''C''             % Guide_bot segmet type '];
                A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''      % Determines input variables. "specific" is advised in this version of CoatingWriter'];
                A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''constant'' % The coating distribution. Choose from: ''constant'' ''exp'' ''linear'' and ''power'' '];
                A{end+1}=['    CW_input.Input' num2str(i) '.fixSides=''curve''        % Optimize sides together. Options are: ''HV'', ''curve'', ''all'', ''none''. (''HV'' optimizes horizontal and vertical independantly)'];
                A{end+1}=['    CW_input.Input' num2str(i) '.deltaM=0.5           % The lowest amount the m-value can change each step'];
                A{end+1}=['    CW_input.Input' num2str(i) '.mStepLength=0.5      % The length of mirrors where m-value must be kept constant'];
                A{end+1}=['    CW_input.Input' num2str(i) '.minM=1;              % Minimum m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.maxM=6;              % Maximum m-value'];
                if i<3
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''RH''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                else
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''BK''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                end
        case 'S'
                A{end+1}=[''];
                A{end+1}=['    %Segment ' num2str(i) ' is type S - a straight guide section'];
                A{end+1}=['    CW_input.Input' num2str(i) '.type=''S''             % Guide_bot segmet type '];
                A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''      % Determines input variables. "specific" is advised in this version of CoatingWriter'];
                A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''constant'' % The coating distribution. Choose from: ''constant'' ''exp'' ''linear'' and ''power'' '];
                A{end+1}=['    CW_input.Input' num2str(i) '.fixSides=''HV''        % Optimize sides together. Options are: ''HV'', ''curve'', ''all'', ''none''. (''HV'' optimizes horizontal and vertical independantly)'];
                A{end+1}=['    CW_input.Input' num2str(i) '.deltaM=0.5           % The lowest amount the m-value can change each step'];
                A{end+1}=['    CW_input.Input' num2str(i) '.mStepLength=0.5      % The length of mirrors where m-value must be kept constant'];
                A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_under=1;    % Hard limit to lowest m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.remove_m_over=6;     % Hard limit to highest m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.minM=1;              % Minimum m-value'];
                A{end+1}=['    CW_input.Input' num2str(i) '.maxM=6;              % Maximum m-value'];
                if i<3
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''RH''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                else
                    A{end+1}=['    CW_input.Input' num2str(i) '.substrate=''BK''; %Swizz Neutronics materials. Metal: ''RH'', Borfloat: ''BF'', Borkron: ''BK'', Sodium: ''NA'''];
                end
                
        case 'G'
                A{end+1}=[''];
                A{end+1}=['    %Segment ' num2str(i) ' is type G - a gap'];
                A{end+1}=['    CW_input.Input' num2str(i) '.type=''G'''];
                A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''       %Nothing else will work for gap'];
                A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''none''   %Coating on a gap makes no sense'];
                         
        case 'K'
                A{end+1}=[''];
                A{end+1}=['    %Segment ' num2str(i) ' is type K - a kink'];
                A{end+1}=['    CW_input.Input' num2str(i) '.type=''G'''];
                A{end+1}=['    CW_input.Input' num2str(i) '.mode=''specific''       %Nothing else will work for gap'];
                A{end+1}=['    CW_input.Input' num2str(i) '.distribution=''none''   %Coating on a gap makes no sense'];
    end
end


%% Add performance options
A{end+1}=[''];
A{end+1}=[''];
A{end+1}=['%% 4 Performance Options'];
A{end+1}=['% Change optimizer mode, resolution and toggle simple-analyze mode'];
A{end+1}=[''];
A{end+1}=['% Optimizer mode'];
A{end+1}=['%     Choose from:'];
A{end+1}=['%     ''standard'' - run the iFit once with all parameters'];
A{end+1}=['%     ''3step'' - run the iFit three times - geometry only, coating only and geometry again. Previous best pars used in next optimzation'];
A{end+1}=['%           '' +A'' to analyze each step. ']
A{end+1}=['%           '' +C'' to make fist step m=6 and optimize this for pure brilliance transfer. ']
A{end+1}=['%     ''6step'' - run the iFit six times - geometry only, coating only and all variables two times.'];
A{end+1}=['%           '' +A'' to analyze each step. ']
A{end+1}=['%           '' +C'' to make fist step m=6 and optimize this for pure brilliance transfer. ']
A{end+1}=['%     ''9step'' - run the iFit nine times - geometry only, coating only and all variables three times.'];
A{end+1}=['%           '' +A'' to analyze each step. ']
A{end+1}=['%           '' +C'' to make fist step m=6 and optimize this for pure brilliance transfer. ']
A{end+1}=['%     BETA:  ''timelimit'' - run the iFit several times until a time limit is reached'];
A{end+1}=['%     BETA:  ''+S'' - CW StepScan. Scans every mirror after optimization to finetune distribution'];
A{end+1}=['%     ''singleParScan'' - run optimizer, scan all variables with hooke optimizer, and run optimizer again'];
A{end+1}=['%           '' +A'' to analyze each step. ']
A{end+1}=['CW_input.OptimizeMode=''standard'''];
A{end+1}=[''];
A{end+1}=['% Analyze mode'];
A{end+1}=['%     Choose from:'];
A{end+1}=['%     ''standard'' - run all analysis from guide_bot to create a detailed overview'];
A{end+1}=['%     ''reduced'' - run only one analysis for BT (recomended for price-scan)'];
A{end+1}=['CW_input.AnalyzeMode=''standard'''];
A{end+1}=[''];
A{end+1}=[''];
A{end+1}=['%Analyse each segment to see where neutrons are lost'];
A{end+1}=['CW_input.AnalyzeStepwise=''off'';     % ''on'' or ''off'''];
A{end+1}=[''];
A{end+1}=[''];
A{end+1}=['% Change neutron counts:'];
A{end+1}=['%    SpeedScanMode reduces the neutron count to 1*10^6 (1/9) and runs optimizations on a single core instead of 12 on ESS cluster.'];
A{end+1}=['%    If punishment method is ''potential'' the neutron count will be decreased if the price error is high to increase performance.']
A{end+1}=['CW_input.SpeedScanMode=''off'''];
A{end+1}=[''];
A{end+1}=['% Optimizer engine'];
A{end+1}=['%     Choose from:'];
A{end+1}=['%     iFit      Uses iFit optimization with particle swarm'];
A{end+1}=['%     CW_PSO    Particle swarm modified for use with CoatingWriter'];
A{end+1}=['CW_input.OptimizerEngine=''CW_PSO'''];

%% Add path and "run CW"
 A{end+1}=[''];
 A{end+1}=[''];
 A{end+1}=[''];
 A{end+1}=['%% All done - Next lines will run CoatingWriter with the specified parameters'];
 A{end+1}=[''];
 A{end+1}=['% Set path:'];
 A{end+1}=['CW_input.filePath= [cd ''/'',''' inputString '''];'];
 A{end+1}=[''];
 A{end+1}=['% Run CoatingWriter:'];
 A{end+1}=['CoatingWriter(CW_input);'];
 
 
%% Write all to file
fileID=fopen([directory slash 'Add_CoatingWriter_' inputString '.m'],'w');
for i=1:length(A)
    fprintf(fileID,'%s\n',char(A{i}));
end
fclose(fileID);
cd ..
end

