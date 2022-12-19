puremomentum = R2015{:, 1};
buyhold = R2015{:, 7};
strats_low = R2015{:,8:19};
strats_med = R2015{:,20:31};
strats_high = R2015{:,32:43};
strats_all = R2015{:,44:55};
strats_pm = R2015{:,1:4};


blockpar = 63;

blockpars = [63, 126, 189, 252];

result = zeros(4,5);

for i = 1:length(blockpars)
    disp(blockpars(i))

    [pv_low Vlstar Vl] = WhiteRealityCheck(strats_low, 2, buyhold , 1000 , 0, blockpars(i));
    [pv_med Vlstar Vl] = WhiteRealityCheck(strats_med, 2, buyhold , 1000 , 0, blockpars(i));
    [pv_high Vlstar Vl] = WhiteRealityCheck(strats_high, 2, buyhold , 1000 , 0, blockpars(i));
    [pv_all Vlstar Vl] = WhiteRealityCheck(strats_all, 2, buyhold , 1000 , 0, blockpars(i));
    [pv_mom Vlstar Vl] = WhiteRealityCheck(strats_pm, 2, buyhold , 1000 , 0, blockpars(i));
    
    result(i, 1) = pv_low;
    result(i, 2) = pv_med;
    result(i, 3) = pv_high;
    result(i, 4) = pv_all;
    result(i, 5) = pv_mom;
end



%%% 2021

puremomentum_21 = R2021{:, 1};
buyhold_21 = R2021{:, 7};
strats_low_21 = R2021{:,8:19};
strats_med_21 = R2021{:,20:31};
strats_high_21 = R2021{:,32:43};
strats_all_21 = R2021{:,44:55};
strats_pm_21 = R2021{:,1:4};

result_2021 = zeros(4,5);

for i = 1:length(blockpars)
    disp(blockpars(i))

    [pv_low Vlstar Vl] = WhiteRealityCheck(strats_low_21, 2, buyhold_21 , 1000 , 0, blockpars(i));
    [pv_med Vlstar Vl] = WhiteRealityCheck(strats_med_21, 2, buyhold_21 , 1000 , 0, blockpars(i));
    [pv_high Vlstar Vl] = WhiteRealityCheck(strats_high_21, 2, buyhold_21 , 1000 , 0, blockpars(i));
    [pv_all Vlstar Vl] = WhiteRealityCheck(strats_all_21, 2, buyhold_21 , 1000 , 0, blockpars(i));
    [pv_mom Vlstar Vl] = WhiteRealityCheck(strats_pm_21, 2, buyhold_21 , 1000 , 0, blockpars(i));
    
    result_2021(i, 1) = pv_low;
    result_2021(i, 2) = pv_med;
    result_2021(i, 3) = pv_high;
    result_2021(i, 4) = pv_all;
    result_2021(i, 5) = pv_mom;
end



r21_rounded = round(result_2021,3);
r_rounded = round(result,3);

%[pv_low Vlstar Vl] = WhiteRealityCheck(strats_low, 2, buyhold , 1000 , 0, blockpar);
%[pv_med Vlstar Vl] = WhiteRealityCheck(strats_med, 2, buyhold , 1000 , 0, blockpar);
%[pv_high Vlstar Vl] = WhiteRealityCheck(strats_high, 2, buyhold , 1000 , 0, blockpar);
%[pv_all Vlstar Vl] = WhiteRealityCheck(strats_all, 2, buyhold , 1000 , 0, blockpar);

%[pvalue_2 Vlstar_2 Vl_2] = WhiteRealityCheck(buyhold, 2, puremomentum, 1000 , 1);



function [pvalue Vlstar Vl] = WhiteRealityCheck( alternative , flag, benchmark , n , display, input)


%% This file contains the White reality check for data snooping
%  -   This can be used to test whether atleast one of the created models
%  outperforms a benchmark model  
%  - This can also be used to test whether you have found atleast one profitable
%  trading strategy, or test whether you have found atleast one trading
%  strategy that outperforms the benchmark.


