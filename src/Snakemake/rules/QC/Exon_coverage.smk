

rule Exon_coverage:
    input:
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam",
        bed = config["bed"]["bedfile"]
    output:
        coverage_all = "Results/RNA/{sample}/QC/Exon_gene_coverage_all.txt",
        coverage_low = "Results/RNA/{sample}/QC/Exon_gene_coverage_low.txt"
    #singularity:
    #    config["singularity"]["python"]
    shell:
        "module load samtools && "
        "python3.6 src/Exon_coverage.py {input.bam} {input.bed} {output.coverage_all} {output.coverage_low}"
