rm(list = ls())
options(stringsAsFactors = F)
library(tidyverse)
library(AnnotationForge)
library(stringr)

librarywd="build"
setwd(librarywd)
egg <- rio::import('out.emapper.annotations.tsv',fill=TRUE)
names(egg)[1]<-"query_name"
egg[egg==""] <- NA 
egg[egg=="-"] <- NA 
# colnames(egg)

gene_info <- egg %>%
  dplyr::select(GID = query_name, GENENAME = Preferred_name) %>% na.omit()
gterms <- egg %>%
  dplyr::select(query_name, GOs) %>% na.omit()
all_go_list=str_split(gterms$GOs,",")
gene2go <- data.frame(GID = rep(gterms$query_name,
                                times = sapply(all_go_list, length)),
                      GO = unlist(all_go_list),
                      EVIDENCE = "IEA")
gene2ko <- egg %>%
  dplyr::select(GID = query_name, KO = KEGG_ko) %>%
  na.omit()
if(!file.exists('kegg_info.RData')){
  library(jsonlite)
  library(purrr)
  library(RCurl)
  update_kegg <- function(json = "ko00001.json",file=NULL) {
    pathway2name <- tibble(Pathway = character(), Name = character())
    ko2pathway <- tibble(Ko = character(), Pathway = character())
    kegg <- fromJSON(json)
    for (a in seq_along(kegg[["children"]][["children"]])) {
      A <- kegg[["children"]][["name"]][[a]]
      for (b in seq_along(kegg[["children"]][["children"]][[a]][["children"]])) {
        B <- kegg[["children"]][["children"]][[a]][["name"]][[b]] 
        for (c in seq_along(kegg[["children"]][["children"]][[a]][["children"]][[b]][["children"]])) {
          pathway_info <- kegg[["children"]][["children"]][[a]][["children"]][[b]][["name"]][[c]]
          pathway_id <- str_match(pathway_info, "ko[0-9]{5}")[1]
          pathway_name <- str_replace(pathway_info, " \\[PATH:ko[0-9]{5}\\]", "") %>% str_replace("[0-9]{5} ", "")
          pathway2name <- rbind(pathway2name, tibble(Pathway = pathway_id, Name = pathway_name))
          kos_info <- kegg[["children"]][["children"]][[a]][["children"]][[b]][["children"]][[c]][["name"]]
          kos <- str_match(kos_info, "K[0-9]*")[,1]
          ko2pathway <- rbind(ko2pathway, tibble(Ko = kos, Pathway = rep(pathway_id, length(kos))))
        }
      }
    }
    save(pathway2name, ko2pathway, file = file)
  }
  update_kegg(json = "ko00001.json",file="kegg_info.RData")
}
load("kegg_info.RData")

colnames(ko2pathway)=c("KO",'Pathway')

gene2ko$KO=str_replace(gene2ko$KO,"ko:","")

gene2pathway <- gene2ko %>% left_join(ko2pathway, by = "KO") %>% 
  dplyr::select(GID, Pathway) %>%
  na.omit()

#save.image("build.RData")

## write out
library(AnnotationForge)
makeOrgPackage(gene_info=gene_info,
               go=gene2go,
               ko=gene2ko,
               maintainer='',
               author='',
               pathway=gene2pathway,
               version="0.0.1",
               outputDir = librarywd,
               tax_id="59729",
               genus="Taeniopygia",
               species="guttata",
               goTable="go")
install.packages(paste(librarywd,"org.local.eg.db",sep="/"), repos = NULL, type="source")
library(org.Tguttata.eg.db)
