library(RSQLite)

BD_path="db/"

source("functions.r")

org="Bacillus_amyloliquefaciens"
res <- get_complexity("Bacillus_amyloliquefaciens")

svg("compare_species.svg", height = 7, width = 12, pointsize = 12)
plot(res$start, res$complexity, ylim = c(0,550), 
     type="n", pch=3, cex = 0.3, col="gray50", lwd = 1, xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)

plot_complexity(res, 450, 12, 1)

res2 <- get_complexity("Bacillus_velezensis")
scale.2 <- max(res$end)/max(res2$end)
plot_synteny_mauv("mauve_1.bcb", scale.2, 1, 300, 450)

plot_complexity(res2, 300, 8, scale.2)

res3 <- get_complexity("Bacillus_subtilis")
scale.3 <- max(res$end)/max(res3$end)
plot_synteny_mauv("mauve_2.bcb",scale.3,scale.2,150, 300)
plot_complexity(res3, 150, 12, scale.3)

res4 <- get_complexity("Bacillus_licheniformis")
scale.4 <- max(res$end)/max(res4$end)
plot_synteny_mauv("mauve_3.bcb",scale.4,scale.3,0, 150)
plot_complexity(res4, 0, 7, scale.4)

### phages

plot_phaster("phaster/summary_licheniformis.txt", scale.4, -5)
plot_phaster("phaster/summary_subtilis.txt", scale.3, 145)
plot_phaster("phaster/summary_velezensis.txt", scale.2, 295)
plot_phaster("phaster/summary_amyloliquefaciens.txt", 1, 445)


dev.off()

### Bacillus amyloliquefaciens
#Bacillus velezensis
#Bacillus subtilis
# Bacillus licheniformis