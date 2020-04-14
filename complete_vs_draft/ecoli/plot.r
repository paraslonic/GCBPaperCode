library(RSQLite)

#setwd("/data12/bio/PROJECTS/operonTravel/GCBPaperCode/complete_vs_draft/ecoli")

conn_complete <- dbConnect(RSQLite::SQLite(), "complete/complete.db")
res_complete <- dbGetQuery(conn_complete, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_complete) <- c("start","end","complexity")

conn_draft <- dbConnect(RSQLite::SQLite(), "draft/draft.db")
res_draft <- dbGetQuery(conn_draft, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_draft) <- c("start","end","complexity")

plot(res_complete$start, res_complete$complexity, ylim = c(-max(res_draft$complexity), max(res_complete$complexity)),
     type="n", pch=3, cex = 0.3, col="gray50", lwd = 1, xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)

for(i in 1:nrow(res_complete)){
  h. <- (res_complete$complexity[i])
  polygon(c(res_complete$start[i],res_complete$start[i],res_complete$end[i],res_complete$end[i]),c(0,h.,h.,0), lwd=0.5)
}

for(i in 1:nrow(res_draft)){
  h. <- -(res_draft$complexity[i])
  polygon(c(res_draft$start[i],res_draft$start[i],res_draft$end[i],res_draft$end[i]),c(0,h.,h.,0), lwd=0.5, col = "blue", border="blue")
}

legend("topright",c("complete","draft"), bty="n", col=c("black","blue"), lwd = 3)


x. <- seq(0, max(res$end), 1e6)
x.. <- seq(0, max(res$end), 1e5)

y. <- rep(h-15, length(x.))
text(x.*scale, y., x./1e6, cex = 0.8, srt = 0, col = "gray20")
for(i in 1:length(x.)){lines(c(x.[i], x.[i])*scale, c(h-5, h), col = "gray20")}
for(i in 1:length(x..)){lines(c(x..[i], x..[i])*scale, c(h-3, h), col = "gray20")}
y.tics <- seq(0,floor(max(res$complexity)/2),length.out = 2)
axis(side=2, at=c(h+y.tics*.complexity_mult), lwd = 2, col = "gray70", labels = y.tics, cex.axis=0.8)