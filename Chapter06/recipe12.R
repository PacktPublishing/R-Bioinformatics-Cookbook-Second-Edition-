library(ComplexHeatmap)
library(viridisLite)
library(stringr)
library(RColorBrewer)
library(circlize)
library(rbioinfcookbook)


mat <- log(as.matrix(at_tf_gex[, 5:55]))
ecotype <- stringr::str_split(colnames(mat), ",", simplify=TRUE)[,1]
part <- stringr::str_split(colnames(mat), ", ", simplify=TRUE)[,2]

data_col_func <- circlize::colorRamp2(seq(0, max(mat), length.out = 6), viridisLite::magma(6))

ecotype_colours <- c(RColorBrewer::brewer.pal(12, "Set3"), 
                     RColorBrewer::brewer.pal(5, "Set1"))
names(ecotype_colours) <- unique(ecotype)

part_colours <- RColorBrewer::brewer.pal(3, "Accent")
names(part_colours) <- unique(part)

top_annot <- HeatmapAnnotation("Ecotype" = ecotype, 
                               "Plant Part" = part, 
                               col = list("Ecotype" = ecotype_colours,
                                          "Plant Part" = part_colours),
                               annotation_name_side = "left")

side_annot <- rowAnnotation(length = anno_points(at_tf_gex$Length, pch = 16, size = unit(1, "mm"), 
                                                 axis_param = list(at = seq(1, max(at_tf_gex$Length), length.out=4)
                                                 ),
))

ht_1 <- Heatmap(mat, name="log(TPM)", row_km = 6, 
                col = data_col_func,
                top_annotation = top_annot, 
                right_annotation = side_annot,
                cluster_columns = TRUE,
                column_split = ecotype,
                show_column_names = FALSE,
                column_title = " "
)

of_interest <- c("bHLH", "WRKY", "bZIP") 
short_family <- at_tf_gex$Family
short_family[! short_family %in% of_interest] <- "other"

fam_colours <- RColorBrewer::brewer.pal(4, "Set1")
names(fam_colours) <- unique(short_family)

ht_2 <- Heatmap(short_family, name = "TF Family",
                top_annotation = 
                  HeatmapAnnotation(
                    summary = anno_summary(which= "row", 
                                           height = unit(2, "cm") 
                    )
                  ),
                col = fam_colours,
                width = unit(0.75, "cm")
)              
ht <- ht_1 + ht_2