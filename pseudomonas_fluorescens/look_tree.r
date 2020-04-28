setwd("/data/ps/pseudomonas_stutzeri/faa/OrthoFinder/Results_Apr22/Species_Tree/")
library("ape")
library("phangorn")
library("phytools")
library("ggtree")

#setwd("/data/ps/pseudomonas_fluorescens/")
tree <- read.tree("faa/OrthoFinder/Results_Apr22/Species_Tree/SpeciesTree_rooted_node_labels.txt")
tree <- midpoint(tree)

clade1.mrca = MRCA(tree,"GCF_002022275.1_ASM202227v1_genomic","GCF_900455485.1_56269_H02_genomic")
clade2.mrca = MRCA(tree,"GCF_001020715.1_ASM102071v1_genomic","GCF_002417665.1_ASM241766v1_genomic")

clade1 <- (extract.clade(tree,clade1.mrca))$tip
clade2 <- (extract.clade(tree,clade2.mrca))$tip

fileConn<-file("clade1.txt")
writeLines(clade1, fileConn)
close(fileConn)

fileConn<-file("clade2.txt")
writeLines(clade2, fileConn)
close(fileConn)


pdf("tree_2clades.pdf")
colors <- rep("gray",length(tree$tip.label))
colors[which(tree$tip.label %in% clade1)] <- "orange"
colors[which(tree$tip.label %in% clade2)] <- "dodgerblue2"
plot.phylo(tree, cex = 0.3, tip.color = colors,type = "f")
legend("topright",c("clade 1","clade 2"),col=c("orange","dodgerblue2"), pch = 19, cex = 1.1, bty  = "n")
a
add.scale.bar()
dev.off()