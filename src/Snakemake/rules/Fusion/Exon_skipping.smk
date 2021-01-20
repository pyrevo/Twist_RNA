
rule Exon_skipping:
    input:
        bed=config["bed"]["bedfile"],
        junction="STAR/{sample}SJ.out.tab",
    output:
        results="Results/RNA/{sample}/Fusions/{sample}_exon_skipping.txt"
    log:
        "logs/Fusion/Exon_skipping.log"
    singularity:
        config["singularity"]["python"]
    shell:
        "(python3.6 src/Exon_skipping.py {input.bed} {input.junction} {output.results}) &> {log}"
