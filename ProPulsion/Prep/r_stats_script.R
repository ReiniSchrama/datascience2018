###########################################################
###################### Set Directory ######################??

getwd()
setwd('/Users/reinischrama/Desktop/Private/ProPulsion/Prep')

# Q1 Probability of 4 or less correct answers
pbinom(4, size=12, prob=0.2)
#0.9274445
#93%


# Q2 Probability of chekout completed in less than 2 minutes
pexp(2, rate=1/3) 
# 0.4865829
# 49%


# Q3 Find 2.5th and 97.5th percintile
quantile(0.025, 5)
quantile(0.975, 5)

# Q4 Test H0 that mean of lifetime lightbub is more than 10.000h
sample = 9900
h = 10000
sd = 120
n = 30
t = (sample-h)/(sd/sqrt(n))
# t = -4.564355
alpha = 0.05
t.alpha = qnorm(1-alpha)
# -t.alpha = -1.644854
# -4.564355 < -1.644854, so H0 is rejected

# Q5 Test H0 that this year proportion of voters in population is more than 60%
sample = 85/148
h = 0.60
n = 148
t = (sample???h)/sqrt(h???(1???h)/n)
#t = ???0.6376
alpha = 0.05
t.alpha = qnorm(1-alpha)
# -t.alpha = ???1.6449
# ???0.6376 > ???1.6449, so H0 is not rejected

# Q6 Find 95% confidence interval estimate of difference in mean 1931 and 1932
library(MASS)
immer <- as.data.frame(immer)
t.test(immer$Y1, immer$Y2, paired=TRUE)
# 95% confidence interval estimate of difference in mean 1931 and 1932 is between 6.121954 and 25.704713

# Q7 Find 95% confidence interval estimate of difference in mean mpg and am
mtcars <- as.data.frame(mtcars)
mpg.at <- subset(mtcars,mtcars$am == 0)
mpg.mt <- subset(mtcars,mtcars$am == 1)
t.test(mpg.at$mpg, mpg.mt$mpg) 
# 95% confidence interval estimate of difference in mean mpg and am is between -11.280194 and -3.209684

# Q8 Test if means 1931 and 1932 have identical data distributions
wilcox.test(immer$Y1, immer$Y2, paired=TRUE)
# p-value = 0.005318
# 1931 and 1932 are non-identical at 0.05 signifance level