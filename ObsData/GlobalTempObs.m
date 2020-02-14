
%% 1a. Read in the file for your station as a data table

world = 'global_temp.xls';

stationdata_glob = readtable(world);

 figure(1)
 plot(stationdata_glob.Year,stationdata_glob.Jan,'-o')
 xlabel('Year')
 ylabel('Temperature ^{\circ}C')
 title('January Climatological Temperature Globally')

%%

JanMean_glob = nanmean(stationdata_glob.Jan);
JanStd_glob = nanstd(stationdata_glob.Jan);
JanMin_glob = min(stationdata_glob.Jan);
JanMax_glob = max(stationdata_glob.Jan);

%%
tempData_glob = table2array(stationdata_glob(:,2:13));
tempMean_glob = nanmean(tempData_glob);
tempStd_glob = nanstd(tempData_glob);
tempMin_glob = min(tempData_glob);
tempMax_glob = max(tempData_glob);

%%

figure(2); clf
    errorbar(tempMean_glob,tempStd_glob)
    xlim([0 13])
    xlabel('Month of the Year') 
    ylabel('Temperature ^{\circ}C')
    title('Monthly Climatological Temperature Globally')
    
%%
% We can do this by looping over each month in the year:
for i = 1:12
    %use the find and isnan functions to find the index location in the
    %array of data points with NaN values
    indnan = find(isnan(tempData_glob(:,i)) == 1); %check to make sure you understand what is happening in this line
    %now fill the corresponding values with the climatological mean
    %tempData_new = fillmissing(tempData,'constant',tempMean) <--- this works too with one line of code
    tempData_glob(indnan,i)=tempMean_glob(i);
   
end
    
%%

  annualMean_glob=mean(tempData_glob,2)
  
%%

%Calculate the annual mean temperature over the period from 1981-2000
  %Use the find function to find rows contain data where stationdata.Year is between 1981 and 2000
 I = find(stationdata_glob.Year > 1980 & stationdata_glob.Year < 2001);
 
  %Now calculate the mean over the full time period from 1981-2000
  
 periodamean_glob=mean(annualMean_glob(I));

%Calculate the annual mean temperature anomaly as the annual mean
%temperature for each year minus the baseline mean temperature
Anom_glob=annualMean_glob-periodamean_glob;

%Range for extension Part 2 


Ir = find(stationdata_glob.Year >= 1960)

range_year = stationdata_glob.Year(Ir)
range_anom = Anom_glob(Ir)
[P_glob] = polyfit(range_year, range_anom,1)
