
rule ID_SNP_pileup:
    input:
        bam="STAR2/{sample}_Aligned.sortedByCoord.out.bam",
        bai="STAR2/{sample}_Aligned.sortedByCoord.out.bam.bai",
        bed=config["bed"]["ID_SNPs"],
        ref=config["reference"]["ref"],
    output:
        vcf="ID_SNPs/{sample}_ID_SNPs.vcf",
    log:
        "logs/ID_SNPs/ID_SNP_pileup/{sample}.log",
    container:
        config["singularity"].get("bcftools", config["singularity"].get("default", ""))
    shell:
        "(bcftools mpileup -g -R {input.bed} -f {input.ref} -O v -o {output.vcf} {input.bam}) &> {log}"
