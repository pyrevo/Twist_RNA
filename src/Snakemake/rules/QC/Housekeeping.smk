

rule Housekeeping_coverage:
    input:
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam",
        bed = config["bed"]["bedfile"]
    output:
        coverage = "Results/RNA/{sample}/QC/Housekeeping_gene_coverage.txt"
    singularity:
        config["singularity"]["python"]
    shell:
        "python3.6 src/HK_gene_coverage.py {input.bam} {input.bed} {output.coverage}"
