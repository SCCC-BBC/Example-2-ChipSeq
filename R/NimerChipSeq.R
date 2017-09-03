downloadFile <- function(input,output) {

  r.lib<- Sys.getenv("R_LIBS_USER")

  if (!dir.exists(dirname(output)))
  {
    dir.create(dirname(output), recursive = TRUE)
  }

  cmd1 <- paste("sh",file.path(r.lib,"NimerChipSeq/bin/bash/downloadFromAws.sh"),input,output,sep = " ")

  print(cmd1)

  system(cmd1)
}

# R -e 'library(ChipSeq);library(DoGs);library(NimerChipSeq);NimerChipSeq:::rundownloadFile("https://s3.us-east-2.amazonaws.com/nimerlab-share/Ye-TAF1-ChIP.tar.gz","/scratch/projects/bbc/aiminy_project/NimerChipSeq")'

rundownloadFile <- function(input, output,wait.job=NULL) {
  Rfun1 <- 'library(ChipSeq);library(DoGs);library(NimerChipSeq);re <- NimerChipSeq:::downloadFile('
  input=input
  output=output
  Rfun2 <- ')'

  Rinput <- paste0('\\"',input,'\\",',
                   '\\"',output,'\\"')

  Rfun <-paste0(Rfun1,Rinput,Rfun2)

  rm.exon.intron <- createBsubJobArrayRfun(Rfun,"download[1]",wait.job.name=wait.job)

  system(rm.exon.intron)
}
