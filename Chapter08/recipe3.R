library(ensembldb)
library(EnsDb.Rnorvegicus.v79)
hasProteinData(EnsDb.Rnorvegicus.v79)

listTables(EnsDb.Rnorvegicus.v79) #lloking for column with ipro accession
e <- EnsDb.Rnorvegicus.v79
k <- head(keys(e, keytype = "GENEID"), n = 3 )

select(e, keys = GeneIdFilter(k),
       columns = c("TXBIOTYPE", "UNIPROTID", "PROTEINID","INTERPROACCESSION"))

library(biomaRt)

biomart_athal <- useMart(biomart = "plants_mart", 
                         host = "plants.ensembl.org", 
                         dataset = "athaliana_eg_gene")

getBM( c("tair_locus", "interpro"), 
       filters=c("tair_locus"), 
       values = c("AT5G40950", "AT2G40510"), mart = biomart_athal)
