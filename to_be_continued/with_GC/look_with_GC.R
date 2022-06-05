
library(RSQLite)
complexity= read.delim("NC_011993.1.txt", skip = 1)
plot(complexity$position, complexity$complexity, type = "l")

#install.packages("seqinr")
library(seqinr)
genome = read.fasta("50.fasta")

calc_gc <- function(string){
  gc = sum(grepl("g|c", string))/length(string)
  return(gc)
}

W = 10000


positions = seq(1, length(genome$NC_011993.1) - W, W)
GC = rep(NA, length(positions))

for(p in 1:length(positions)){
  GC[p] = calc_gc(genome$NC_011993.1[positions[p]:(positions[p]+W)])
}


plot(complexity$position, complexity$complexity, type="l", ylim = c(0,40), axes = F, lwd = 2)

lines(positions, GC*80-10, type = "l")


