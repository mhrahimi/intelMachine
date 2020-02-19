function mPlotter(inputTable)
% mPlotter  It is weirly broken.


savePlotsIsOn = 0;

time = util.
(:,1);

[P1, f] = fftHandler(inputTable);

units = inputTable.Properties.VariableUnits;
titles = inputTable.Properties.VariableNames;
numOfUnits = length(titles);

% legends
for i = 2:numOfUnits
    fullTitle = strsplit(char(titles(i)), '_');
    plotTitle(i,:) = fullTitle(1);
    if length(fullTitle) > 1            % when we have more than one of a sensor
        plotLegend(i,:) = fullTitle(2); 
    else
        plotLegend(i,:) = plotTitle(i,:);
    end
end

i = 2;
while i <= numOfUnits
    figure;
    subplot(2,1,1);
    plot(table2array(time), table2array(inputTable(:,i)))
    thisLegend = plotLegend(i,:);
    hold on
    
    subplot(2,1,2);
    plot(f, P1(:,i));
    hold on
    
    i = i+1;
    while ((i < numOfUnits) & (strcmp(char(plotTitle(i-1)), char(plotTitle(i)))))
        subplot(2,1,1);
        plot(table2array(time), table2array(inputTable(:,i)))
        thisLegend = [thisLegend, plotLegend(i,:)];
        
        subplot(2,1,2);
        plot(f, P1(:,i));
        i = i+1;
    end
    subplot(2,1,1);
    title(plotTitle(i-1));
    legend(thisLegend);
    xlabel(['Time (', char(units(1)), ')']);
    ylabel([char(plotTitle(i-1)), ' (', char(units(i-1)), ')'])
    
    subplot(2,1,2);
    title(['FFT of ', char(plotTitle(i-1))])
    xlabel('f (Hz)')
    ylabel('Amplitude')
    
    if savePlotsIsOn
        savefig(['figures', filesep, char(plotTitle(i-1)), '.fig']);
        saveas(gcf,['figures', filesep, char(plotTitle(i-1)), '.png']);
    end
end

end