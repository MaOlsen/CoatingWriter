pause(rand()*15)
printScript=fileread([cd '/printStatusCW.m']);
tmpFolder=cd;
cd ..
outputFile=fileread([cd '/RunStatus.txt']);
cd(tmpFolder)
runID=1;
while true
	if strfind(outputFile,sprintf('%3i |',runID))
		runID=runID+1
    else
        break
	end
end
Timing_optim=tic;

method='standard';
tic;
steps=1;
%%%%%%%%%%
printStep='initialize';
time=toc;
try;eval(printScript);end
%%%%%%%%%%
step=1;
addpath(genpath(pwd))
[pars,monitor,m,o] = mcstas([instrument_name '_optimize.instr'],p,options{select});
pars1=pars;
runResults(1)=o.criteriaBest;
ValueList=load(['priceList' scanname '.txt']);
ValueList=ValueList(1:end-1);
ValueList(1:length(o.criteriaHistory),2)=o.criteriaHistory';
tmp=load(['priceListPunished' scanname '.txt']);
ValueList(:,3)=tmp(1:length(ValueList));
Result_this.valueList=ValueList;
delete(['priceList' scanname '.txt']);delete(['priceListPunished' scanname '.txt']);
TimeTable.ifitOptimize=toc(Timing_optim);

Timing_StepScan=tic;
%% ADDSTEPSCAN %%
TimeTable.stepScan=toc(Timing_StepScan);

%%%%%%%%%%
printStep='analyze';
time=toc;
try;eval(printScript);end
%%%%%%%%%%
monitor_ideal=monitor;
