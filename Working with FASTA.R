# An R Script for Working with FASTA

library(seqinr)
library(ape)
library(rentrez)
library(Peptides)

# Read a local FASTA file
cox1<-read.fasta(file="cox1.fasta",seqtype="AA")

# Retrieve a GENBANK sequence as a binary object
AB003468<-read.GenBank("AB003468",as.character="TRUE")

# Save Genbank Sequence as FASTA format
write.dna(AB003468,file="AB003468.fasta",format="fasta",append=FALSE,nbcol 
          = 6, colsep=" ", colw = 10)

# Strip first sequence of AB003468 into just characters
CloningVector<-AB003468[[1]]

CloningVector
# Do a basic nucleotide count on CloningVector
count<-count(CloningVector,1)

# Compute the GC content of CloningVector
GC<-GC(CloningVector)

# Compute windows of size 200 for our sequence
GCwindow<-seq(1,length(CloningVector)-200,by=200)
# find the length of the vector GCwindow
n<-length(GCwindow)
# Make a vector the same length but "blank" for us to fill
Chunks<-numeric(n)
# FOR loop to compute GC per chunk
for (i in 1:n) {
  chunk <- CloningVector[GCwindow[i]:(GCwindow[i]+199)]
  chunkGC<-GC(chunk)
  print(chunkGC)
  Chunks[i]<-chunkGC
}

# Plot GC changes in sequence
plot(GCwindow,Chunks,type="b",xlab="Nucleotide start position",ylab="GC content")

# Custom Function for GC Window Plotting
slidingwindowGCplot<-function(windowsize,DNAinputseq)
{
  GCwindow<-seq(1,length(DNAinputseq)-windowsize,by=windowsize)
  # find the length of the vector GCwindow
  n<-length(GCwindow)
  # Make a vector the same length but "blank" for us to fill
  Chunks<-numeric(n)
  for (i in 1:n) {
    chunk <- DNAinputseq[GCwindow[i]:(GCwindow[i]+windowsize-1)]
    chunkGC<-GC(chunk)
    print(chunkGC)
    Chunks[i]<-chunkGC
  }
  # Plot GC changes in sequence
  plot(GCwindow,Chunks,type="b",xlab="Nucleotide start position",ylab=
         "GC content",main=paste("GC Plot with windowsize",windowsize))
}  

slidingwindowGCplot(100,CloningVector)
slidingwindowGCplot(150,CloningVector)
slidingwindowGCplot(200,CloningVector)

# Custom Function for Hydrophobicity Plotting
slidingwindowhydrophobicity<-function(windowsize,AAinputseq)
{
  Hydrowindow<-seq(1,nchar(AAinputseq)-windowsize,by=windowsize)
  # find the length of the vector Hydrowindow
  n<-length(Hydrowindow)
  # Make a vector the same length but "blank" for us to fill
  Chunks<-numeric(n)
  for (i in 1:n) {
    chunk <- AAinputseq[Hydrowindow[i]:(Hydrowindow[i]+windowsize-1)]
    print(chunk)
    chunkHydro<-hydrophobicity(chunk)
    print(chunkHydro)
    break
    Chunks[i]<-chunkHydro
  }
  # Plot Hydrophobicity changes in sequence
  plot(Hydrowindow,Chunks,type="b",xlab="AA start position",ylab=
         "Hydrophobicity content",main=paste("Hydrophobicity Plot with windowsize",windowsize))
}  

