library("ape")
library("phangorn")
library("phytools")
library("ggtree")

tree <- read.tree("of_species_tree/SpeciesTree_rooted_node_labels.txt")
tree <- midpoint(tree)

clade1.mrca = MRCA(tree,c("GCF_002022275.1_ASM202227v1_genomic","GCF_900455485.1_56269_H02_genomic"))
clade2.mrca = MRCA(tree,c("GCF_001020715.1_ASM102071v1_genomic","GCF_002417665.1_ASM241766v1_genomic"))

clade1 <- (extract.clade(tree,clade1.mrca))$tip
clade2 <- (extract.clade(tree,clade2.mrca))$tip

fileConn<-file("clade1.txt")
writeLines(clade1, fileConn)
close(fileConn)

fileConn<-file("clade2.txt")
writeLines(clade2, fileConn)
close(fileConn)


png("tree_clades.png",width = 250, height = 250, units = "mm", res = 150)
colors <- rep("gray",length(tree$tip.label))
colors[which(tree$tip.label %in% clade1)] <- "orange"
colors[which(tree$tip.label %in% clade2)] <- "dodgerblue2"
plot.phylo(tree, cex = 0.3, tip.color = colors,type = "f")
legend("topright",c("clade 1","clade 2"),col=c("orange","dodgerblue2"), pch = 19, cex = 2.2, bty  = "n")
add.scale.bar(lwd = 2, cex = 2)
dev.off()