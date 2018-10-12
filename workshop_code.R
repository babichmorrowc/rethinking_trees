
####### The coalescent model lecture ###### 
#### Dr. Marcelo Gehara
#### 

###################################################################################
#############################################################################################
#### The Coalescent  ######

###load libraries
library(phyclust)
library(ape)
library(phytools)

#####                                                                         #####
##### Probability of coalescence of two alleles in pops with different sizes  ##### 
#####                                                                         #####

Ne.coal.prob <- function(Ne, ploidy)
{
  coal.pr<-NULL
  for(i in 1:length(Ne)){
    coal = 1/Ne[i]*1/Ne[i]*Ne[i]*ploidy
    coal.pr <- c(coal.pr, coal)  
    print(i)
  }
  coal.pr 
}

pop.sizes <- c(100:500)

prob<-Ne.coal.prob(Ne=pop.sizes, ploidy = 1)
plot(prob, xlab="population size",xaxt = "n") 
     axis(1, at=c(0,length(prob)), labels=c(min(pop.sizes),max(pop.sizes)))

########################################################
     
     ##### Simulation of coalescent trees #####
     ##### ms simulator (Hudson 2001) #####
     
     
     ###### transfomacao de variaveis
     Ne1 = 1000 ### population size
     Ne2 = 5000 ### population size
     µ = 0.00001 ### mutation rate
     theta1 = 2*Ne1*µ ### theta = 2Neµ (transformation to coalescent scale) 
     theta2 = 2*Ne2*µ
     
     ##### Simulation 
     sims1 <- ms(nsam=10, nreps=1000, opts=paste('-L -T -t',theta1))
     sims2 <- ms(nsam=10, nreps=1000, opts=paste('-L -T -t',theta2))
     #### read the coalescent trees
     trees1 <- read.tree(text = sims1)
     trees2 <- read.tree(text = sims2)
     for(i in 1:length(trees1))
       {
       trees1[[i]]$edge.length <- trees1[[i]]$edge.length*2*Ne1
       }
     
     for(i in 1:length(trees2))
     {
       trees2[[i]]$edge.length <- trees2[[i]]$edge.length*2*Ne2
     }
     
     ### tmrca of all genealogies
     tmrca1 <- sapply(trees1, function(x) max(nodeHeights(x))) # em geracoes
     tmrca2 <- sapply(trees2, function(x) max(nodeHeights(x))) # em geracoes
     
     ### mean time to the most recent common ancestor 
     mean(tmrca1)
     mean(tmrca2)
     
     boxplot(tmrca1,tmrca2) #### boxplot of distributions of tmrca
     
     #### plota 10 genetrees, 5 from each simulation
     par(mfrow = c(10, 1))
     
     x<-trees1[sample(1:length(trees1),5)]
     x<-c(x,trees2[sample(1:length(trees2),5)])
     
     h<-sapply(x, function(x) max(nodeHeights(x)))
     l<-h-max(h)
     for(i in 1:10){
          plotTree(x[[i]], xlim=c(l[i], h[i]))
     }
     dev.off()
     
     
#################################
     ### influence of the number of aleles in the probability of coalescence

al.coal.prob <- function(Ne, alleles, ploidy)
{
  coal.pr<-NULL
  for (i in 2:alleles)
  {
  comb = i*(i-1)
  coal = comb/(2*Ne*ploidy)
  coal.pr <- c(coal.pr, coal)
  }
 coal.pr 
}
coal.pr <- al.coal.prob(Ne=5000, alleles=20, ploidy=1)
coal.pr <- sort(coal.pr, decreasing=F)
plot(coal.pr, ylab="prob", xlab="alleles")

##### Expected Coalescent times #####
####### tmrca - time to the most recent common acestor ######

# average waiting time for a coalescence event based on the number of alleles #

###  2N/k(k-1)

### k is the number of different alleles 

coal.time <- function(Ne, hap, ploidy)
  {
    coal.time <- NULL
    y <- Ne/hap 
    for (i in 2:hap)
      {
      x <- (2*Ne*ploidy)/(i*(i-1))
      coal.time <- c(coal.time, x)
    }
coal.time
}  
wait.time <- coal.time(10000, 10, ploidy=1)
wait.time <- sort(wait.time, decreasing = F)
plot(wait.time, type="b", xaxt = "n") 
axis(1, at=c(1:length(wait.time)), labels=c((length(wait.time)+1):2))

## total waiting time
sum(wait.time)



###### simulations of 2 diverging populations

Ne = 500000 ### population size
µ = 0.00001 ### mutation rate
theta = 4*Ne*µ ### theta 
divergence.time=500000 ### generations
time = divergence.time/(4*Ne) ### calescent scaled divergence
mig = 0.0 # 4Nm

######### simulate data
sims = ms(nsam = 10, nreps = 1000, opts=paste('-T -t ',theta,' -I 2 5 5 ',mig,
                                              ' -n 2 0.1 -ej ',time,' 2 1', sep=""))
### read simulated trees
trees <- read.tree(text = sims)
names(trees) <- NULL

#### check if the tree is sorted for pop 1
x <- unlist(lapply(trees, is.monophyletic,paste("s",1:5, sep="")))

### check proportion of sorted trees
length(which(x==T))/1000


### plot trees
par(mfrow = c(5, 1))
for(i in 1:length(trees))
  {
    trees[[i]]$edge.length <- trees[[i]]$edge.length*4*Ne
  }

x<-trees[sample(1:length(trees),10)]
h<-sapply(x, function(x) max(nodeHeights(x)))
l<-h-max(h)
for(i in 1:5){
  plotTree(x[[i]], xlim=c(l[i], h[i]))
}
dev.off()

##### End ##################################################################################
############################################################################################


### dice simulation

N.dice= 6 #### dice with 6 numbers (1, 2, 3, 4, 5, 6)
dice.prob = 1/N.dice ### probability of getting a 3

dice<-function(sides, value, n.turns){
  
  tot.turns <- NULL
  for(i in 1:n.turns){
    x <- sample(c(1:sides),1)
    turn <- 1
    while(x!=value){
      x <- sample(c(1:sides),1)
      turn <- turn+1
    }
    tot.turns <- c(tot.turns,turn)
  }
  return(tot.turns)
}

res <- dice(sides=6, value = 3, n.turns = 1000)  
hist(res, breaks = 50)
mean(res)
