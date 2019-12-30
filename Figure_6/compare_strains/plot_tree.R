setwd("/data4/bio/operonTravel_d4/coli_three_clades/all_tree_parsnp_withUMN026//")
library("ape")
library("phytools")
tr <- read.tree("P_2019_02_05_194645572785/parsnp.tree")
tr <- midpoint.root(tr)

LF82.color <- "orange"
IAI1.color <- "black"
K12.color <- "chartreuse2"
O157H7.color <- "red"
UMN26.color="dodgerblue2"
### colorize
colors <- rep("gray",length(tr$tip.label))
LF82 <- list.files("../LF82_B2_selected_fna/fna/")
colors[which(tr$tip.label %in% LF82)] <- LF82.color
IAI1 <- list.files("../IAI1_B1_selected_fna/fna/")
colors[which(tr$tip.label %in% IAI1)] <- IAI1.color
UMN26 <- list.files("../UMN026_D_selected_fna/fna/")
colors[which(tr$tip.label %in% UMN26)] <- UMN26.color
K12 <- list.files("../K12_selected_fna/fna/")
colors[which(tr$tip.label %in% K12)] <- K12.color
O157H7 <- list.files("../O157H7_E_selected_fna/fna/")
colors[which(tr$tip.label %in% O157H7)] <- O157H7.color

###
pdf("ecoli_clades_tree.pdf")
plot.phylo(tr, cex = 0.2, tip.color = colors,type = "f")
legend("topright",c("A (K12 MG1655)","B1 (IAI1)","B2 (LF82)","D (UMN026)","E (O157:H7 Sakai)"),col=c(K12.color, IAI1.color, LF82.color,IAI1.color, O157H7.color), pch = 19, cex = 0.7, bty  = "n")
add.scale.bar()
dev.off()
