# Quantifying Financial Bubbles using Option Data
- Carl Adrian Møller
- Victor Nørgaard Nielsen

This repository contains  
1. Optiondataprep.ipynb - Used to fetch data from the OptionMetrics database through Wharton Research Database and prepare the data for estimation. Note that this will require a WRDS login - we are not allowed to share the data.
2. Bub_inference.ipynb -  Implementation of the bubble inference procedure of Jarrow and Kwok (2021)
3. Trading.ipynb - Back-testing trading strategies
4. Descriptive.ipynb - Creating additional figures used in the thesis
5. WhiteRealityCheck2021.m - Implementation of White (2000) Reality Check test in Matlab 
6. Sharpe_performance_test.R - Implementation of Sharpe Performance test based on SharpeR package from Ledoit and Wolf (2008)


References:
Jarrow, R.A., Kwok, S.S., 2021. Inferring financial bubbles from option data. Journal of Applied Econometrics 36, 1013–1046.
Online appendix: http://qed.econ.queensu.ca/jae/datasets/jarrow001/

Ledoit, O., Wolf, M., 2008. Robust performance hypothesis testing with the sharpe ratio. Journal of Empirical Finance 15, 850–859.
Online appendix: http://www.ledoit.net/jef2008_abstract.htm

White, H., 2000. A reality check for data snooping. Econometrica 68, 1097–1126.
