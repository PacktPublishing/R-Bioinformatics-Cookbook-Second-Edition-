library(rbioinfcookbook)
library(Rsamtools)

bam_path <- fs::path_package("extdata", 
                             "windows.bam", 
                             package="rbioinfcookbook"
)
pileup_df <- Rsamtools::pileup(bam_path)

library(bumphunter)
clusters <- bumphunter::clusterMaker(pileup_df$seqnames,
                                     pileup_df$pos,
                                     maxGap = 100
)

final_bumps <- bumphunter::regionFinder(pileup_df$count,
                                        pileup_df$seqnames,
                                        pileup_df$pos,
                                        clusters,
                                        cutoff = 1
)