#setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/Figure_7/performance")
time_coalign <- read.delim("time_coalign", sep = " ")
time_nocoalign <- read.delim("time_nocoalign", sep = " ")
head(time_coalign)

time_coalign$total = time_coalign$parse_orthogroups+time_coalign$estimate_complexity
time_nocoalign$total = time_nocoalign$parse_orthogroups+time_nocoalign$estimate_complexity

time_coalign$total = time_coalign$total/60
time_nocoalign$total = time_nocoalign$total/60

max(time_coalign$total)

pdf("runtime.pdf")
plot(time_nocoalign$genomes, time_nocoalign$total, ylim = c(1,500),type = "b", frame = FALSE, pch = 19,
     col = "black",lty = 1, lwd = 1, cex.lab = 1.4,log="y",
     xlab = "number of genomes", ylab="runtime, minutes")
lines(time_coalign$genomes, time_coalign$total, type="b", col = "gray30")
legend("topleft", c("coalign is enabled", "coalign is disabled"), 
       col = c("gray50", "black"), bty="n", pch=c(1, 16))
dev.off()
