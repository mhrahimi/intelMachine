close all

% function trainingStepsPlotter(ts)
ts = trainingSteps;
len = height(ts);
epochdiff = diff(ts.Epoch);

% f = figure;
subplot(2,1,1);
plot(ts.Iteration, ts.TrainingAccuracy, 'blue');
hold on
plot(ts.Iteration, ts.ValidationAccuracy, '* black');
xlabel("Iteration");
ylabel("Accuracy (%)");

subplot(2,1,2);
plot(ts.Iteration, ts.TrainingLoss, 'blue');
hold on
plot(ts.Iteration, ts.ValidationLoss, '* black');
xlabel("Iteration");
ylabel("Loss");

for i = 1:len-1
    if epochdiff(i) ~= 0
        subplot(2,1,1);
        xl = xline(ts.Iteration(i),'-',['Epoch ', num2str(ts.Epoch(i))],'DisplayName','Epochs');
        xl.LabelVerticalAlignment = 'bottom';
        xl.LabelHorizontalAlignment = 'left';
        xl.Color = 'blue';
        
        subplot(2,1,2);
        xl = xline(ts.Iteration(i),'-',['Epoch ', num2str(ts.Epoch(i))],'DisplayName','Epochs');
        xl.LabelVerticalAlignment = 'bottom';
        xl.LabelHorizontalAlignment = 'left';
        xl.Color = 'blue';
    end
end
subplot(2,1,1);
xl = xline(ts.Iteration(i),'-',['Epoch ', num2str(ts.Epoch(i+1))],'DisplayName','Epochs');
xl.LabelVerticalAlignment = 'bottom';
xl.LabelHorizontalAlignment = 'left';
xl.Color = 'blue';

subplot(2,1,2);
xl = xline(ts.Iteration(i),'-',['Epoch ', num2str(ts.Epoch(i+1))],'DisplayName','Epochs');
xl.LabelVerticalAlignment = 'bottom';
xl.LabelHorizontalAlignment = 'left';
xl.Color = 'blue';



subplot(2,1,1);
xlim([0 max(ts.Iteration)]);
legend('Training Accuracy', 'Validation Accuracy');

subplot(2,1,2);
xlim([0 max(ts.Iteration)]);
legend('Training Loss', 'Validation Loss');
