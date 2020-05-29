%% Machine Learning Online Class - Exercise 2: Logistic Regression
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the logistic
%  regression exercise. You will need to complete the following functions 
%  in this exericse:
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Load Training Data
fid = fopen ("ngTrain.csv", "r");
cell = textscan(fid,'%f%s%s%f%s%f%f%s%f%f%f%s%f%f%f%s%f%s%f%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f',"Delimiter",",","HeaderLines",1);
fclose(fid);

%% Load Test Data
fid = fopen ("ngTesting.csv", "r");
tcell = textscan(fid,'%f%s%f%s%f%f%s%f%f%f%s%f%f%f%s%f%s%f%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f',"Delimiter",",","HeaderLines",1);
fclose(fid);

%% Load Results Data
fid = fopen ("ngResults.csv", "r");
rcell = textscan(fid,'%f%s',"Delimiter",",","HeaderLines",1);
fclose(fid);

% extract to matrices; convert cells of strings to matrices

%Col 1: Age
col1=cell{1};
tcol1=tcell{1};

%Col 2: Attrition (doesn't exist in test data)
function a = attrition(x)
  if strcmp("Yes", x)
    a=1;
  else
    a=0;
  end
endfunction
col2=cellfun(@attrition, cell{2});
%test data doesn't have this column

%Col 3: BusinessTravel; Combining Travel_Rarely + Non-Travel increased accuracy
function a = businessTravel(x)
  switch(x)
    case "Travel_Rarely"
      a=1;
    case "Travel_Frequently"
      a=2;
    case "Non-Travel"
      a=1;      
  endswitch
endfunction
col3=cellfun(@businessTravel, cell{3});
tcol2=cellfun(@businessTravel, tcell{2});

%Col 4: DailyRate
col4=cell{4};
tcol3=tcell{3};


%Col 5: Department; Combining Sales + Human Resources increased accuracy
function a = Department(x)
  switch(x)
    case "Research & Development"
      a=1;
    case "Sales"
      a=2;
    case "Human Resources"
      a=2;      
  endswitch
endfunction
col5=cellfun(@Department, cell{5});
tcol4=cellfun(@Department, tcell{4});

%Col 6: DistanceFromHome
col6=cell{6};
tcol5=tcell{5};

%Col 7: Education
col7=cell{7};
tcol6=tcell{6};

%Col 8: EducationField; Combining Technical Degree + Human Resources increased accuracy
function a = EducationField(x)
  switch(x)
    case "Life Sciences"
      a=1;
    case "Other"
      a=2;
    case "Medical"
      a=3;      
    case "Marketing"
      a=4;      
    case "Technical Degree"
      a=5;        
    case "Human Resources"
      a=5;
  endswitch
endfunction
col8=cellfun(@EducationField, cell{8});
tcol7=cellfun(@EducationField, tcell{7});

%Col 9: EmployeeCount
col9=cell{9};
tcol8=tcell{8};

%Col 10: EmployeeNumber
col10=cell{10};
tcol9=tcell{9};

%Col 11: EnvironmentSatisfaction
col11=cell{11};
tcol10=tcell{10};

%Col 12: Gender
function a = Gender(x)
  switch(x)
    case "Male"
      a=1;
    case "Female"
      a=2;     
  endswitch
endfunction
col12=cellfun(@Gender, cell{12});
tcol11=cellfun(@Gender, tcell{11});

%Col 13: HourlyRate
col13=cell{13};
tcol12=tcell{12};

%Col 14: JobInvolvement
col14=cell{14};
tcol13=tcell{13};

%Col 15: JobLevel
col15=cell{15};
tcol14=tcell{14};

%Col 16: JobRole; Combining Research Scientist + Human Resources, Laboratory Technician by itself, and the rest combined increased accuracy
function a = JobRole(x)
  switch(x)
    case "Research Scientist"
      a=1;
    case "Sales Representative"
      a=2;
    case "Sales Executive"
      a=2;      
    case "Laboratory Technician"
      a=3;      
    case "Healthcare Representative"
      a=2;        
    case "Research Director"
      a=2;
    case "Manufacturing Director"
      a=2;   
    case "Manager"
      a=2;    
    case "Human Resources"
      a=1;  
  endswitch
endfunction
col16=cellfun(@JobRole, cell{16});
tcol15=cellfun(@JobRole, tcell{15});

%Col 17: JobSatisfaction
col17=cell{17};
tcol16=tcell{16};

%Col 18: MaritalStatus
function a = MaritalStatus(x)
  switch(x)
    case "Married"
      a=1;
    case "Single"
      a=2;   
    case "Divorced"
      a=3;   
  endswitch
endfunction
col18=cellfun(@MaritalStatus, cell{18});
tcol17=cellfun(@MaritalStatus, tcell{17});

%Col 19: MonthlyIncome
col19=cell{19};
tcol18=tcell{18};

%Col 20: MonthlyRate
col20=cell{20};
tcol19=tcell{19};

%Col 21: NumCompaniesWorked
col21=cell{21};
tcol20=tcell{20};

%Col 22: Over18
function a = Over18(x)
  switch(x)
    case "Y"
      a=1;  
  endswitch
endfunction
col22=cellfun(@Over18, cell{22});
tcol21=cellfun(@Over18, tcell{21});

%Col 23: OverTime
function a = OverTime(x)
  switch(x)
    case "Yes"
      a=1;  
    case "No"
      a=2;  
  endswitch
endfunction
col23=cellfun(@OverTime, cell{23});
tcol22=cellfun(@OverTime, tcell{22});

%Col 24: PercentSalaryHike
col24=cell{24};
tcol23=tcell{23};

%Col 25: PerformanceRating
col25=cell{25};
tcol24=tcell{24};

%Col 26: RelationshipSatisfaction
col26=cell{26};
tcol25=tcell{25};

%Col 27: StandardHours
col27=cell{27};
tcol26=tcell{26};

%Col 28: StockOptionLevel
col28=cell{28};
tcol27=tcell{27};

%Col 29: TotalWorkingYears
col29=cell{29};
tcol28=tcell{28};

%Col 30: TrainingTimesLastYear
col30=cell{30};
tcol29=tcell{29};

%Col 31: WorkLifeBalance
col31=cell{31};
tcol30=tcell{30};

%Col 32: YearsAtCompany
col32=cell{32};
tcol31=tcell{31};

%Col 33: YearsInCurrentRole
col33=cell{33};
tcol32=tcell{32};

%Col 34: YearsSinceLastPromotion
col34=cell{34};
tcol33=tcell{33};

%Col 35: YearsWithCurrManager
col35=cell{35};
tcol34=tcell{34};

%combine all relevant features into training matrix X
%skipping columns: 2, 9, 22
Xorig = [col1 col3 col4 col5 col6 col7 col8 col10 col11 col12 col13 col14 col15 col16 col17 col18 col19 col20 col21 col23 col24 col25 col26 col27 col28 col29 col30 col31 col32 col33 col34 col35];

%combine all relevant features into testing matrix T
%skipping columns: 9, 22
T = [tcol1 tcol2 tcol3 tcol4 tcol5 tcol6 tcol7 tcol8 tcol10 tcol11 tcol12 tcol13 tcol14 tcol15 tcol16 tcol17 tcol18 tcol19 tcol20 tcol21 tcol23 tcol24 tcol25 tcol26 tcol27 tcol28 tcol29 tcol30 tcol31 tcol32 tcol33 tcol34];

%get results into y
y = col2; %2nd column

%% ==================== Part 1: Plotting ====================
%  We start the exercise by first plotting the training data to understand the 
%  the problem we are working with.
         
%plot(col1, y, 'rx', 'MarkerSize', 10); % Plot the data 
%ylabel('attrition'); % Set the y−axis label 
%xlabel('age'); % Set the x−axis label

%plot(col3, y, 'rx', 'MarkerSize', 10); % Plot the data 
%ylabel('attrition'); % Set the y−axis label 
%xlabel('BusinessTravel'); % Set the x−axis label

%plot(col6, y, 'rx', 'MarkerSize', 10); % Plot the data 
%ylabel('attrition'); % Set the y−axis label 
%xlabel('DistanceFromHome'); % Set the x−axis label

%bar(col17, y, 'rx', 'MarkerSize', 10); % Plot the data 
%ylabel('attrition'); % Set the y−axis label 
%xlabel('JobSatisfaction'); % Set the x−axis label

%plotData(X1, y);

% Put some labels 
%hold on;
% Labels and Legend
%xlabel('Exam 1 score')
%ylabel('Exam 2 score')

% Specified in plot order
%legend('Gone', 'Not Gone')
%hold off;

%fprintf('\nProgram paused. Press enter to continue.\n');
%pause;

%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m

X=Xorig;

%iterate thru each column/feature
%for i = 1:size(X,2)
%remove column i
%X(:,[i]) = [];

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);

