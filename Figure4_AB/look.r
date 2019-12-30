library("data.table")
library("IRanges")

### complexity
tab <- read.delim("NC_000913.3.txt", head = TRUE)

### oliveira_et_al
gtab <- fread("NC_000913_protid")
prot.pos <- data.table(protid=gtab$V5, pos=(gtab$V2+gtab$V3)/2)
setkey(prot.pos, protid)
roch <- fread("Hotspots_ref.txt")
roch <- subset(roch, roch$Accession=="NC_000913")
genes1 <-  roch$Protein_ID_1
genes2 <-  roch$Protein_ID_2
roch <- subset(roch, (genes2 %in% gtab$V5) & (genes1 %in% gtab$V5))
genes1.pos <-  prot.pos[roch$Protein_ID_1]$pos
genes2.pos <-  prot.pos[roch$Protein_ID_2]$pos

pdf("compare_with_Oliveira_etal.pdf", width = 7, height = 2.2, pointsize = 2)

layout(matrix(c(1,2), 1, 2, byrow = TRUE),
       widths=c(3,1))

plot(tab$position/1e+06, tab$complexity, type = "l", frame = FALSE, xlab = "chromosome position, Mbp", 
     ylab = "complexity", cex.lab = 1.5, lwd = 0.5, col = "gray30", xaxt = "none")
axis(1, at=c(0:4,4.6),c(0:4,4.6), col.axis="black", las=1, pos = -2)
xx <- c(tab$pos/1e+06, rev(tab$pos/1e+06))
yy <- c(rep(0, nrow(tab)), rev(tab$complexity))
polygon(xx, yy, col='gray50',lwd = 0.1)

for(i in 1:nrow(roch)){
  polygon(c(genes1.pos[i]/1e+06,genes2.pos[i]/1e+06,genes2.pos[i]/1e+06, genes1.pos[i]/1e+06),
          c(-0.5,-0.5, -4, -4), col ="blue", border = NA)
}
legend("topright", "hotspots from Oliveira et al.", lwd = 3, col = "blue", bty = "n")


# box plot
c.ranges <- IRanges(start = tab$position, end = tab$position, names = tab$complexity)
hs.ranges <- IRanges(start=genes1.pos, end=genes2.pos)
findOverlaps(c.ranges, hs.ranges, type = "within")
complexity_in_hs <- as.numeric(names(c.ranges[c.ranges %within% hs.ranges]))
complexity_out_hs <- as.numeric(names(c.ranges[!(c.ranges %within% hs.ranges)]))
boxplot((complexity_in_hs), (complexity_out_hs), outline=FALSE, ylab = "complexity", 
        cex.lab = 1.5, frame.plot = FALSE, names = c("within hotspots", "out of hotspots"), 
        cex.axis = 1, col = "gray60", las = 2, xaxt = "none")
text(1:2, par("usr")[3] - 0.5, labels = c("within hotspots", "others"), srt = 45, adj = 1, xpd = TRUE);
dev.off()

# stats
wilcox.test(complexity_in_hs,complexity_out_hs)

