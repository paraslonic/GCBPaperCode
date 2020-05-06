files = list.files("genecount","*.csv")

for(file in files){
  gene.count <- read.delim(paste0("genecount/",file))
  gene.count <- gene.count[,-c(1,ncol(gene.count))]
  og_with_paralog <- sum(apply(gene.count,1,max)>1)/nrow(gene.count)
  paralog_ogs_per_genome <- apply(gene.count,2,function(x){sum(x>2)})/apply(gene.count,2,function(x){sum(x)})
  name = gsub(".csv","",file)
  print(paste(name, og_with_paralog, mean(paralog_ogs_per_genome)))
}


