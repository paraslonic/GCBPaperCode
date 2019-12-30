plot_complexity <- function(tab, h, .complexity_mult, scale){
  for(i in 1:nrow(tab)){
    h. <- (tab$complexity[i])*.complexity_mult+h
    polygon(c(tab$start[i],tab$start[i],tab$end[i],tab$end[i])*scale,c(h,h.,h.,h), lwd=0.5)
  }
  x. <- seq(0, max(tab$end), 1e6)
  x.. <- seq(0, max(tab$end), 1e5)
  
  y. <- rep(h-15, length(x.))
  text(x.*scale, y., x./1e6, cex = 0.8, srt = 0, col = "gray20")
  for(i in 1:length(x.)){lines(c(x.[i], x.[i])*scale, c(h-5, h), col = "gray20")}
  for(i in 1:length(x..)){lines(c(x..[i], x..[i])*scale, c(h-3, h), col = "gray20")}
  y.tics <- seq(0,floor(max(tab$complexity)/2),length.out = 2)
  axis(side=2, at=c(h+y.tics*.complexity_mult), lwd = 2, col = "gray70", labels = y.tics, cex.axis=0.8)
}

get_complexity <- function(org){
  conn <- dbConnect(RSQLite::SQLite(), paste0(BD_path,org,".db"))
  print(dbGetQuery(conn, "select * from genomes_table where genome_id = 0;"))
  res <- dbGetQuery(conn, "select n.start_coord, n.end_coord, c.prob_window_complexity from complexity_table c inner join nodes_table n on c.node_id=n.node_id and c.contig_id=n.contig_id where c.contig_id = 0 and c.window=20 order by n.start_coord")
  colnames(res) <- c("start","end","complexity")
  return(res)
}

plot_synteny_mauv <- function(mauve_file, scale1, scale2, h1, h2){
  col. <- rgb(0.1,0.1,0.1,0.18)
  mauv <- read.delim(mauve_file, as.is = T)
  colnames(mauv) <- c("S1","E1","S2","E2")
  mauv <- as.data.frame(apply(mauv,c(1,2), abs))
  mauv$len1 <- mauv$E1-mauv$S1
  mauv$len2 <- mauv$E2-mauv$S2
  s <- subset(mauv, mauv$len1 > 1000 & mauv$len2 > 1000)
  #s <- subset(s, s$L1 > 200)
  for(i in 1:nrow(s)){
    polygon(c(s$S1[i]*scale2,s$S2[i]*scale1, s$E2[i]*scale1, s$E1[i]*scale2), c(h2, h1, h1, h2),
            col = col., border=F, lwd = 0.01)
  }
}

plot_phaster <- function(phaster_file, scale, h){
  phaster <- read.delim(phaster_file, head = T, sep = "\t")
  phaster <- strsplit(as.character(phaster$REGION_POSITION), split = '-')
  phaster <- as.data.frame(phaster)
  phaster <- apply(phaster, c(1,2), as.integer)
  for(k in 1:ncol(phaster)){
    polygon(c((phaster[1,k]),(phaster[1,k]), phaster[2,k], phaster[2,k])*scale,
            c(h-8, h, h, h-8), col="#ffa54fc8",border="tan1", lwd=0.5)
  }
}

