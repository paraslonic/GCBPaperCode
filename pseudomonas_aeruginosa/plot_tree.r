setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/pseudomonas_aeruginosa")
library("ape")
library("phangorn")
library("phylobase")
tree <- read.tree("parsnp_tree_2/parsnp.tree")
plot(tree, cex = 0.2, type="f")

plot(midpoint(tree), cex = 0.2)
tree <- midpoint(tree)
tree <- drop.tip(tree, grep("GCF_00001720|003025345|002968755|00307369|00697178|01227667|003193645", tree$tip.label,value = TRUE))
grep("90024335", tree$tip.label,value = TRUE)



clade1.mrca = MRCA(tree,c("GCF_002237405.1_ASM223740v1_genomic.fna", "GCF_001721845.1_ASM172184v1_genomic.fna"))
clade2.mrca = MRCA(tree, c("GCF_001870265.1_ASM187026v1_genomic.fna", "GCF_900243355.1_RW109_genomic.fna"))

clade1 <- (extract.clade(tree,clade1.mrca))$tip
clade2 <- (extract.clade(tree,clade2.mrca))$tip

fileConn<-file("clade1.txt")
writeLines(clade1, fileConn)
close(fileConn)

fileConn<-file("clade2.txt")
writeLines(clade2, fileConn)
close(fileConn)
colors <- rep("gray",length(tree$tip.label))
colors[which(tree$tip.label %in% clade1)] <- "orange"
colors[which(tree$tip.label %in% clade2)] <- "dodgerblue2"

png("tree_clades.png",width = 250, height = 250, units = "mm", res = 150)
plot.phylo(tree, cex = 0.3, tip.color = colors,type = "f")
legend("topright",c("clade 1","clade 2"),col=c("orange","dodgerblue2"), pch = 19, cex = 2.2, bty  = "n")
add.scale.bar(lwd = 2, cex = 2)
dev.off()
