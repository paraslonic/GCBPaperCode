#setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/saturation/ecoli/") 

calc_cor <- function(file1, file2){
  c1 <- read.delim(file1, head = T)
  c2 <- read.delim(file2, head = T)
  return(cor(c1$complexity, c2$complexity, method = "pe"))
}

ref <-  "complexity/subset_100_1/prob_window_complexity_contig_NC_000913.3.txt"
cor_list <- list()
cor_mat <- matrix(NA, 20, 10)
p = 1
for(n in c(5,seq(10,100, 5))){
  for(i in seq(1,10)){
    file = sprintf("complexity/subset_%d_%d/prob_window_complexity_contig_NC_000913.3.txt", n, i)
    cor_mat[p,i] <- calc_cor(ref, file)  
  }
  p = p+1
}

png("saturation_coli.png", ,width = 150, height = 150, units = "mm", res = 300)

plot(seq(5,100,5),cor_mat[,1], type = "n", ylim = c(0,1), bty="none", ylab="pearson correlation", 
     xaxt="n", xlab="number of genomes", cex.lab = 1.55, cex.axis = 1.2, xlim = c(0,100))
for(i in seq(1,ncol(cor_mat))){
  points(seq(5,100,5),cor_mat[,i], pch=19, col = "gray60", cex = 0.8)
}
axis(side=1, lwd = 1, col = "black", cex.axis=1.2, at = c(0,seq(10,100,10)))
abline(h=1, lty=2)
lines(seq(5,100,5),rowMeans(cor_mat), lty=1, lwd = 2,col = "blue")
legend("bottom","mean correlation",lwd = 2, col = "blue", bty="n", cex = 1)

dev.off()