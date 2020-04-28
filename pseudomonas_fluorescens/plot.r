library(RSQLite)

#setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/pseudomonas_fluorescens")
source("functions.r")

complexity_clade1 <- get_complexity("Results/complexity_clade1/gene_graph.db","GCF_000009225")
complexity_clade2 <- get_complexity("Results/complexity_clade2/gene_graph.db","GCF_000012445")


h1 <- 10
h2 <- 50

png("compare_clades.png", height = 7, width = 12, pointsize = 12)
plot(c(1,7e6), c(5,60),type="n",xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)
plot_complexity(complexity_clade1,h1,1.2,1)
plot_complexity(complexity_clade2,h2,1.2,1)
#plot_synteny("Results/nucmer.coords",1,1,0,80)
plot_synteny_mauv("reference_mauve_alignment.backbone",1,1,h2,h1)

plot_phaster("phaster/GCF_000009225.txt",1,h1)
plot_phaster("phaster/GCF_000012445.txt",1,h2)

dev.off()
