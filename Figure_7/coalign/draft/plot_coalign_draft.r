library(RSQLite)

#setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/Figure_7/coalign/draft/")

conn_coalign <- dbConnect(RSQLite::SQLite(), "coalign/gene_graph.db")
res_coalign <- dbGetQuery(conn_coalign, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_coalign) <- c("start","end","complexity")

conn_nocoalign <- dbConnect(RSQLite::SQLite(), "nocoalign/gene_graph.db")
res_nocoalign <- dbGetQuery(conn_nocoalign, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_nocoalign) <- c("start","end","complexity")


png("coalign_coli.png",width = 200, height = 150, units = "mm", res = 300)
plot(res_coalign$start, res_coalign$complexity, ylim = c(-max(res_coalign$complexity), max(res_coalign$complexity)),
     type="n", pch=3, cex = 0.3, col="gray50", lwd = 1, xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)
axis(side=1, lwd = 0.5, col = "black", cex.axis=0.8, at = c(0,1,2,3,4,4.6)*10^6, labels = c(0,1,2,3,4,4.6), cex.axis = 1)
axis(side=2, at=c(0,5), lwd = 2, col = "gray20", cex.axis=0.8)
axis(side=4, at=c(0,-5), labels = c(0,5), lwd = 2, col = "gray50", cex.axis=0.8)
legend("topright",c("coalign","no coalign"), bty="n", col=c("black","gray60"), lwd = 5)

for(i in 1:nrow(res_coalign)){
  h. <- (res_coalign$complexity[i])
  polygon(c(res_coalign$start[i],res_coalign$start[i],res_coalign$end[i],res_coalign$end[i]),c(0,h.,h.,0), lwd=0.5)
}

for(i in 1:nrow(res_nocoalign)){
  h. <- -(res_nocoalign$complexity[i])
  polygon(c(res_nocoalign$start[i],res_nocoalign$start[i],res_nocoalign$end[i],res_nocoalign$end[i]),c(0,h.,h.,0), 
          lwd=0.5, col = "gray50", border="gray50")
}
dev.off()

#title("Escherichia coli")

cor(res_nocoalign$complexity, res_coalign$complexity)

merged <- merge(res_coalign, res_nocoalign, by = "start")
print(cor(merged$complexity.x,merged$complexity.y))
#text(0, 11,"correlation = 0.99",adj = 0)

