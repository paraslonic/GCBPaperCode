library("data.table")

#setwd("/data4/bio/operonTravel_d4/compare_with_3c_ver2/")
setwd("E:/Slon/disser/code/FigureHiC")
mat <- fread("E_coli_analysis/data/matrices_5kb/MAT_WT_MM_30C_rep1_normalised.txt")
N <- ncol(mat)

get_range_sum_value <- function(m, i, .range){
  .sum <- 0; k <- 1
  for(k in 1:.range) {
    if(i+k<=nrow(m)){
      .sum <- .sum+m[i, i+k]
    }
    else{
      .sum <- .sum+m[i,i+k-nrow(m)]
    }
  }
  return(.sum)
}

get_range_sum <- function(m, .range){
  N. <- ncol(m)
  rsum <- rep(NA, N.)
  for(i in 1:N.){
    rsum[i] <- get_range_sum_value(m, i, .range)
  }
  return(rsum)
}

# main --------------------------------------------------------------------
  fname="NC_000913.3.txt"
  complex <- fread(fname, skip = 1)
  complex$complexity <- as.numeric(complex$complexity)
  complex$pos <- (complex$position/max(complex$position))*N
  complex$pos_int <- ceiling(complex$pos)
  complex <- aggregate(complex, by = list(complex$pos_int), FUN = mean)
  qucomplex <- rep(NA, N)
  qucomplex[complex$pos_int] <- complex$complexity
    rsum <- get_range_sum(as.matrix(mat), 4)
    s <- summary(lm(qucomplex ~  rsum))
    s
  cor.test(qucomplex, rsum, method="s")
  plot(sqrt(0.1+qucomplex)*3, type="l", ylim = c(-20,20), axes = F, lwd = 2)
  
  
  
  axis(1, at = c(rep(0,4600000,500000))*max(complex$pos_int)/max(complex$position))
  axis(4, at=c(0,20), las = 2)
  axis(2, at=c(0,-10, -20), labels = c(0, 0.1, 20/100),las=2)
  abline(h=seq(0,-20,-0.5), col="gray80")
  abline(v=seq(0,length(qucomplex),10), col="gray80")
  lines(-rsum*100, col="dodgerblue4", lwd = 2)
  
  
  
  ranges <- r_range*5 # each bin is 5 kbp
  plot(ranges, log10(p.adjust(p_val)),  pch = 19, frame = FALSE, ylab = "log(adjusted p-value)", 
       xlab = "window size, kilo base pairs", cex.lab = 1.5, xaxt="n", main = title)
  
  axis(side = 1, at = ranges[seq(1, length(ranges),2)])

  
### is it best or not?
  d <- data.frame(complexity = qucomplex, density = rsum)
  d$density2 = d$density[nrow(d):1]
  summary(lm(complexity ~ density2, d))
  
  p <- rep(NA, nrow(d))
  ccor <- rep(NA, nrow(d))
  for(i in 1:nrow(d)){
    d$density2[1:(nrow(d)-i+1)] = d$density[i:nrow(d)]
    d$density2[(nrow(d)-i+1):(nrow(d))] = d$density[1:i]
    
    s = summary(lm(complexity ~ density2, d))
    s = cor.test(d$complexity, d$density2, method = "spearman")
    p[i] = s$p.value
    ccor[i] = s$estimate
  }
  
  plot(log10(p), type="l", lwd = 2)
  plot(ccor, type="l", lwd = 2, ylab= "correlation (Spearman)", cex.lab = 1.8, xlab = "offset")
  