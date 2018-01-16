###########################################################
###################### Set Directory ######################??

getwd()
setwd('/Users/reinischrama/Desktop/Private/ProPulsion/Challenge')

###########################################################
######################## Load Data ########################??

runner = read.csv("runner_attributes.csv")
marathon = read.csv("marathon_times.csv")

###########################################################
####################### Merge Data ########################??

run.mar.data <- merge(runner, marathon,by="unique_id")
run.mar.data
summary(run.mar.data)

###########################################################
###################### Inspect Data #######################

summary(run.mar.data)
summary(run.mar.data$netTime)
summary(run.mar.data$nationality)
summary(run.mar.data$ageClass)

run.mar.data$netTime[run.mar.data$netTime<0] <- NA
run.mar.data$ageClass[run.mar.data$ageClass=="U20"] <- NA

run.mar.data$minutes <- run.mar.data$netTime/60
run.mar.data$hours <- run.mar.data$minutes/60

sub.treatment.time <- subset(run.mar.data, select = c("treatment", "minutes"))
summary(sub.treatment.time)

###########################################################
###################### Analyse Data #######################

# plot time and treatment
plot(sub.treatment.time)

###################### Simple Model #######################

# treatment as categorical variable
str(run.mar.data$treatment)
run.mar.data$treatment <- factor(run.mar.data$treatment)

# model treatment and runners net time
model.1 <- lm(minutes ~ treatment,
                 data=run.mar.data)

# results
coef(summary(model.1)) 
anova(model.1) 

################## Model with controls ###################

# model treatment, time and controls
model.2 <- lm(minutes ~ treatment + ageClass 
                    + sex + nationality,
                     data=run.mar.data)

# results
coef(summary(model.2)) 
anova(model.2) 

################### Interaction Model ####################

# model treatment*sex, time and controls
model.3 <- lm(minutes ~ treatment*sex + ageClass 
                       + nationality,
                      data=run.mar.data)

# results
coef(summary(model.3)) 
anova(model.3) 

################# Plot Interaction Model ##################

#install.packages("effects")
#library("effects")


# Interaction effet
interaction <- effect('treatment*sex', model.3,
                      se=TRUE)
# Data Frame
interaction.df<-as.data.frame(interaction)

# Labels
interaction.df$treatment.f <- factor(interaction.df$treatment,  
                                     level=c("Control", "Treatment"),    
                                     labels=c("Control", "RunPro3000"))   
interaction.df$Gender <- factor(interaction.df$sex,
                                level=c("M", "W"),   
                                labels=c("Men", "Women"))

# Interaction Plot
plot.interaction<-ggplot(data=interaction.df, aes(x=treatment.f, y=fit, group=Gender))+
  geom_line(size=2, aes(color=Gender))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=Gender),alpha=.2)+
  scale_y_reverse("Performance (running time in minutes)") +  
  scale_x_discrete("Treatment") +  
  ggtitle("The effect of RunPro3000 for men and women")+
  theme_linedraw() 
plot.interaction

# The bad news...
# Zoom in plot for Women
plot.interaction<-ggplot(data=interaction.df, aes(x=treatment.f, y=fit, group=Gender))+
  geom_line(size=2, aes(color=Gender))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=Gender),alpha=.2)+
  scale_y_reverse("Performance (running time in minutes)") + 
  scale_x_discrete("Treatment") +  
  ggtitle("The effect of RunPro3000 for women")+
  theme_linedraw() +
  theme(legend.position="none") +
  coord_cartesian(ylim=c(292,272))
plot.interaction

# The good news...
# Zoom in plot for Men
plot.interaction<-ggplot(data=interaction.df, aes(x=treatment.f, y=fit, group=Gender))+
  geom_line(size=2, aes(color=Gender))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=Gender),alpha=.2)+
  scale_y_reverse("Performance (running time in minutes)") + 
  scale_x_discrete("Treatment") +  
  ggtitle("The effect of RunPro3000 for men")+
  theme_linedraw() +
  theme(legend.position="none") +
  coord_cartesian(ylim=c(247,242))
plot.interaction

########## Predicting effect of all attributes ###########

######################### Age ############################

# model treatment*age, time and controls
model.4 <- lm(minutes ~ treatment*ageClass + sex 
              + nationality,
              data=run.mar.data)

# results
coef(summary(model.4)) 
anova(model.4) 

# Interaction effet
interaction_age <- effect('treatment*ageClass', model.4,
                      se=TRUE)
# Data Frame
interaction_age.df<-as.data.frame(interaction_age)

# Labels
interaction_age.df$treatment.f <- factor(interaction_age.df$treatment,  
                                     level=c("Control", "Treatment"),    
                                     labels=c("Control", "RunPro3000"))   

# Interaction Plot
plot.interaction_age<-ggplot(data=interaction_age.df, aes(x=treatment.f, y=fit, group=ageClass))+
  geom_line(size=2, aes(color=ageClass))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=ageClass),alpha=.2)+
  scale_y_reverse("Performance (running time in minutes)") +  
  scale_x_discrete("Treatment") +  
  ggtitle("The effect of RunPro3000 for different ages")+
  theme_linedraw() 
plot.interaction_age

##################### Nationality ##########################

interaction_nat_new.df <- na.omit(interaction_nat.df)

# model treatment*nationality, time and controls
model.5 <- lm(minutes ~ treatment*nationality + sex 
              + ageClass,
              data=run.mar.data)

# results
coef(summary(model.5)) 
anova(model.5) 

# Interaction effet
interaction_nat <- effect('treatment*nationality', model.5,
                          se=TRUE)
# Data Frame
interaction_nat.df<-as.data.frame(interaction_nat)

interaction_nat_new.df <- na.omit(interaction_nat.df)

# Labels
interaction_nat_new.df$treatment.f <- factor(interaction_nat_new.df$treatment,  
                                         level=c("Control", "Treatment"),    
                                         labels=c("Control", "RunPro3000"))   

# Interaction Plot
plot.interaction_nat<-ggplot(data=interaction_nat_new.df, aes(x=treatment.f, y=fit, group=nationality))+
  geom_line(size=2, aes(color=nationality))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=nationality),alpha=.2)+
  scale_y_reverse("Performance (running time in minutes)") +  
  scale_x_discrete("Treatment") +  
  ggtitle("The effect of RunPro3000 for different nationalities")+
  theme_linedraw() 
plot.interaction_nat

