library(rbioinfcookbook)
library(ggplot2)
library(gghighlight)

fission_ge |> 
  dplyr::mutate(signif = dplyr::if_else(padj < 0.05, TRUE, FALSE),
                scaled_p = -log10(padj)
  ) |> 
  ggplot() +
  aes(x = log2FoldChange, y = scaled_p ) + 
  geom_point(aes(colour = signif)) +
  gghighlight(scaled_p > 10 , 
              label_key = id)


ggplot(ath_ts) +
  aes(x=time, y=logFC) + 
  geom_line(aes(colour = target_id)) +
  scale_x_continuous(breaks = c(0,3,6,12), labels = c("0h", "3h", "6h", "12h")) + 
  gghighlight(min(P.Value) < 0.05,
              unhighlighted_params = list(linewidth =0.5,
                                          colour = alpha("gray", 0.2))
  )