% Add intercept term to x
X = [ones(m, 1) X];
% Add intercept term to T
tsize = size(T);
T = [ones(tsize, 1) T];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display initial cost and gradient
%[cost, grad] = costFunction(initial_theta, X, y);

%fprintf('Cost at initial theta (zeros): %f\n', cost);
%fprintf('Expected cost (approx): 0.693\n');
%fprintf('Gradient at initial theta (zeros): \n');
%fprintf(' %f \n', grad);

%% ============= Part 3: Optimizing using fminunc  =============
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Set regularization parameter lambda (0, 1, 10, 100)
%lambda = 0.1;

%[theta, J, exit_flag] = ...
%	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

%try fmincg
%[theta] = ...
%   fmincg (@(t)(costFunctionReg(t, X, y, lambda)), ...
%           initial_theta, options);
                 
% Print theta to screen
%fprintf('Cost at theta found by fminunc: %f\n', cost);
%fprintf('Expected cost (approx): 0.203\n');
%fprintf('theta: \n');
%fprintf(' %f \n', theta);

%% ============== Part 4: Predict and Accuracies ==============
%  After learning the parameters, you'll like to use it to predict the outcomes
%  on unseen data. In this part, you will use the logistic regression model
%  to predict the probability that a student with score 45 on exam 1 and 
%  score 85 on exam 2 will be admitted.
%
%  Furthermore, you will compute the training and test set accuracies of 
%  our model.
%
%  Your task is to complete the code in predict.m

%  Predict probability for a student with score 45 on exam 1 
%  and score 85 on exam 2 

prob = sigmoid(T * theta);
s=size(prob, 1);

%extract results columns from rcell
r1=rcell{1};
r2=rcell{2};

for i = 1:s
  %fprintf(['Attrition probability of row %u: %f\n'], i, prob(i));
  if (prob(i) >= 0.5000);
    r2(i,1)="Yes";
  else
    r2(i,1)="No";
  endif
end 

%put results back into rcell
%rcell{2}=r;

%% Write Results Data to CSV file
fid = fopen ("ngResults2.csv", "w");
for i = 1:size(r1,1)
  fprintf(fid, "%u,%s\n", r1(i), [r2(i){:}]);
end
fclose(fid);

% Compute accuracy on our training set
p = predict(theta, X);

accuracy=mean(double(p == y)) * 100;
fprintf('Accuracy: %f\n', accuracy);
%accuracy(i)=mean(double(p == y)) * 100;
%fprintf('Accuracy leaving out column %u: %f\n', i, accuracy(i));
%end