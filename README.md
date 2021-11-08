# Twist_RNA

## System configuration

### Conda environment used to run the pipeline
The easier way is to create a conda environment by following these steps:

Create a yaml file named as `env.yml`.

```yaml=
name: Twist_RNA
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - python=3.8.8
  - snakemake=5.31.1
  - pandas=1.2.0
  - singularity=3.7.1
  #uncomment the following line if you run the pipeline on HPC cluster
  #- drmaa
```

Create the environment with conda:

```bash
conda env create -f env.yml
```

or if you use mamba:

```bash 
mamba env create -f env.yml
```

<br>

---

**Run the pipeline with demultiplexning in Uppsala: <br>**
```
git clone https://github.com/clinical-genomics-uppsala/Twist_RNA.git
git checkout develop
module add snakemake
module add slurm-drmaa
module add singularity
snakemake -p -j 1 --drmaa "-A wp1 -p core -n 1 -t 2:00:00 "  -s ./src/Snakemake/rules/Twist_RNA_yaml/Twist_RNA_yaml.smk
snakemake -p -j 80 --drmaa "-A wp1 -p core -n {cluster.n} -t {cluster.time}" -s ./Twist_RNA.smk --use-singularity --singularity-args "--bind /data --bind /projects --bind /scratch " --cluster-config Config/Slurm/cluster.json
```

**Run the pipeline from Fastq-files anywhere: <br>**
```
cd <analysis_dir>
git clone https://github.com/clinical-genomics-uppsala/Twist_RNA.git
git checkout develop
```

Create samples.csv with the following format: <br>
```
Sample_name1\tPath/to/fastq/R1.fastq.gz\tPath/to/fastq/R2.fastq.gz
Sample_name2\tPath/to/fastq/R1.fastq.gz\tPath/to/fastq/R2.fastq.gz
```

<br>

Adapt Config/Pipeline/configdefaults201012.yaml to your system by providing paths to the references needed
Create Twist_RNA.yaml with the following command:
```
snakemake -p -j 1 --drmaa "-A wp1 -p core -n 1 -t 2:00:00 "  -s ./src/Snakemake/rules/Twist_RNA_yaml/Twist_RNA_yaml_fastq.smk
```

<br>

Run pipeline with a command similar to this with bind points and -A adapted to your system: #Use screen or similar!
```
snakemake -p -j 80 --drmaa "-A wp1 -p core -n {cluster.n} -t {cluster.time}" -s ./Twist_RNA.smk --use-singularity --singularity-args "--bind /data --bind /projects --bind /scratch " --cluster-config Config/Slurm/cluster.json
```

<br>

**Reference files: #Or get them directly from us to get exactly the same versions <br>**
Arriba Star reference files (Needs 8 cores and 45Gb memory):<br>
```
mkdir /path/to/references
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq
```

<br>

Star-fusion reference files:
Download from: https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.9/ <br> 

<br>

FusionCatcher:
See instructions on Fusioncatcher github or follow commands in:<br>
```
https://github.com/ndaniel/fusioncatcher/blob/master/data/download-human-db.sh <br>
```

<br>

---

**Lauri's solution to download the mosdepth image:**
```
singularity pull mosdepth_0.3.2--h01d7912_0.sif docker://quay.io/biocontainers/mosdepth:0.3.2--h01d7912_0
```

Or download from: https://quay.io/repository/biocontainers/mosdepth?tab=tags

<br>

**How to run:**
```
snakemake --core 1 -s ./Twist_RNA.smk --use-singularity --singularity-args "--bind /home/massi --bind /mnt/WD1 --bind /mnt/WD2 "
```

NOTE: having /mnt as the first mounting point instead of /home lead to a permission denied error.