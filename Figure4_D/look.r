tab <- read.delim("NC_002506.1.txt")

pdf("compare_with_integron.pdf", width = 7, height = 2.8, pointsize = 2)

plot(tab$position/1e+06, tab$complexity, type = "l", frame = FALSE, xlab = "plasmid position, Mbp", 
     ylab = "complexity", cex.lab = 2, lwd = 2, col = "gray30", xaxt = "none", cex.axis = 1.5)
axis(1, at=c(seq(0,1.1,0.3),1.1),c(seq(0,1.1,0.3),1.1), col.axis="black", las=1, pos = -0.5, cex.axis = 1.5)

xx <- c(tab$pos/1e+06, rev(tab$pos/1e+06))
yy <- c(rep(0, nrow(tab)), rev(tab$complexity))
polygon(xx, yy, col='gray50',lwd = 0.1)

int.start = 309750/1e+06
int.end = 435418/1e+06
polygon(c(int.start, int.end, int.end, int.start), c(0,0,-5,-5),col='blue')

legend("topright", "integron", lwd = 2, col = "blue", bty = "n", cex = 3)

dev.off()
