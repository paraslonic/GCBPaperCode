library("gplots")
library("data.table")
library("pheatmap")

#setwd("/data4/bio/operonTravel_d4/compare_with_3c_ver2/")

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
calc_and_plot <- function(fname, title){
  complex <- fread(fname, skip = 1)
  complex$complexity <- as.numeric(complex$complexity)
  complex$pos <- (complex$position/max(complex$position))*N
  complex$pos_int <- ceiling(complex$pos)
  complex <- aggregate(complex, by = list(complex$pos_int), FUN = mean)
  qucomplex <- rep(NA, N)
  qucomplex[complex$pos_int] <- complex$complexity
  
  r_range <- 1:30
  p_val <- rep(NA, length(r_range))
  for(r in r_range){
    rsum <- get_range_sum(as.matrix(mat), r)
    s <- summary(lm(qucomplex ~  rsum))
    p_val[r] <- s$coefficients[2,4]
  }
  
  ranges <- r_range*5 # each bin is 5 kbp
  plot(ranges, log10(p.adjust(p_val)),  pch = 19, frame = FALSE, ylab = "log(adjusted p-value)", 
       xlab = "window size, kilo base pairs", cex.lab = 1.5, xaxt="n", main = title)
  
  axis(side = 1, at = ranges[seq(1, length(ranges),2)])
  return(log10(p.adjust(p_val)))
}

pdf("plots.pdf")
p5 <- calc_and_plot("NC_000913.3_5.txt", "window = 5, E. coli")
p10 <- calc_and_plot("NC_000913.3_10.txt", "window = 10, E. coli")
p20 <- calc_and_plot("NC_000913.3.txt", "window = 20, E. coli")
p50 <- calc_and_plot("NC_000913.3_50.txt", "window = 50, E. coli")
p100 <- calc_and_plot("NC_000913.3_100.txt", "window = 100, E. coli")
calc_and_plot("NC_000913.3_custom_w21.txt", "window = 20, custom, E. coli")
calc_and_plot("NC_000913.3_20byst.txt", "window = 20, by strain complexity, E. coli")

dev.off()
