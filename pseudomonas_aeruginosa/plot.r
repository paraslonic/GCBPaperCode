library(RSQLite)


source("functions.r")

ref1="GCF_000504045.1_ASM50404v1_genomic"
ref2="GCF_000981825.1_ASM98182v1_genomic"

complexity_clade1 <- get_complexity("Results/complexity_clade1/gene_graph.db",ref1)
complexity_clade2 <- get_complexity("Results/complexity_clade2/gene_graph.db",ref2)

h1 <- 70
h2 <- 5


png("pseudomonas_aeruginosa.png", width = 250, height = 150, units = "mm", res = 300)
plot(c(1,7.5e6), c(5,80),type="n",xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)

k = max(complexity_clade2$end)/max(complexity_clade1$end)
plot_complexity(complexity_clade2,h2,1,1)
plot_complexity(complexity_clade1,h1,1,k)

plot_synteny_mauv("mauve/mauve_1_2.backbone",1,k,h2,h1)

add = 5
.cex = 1.2
#text(7.8e6, h1+add, "clade1", cex = .cex)
#text(7.8e6, h2+add, "clade2", cex = .cex)

plot_phaster("phaster/NC_023019.txt",k,h1)
plot_phaster("phaster/NZ_CP011317.txt",1,h2)

dev.off()