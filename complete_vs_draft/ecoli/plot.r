library(RSQLite)

conn_complete <- dbConnect(RSQLite::SQLite(), "complete/complete.db")
res_complete <- dbGetQuery(conn_complete, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_complete) <- c("start","end","complexity")

conn_draft <- dbConnect(RSQLite::SQLite(), "draft/draft.db")
res_draft <- dbGetQuery(conn_draft, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
colnames(res_draft) <- c("start","end","complexity")

plot(res_complete$start, res_complete$complexity, ylim = c(-max(res_draft$complexity), max(res_complete$complexity)),
     type="n", pch=3, cex = 0.3, col="gray50", lwd = 1, xlab="chromosome position, Mbp", 
     ylab="complexity", cex.lab=1.5, yaxt="n", axes=F)
axis(side=1, lwd = 0.5, col = "black", cex.axis=0.8, at = c(0,1,2,3,4,4.6)*10^6, labels = c(0,1,2,3,4,4.6), cex.axis = 1)
axis(side=2, at=c(0,5,10,15), lwd = 2, col = "gray20", cex.axis=0.8)
axis(side=4, at=c(0,-5,-10), labels = c(0,5,10), lwd = 2, col = "blue", cex.axis=0.8)
legend("topright",c("complete","draft"), bty="n", col=c("black","blue"), lwd = 3)

for(i in 1:nrow(res_complete)){
  h. <- (res_complete$complexity[i])
  polygon(c(res_complete$start[i],res_complete$start[i],res_complete$end[i],res_complete$end[i]),c(0,h.,h.,0), lwd=0.5)
}

for(i in 1:nrow(res_draft)){
  h. <- -(res_draft$complexity[i])
  polygon(c(res_draft$start[i],res_draft$start[i],res_draft$end[i],res_draft$end[i]),c(0,h.,h.,0), lwd=0.5, col = "blue", border="blue")
}

title("Escherichia coli")

merged <- merge(res_draft, res_complete, by = "start")
print(cor(merged$complexity.x,merged$complexity.y))
