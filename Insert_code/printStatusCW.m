filepath=cd;
%% Determine how many steps is in optimization
% if strfind(method,'3step')
%     steps=3;
% elseif strfind(method,'6step')
%     steps=6;
% elseif strfind(method,'9step')
%     steps=9;
% elseif strfind(method,'standard')
%     steps=1;
% elseif strfind(method,'singleParScan')
%     steps=3;
% end

if strcmp(printStep,'initialize') || strcmp(printStep,'failed') 
    time=0;
    Price=0;
    Intensity=0;
    iters=0;
else
    % time
    hours = floor(time / 3600);
    time = time - hours * 3600;
    mins = floor(time / 60);
    secs = time - mins * 60;
    % Price
    if strcmp(printStep,'stepScan')>0
    else
        try
            [m,index]=max(abs(o.criteriaHistory));
            Price=ValueList(index);
        catch
            
        end
    end
    % Intensity
    if strcmp(mode,'coating')
        Intensity=o.criteriaBest;
    else
        if strcmp(printStep,'stepScan')==0
            try
                Intensity=o.criteriaBest*Price;
            catch
                
            end
        else
            try
                Intensity=bestCrit*Price;
            end
        end
    end
    if exist('nFUN_EVALS')
	iters = nFUN_EVALS;
    elseif exist('o') && strcmp(printStep,'optimize') 
        iters=iters+length(o.criteriaHistory);
    end
end


%% Total status file
 idcs   = strfind(filepath,'/');
 RunStatuspath = filepath(1:idcs(end)-1);

%A=importdata('RunStatus.txt');

fileID=fopen([RunStatuspath '/RunStatus.txt'],'r'); 
II = 1;
tline = fgetl(fileID);
A{II} = tline;
while ischar(tline)
	II = II+1;
	tline = fgetl(fileID);
	A{II} = tline;
end
A(end)=[];  
fclose(fileID); 

for II=1:length(A)
    if strfind(A{II},sprintf('%3i |',runID))
        ID=II;
        II=length(A);
    end
end


switch printStep
    case 'stepScan' 
        stepwiseProgress=100*doneSegments/totalSegments;
        A{ID}=sprintf('%3i | %15s |%11s| %i/%i (%3.1f%%)| %9.6f | %5.2f | %5i |',runID,[instrument_name scanname],'stepScan',step,steps,stepwiseProgress,Intensity,Price,iters);
    case 'optimize' 
        A{ID}=sprintf('%3i | %15s |%11s|    %i/%i    | %9.6f | %5.2f | %5i |',runID,[instrument_name scanname],'Optimizing',step,steps,Intensity,Price,iters);
    case 'initialize'
        A{end+1}=sprintf('%3i | %15s |%11s|    %i/%i    |   %5s   | %7s | %5s |',runID,[instrument_name scanname],'Optimizing',0,steps,'n/a','n/a','n/a');
    case 'analyze'
        A{ID}=sprintf('%3i | %15s |%11s|    %i/%i    | %9.6f | %5.2f | %5i |',runID,[instrument_name scanname],'Analyzing',step,steps,Intensity,Price,iters);
    case 'finish'
        A{ID}=sprintf('%3i | %15s |%11s|    %i/%i    | %9.6f | %5.2f | %5i |',runID,[instrument_name scanname],'Finished',step,steps,Intensity,Price,iters);
    case 'failed' 
        A{ID}=sprintf('%3i | %15s |%11s|    %i/%i    |   %5s   | %7s | %5s |',runID,[instrument_name scanname],'Failed',step,steps,'n/a','n/a','n/a');
end
done=1;
    

fileID=fopen([RunStatuspath '/RunStatus.txt'],'w');

fileID=fopen([RunStatuspath '/RunStatus.txt'],'w');
for I=1:length(A)
    fprintf(fileID,'%s\n',A{II})
end  
fclose(fileID);  