%  The H0 hypothesis is always  that you have not found an outperforming
%  strategy or model

% input:
% 'Alternative' is a matrix with  Returns ==> [-1 , +Inf ]
%  or residuals of predictions with a model ==> [ -Inf ; +Inf]
% Important, the rows stand for new observation the columns for the models
%  'Flag'  indicates which loss function you want to use
%  Flag = 1 test for model superiority vs benchmark by mean squared error
%  Flag = 2 test for trading return superiorty vs benchmark 
%  Flag = 3 test for model superiority vs benchmark by absolute error
% 'Benchmark' contains a vector with - (1) The residuals from the predictions
% of the benchmark model , (2) The returns of your benchmark trading
% strategy, (3) Special case where Benchmark is the single number 0 where
% your benchmark is zero.
%  'n' is the number of bootstrapped series you want to create aka the
%  number of simulations. In academic papers this is usually  set 
%  to atleast 500 for reasonable results
% 'display' is a number [ 0, 1] if 0 then display is set off if 1 then
% display is on

% Examples of possibles testing can be found in help.txt file 



[r,~]=size(alternative);
[r,c]=size(alternative);


%  condition whether you have a benchmark or you want to test vs 0
%if benchmark ~=0|| numel(benchmark)>1
%    mat = repmat(benchmark,1,c);
%else
%    mat = benchmark; % mat = 0 benchmark is zero
%end

% manual - adrian
%mat = repmat(benchmark,1,c);

mat = benchmark;



% %  loss functions 
if flag ==1   
     f = - alternative.^2 + mat.^2;
elseif flag==2
    f = log(1+alternative)-log(1+mat);
elseif flag ==3
    f = - abs (alternative) + abs(mat);
end


%  input for average block size for P&R bootstrap (geometric distribution)
%input = inputdlg('What do you want as average block size for the Politis Romano stationary bootstrap?');
%blockparam = 1/(str2num(input{1})+1);
blockparam = 1/(input+1);


% Actual Politis Romano bootstrap as described in Politis& Romano (1994)
fstarroof =  PolitisRomanoBootstrap( alternative , n , blockparam,display,flag,mat);


froof = mean(f,1);
Vl = max(sqrt(r)*froof);

delta = fstarroof - repmat(froof,n,1);
Vlstar = max(sqrt(r)*delta,[],2);


Vlstar = sort(Vlstar);

% 'Vl' and 'Vlstar' are the same as in the paper of 
% Sullivan, Timmermann and White (1999) or White(2000)

better = Vlstar>Vl;

pvalue = sum(better)/n;


% compare Vl and Vlstar to get the p-value
end




function BtstrpMat = PolitisRomanoBootstrap( alternative , n , blockparam, display,flag,mat)

% It is exactly coded as in the paper:
% "The Stationary bootstrap" by Dimitris N. Politis and Joseph P. Romano
% The exact description can be found on page 4 in this paper
% link existed at the date of creation  ==> 
% http://www.stat.purdue.edu/research/technical_reports/pdfs/1991/tr91-03.pdf

% Note you could easily replace the if loop with geornd too speed things
% up, but it is done this way for educational sake and to folow the exact
% description of the paper !


[r c] =size(alternative);
BtstrpMat = zeros(n,c)/0;

for i=1:n
    if display ==1
        disp(['simulations done : ' num2str(i)])
    end
    
    New= zeros(r,c)/0;
    tel=0;
    while tel < r
        tel = tel + 1;
        p = rand;
        if p < blockparam || tel == 1
            row=randi(r);
            Xnext = alternative(row,:);
        else
            row = row + 1;
            if row > r
                row = row - r;
            end
            
            Xnext = alternative(row,:);
        end
        New(tel,:)=Xnext;
    end

    
    if flag ==1
        f = - New.^2 + mat.^2;
    elseif flag==2
        f = log(1+New)-log(1+mat);
    elseif flag ==3
        f = - abs (New) + abs(mat);
    end
    
    
    froof = mean(f,1);
    BtstrpMat(i,:)=froof;
    
end
end








    
    
     



