
configfile: "Twist_RNA.yaml"

def get_input():
    input_list = []
    if config["RNA_Samples"] != "No RNA" :
        '''Demultiplexning'''
        input_list.append(["fastq/RNA/" + s + "_R1.fastq.gz" for s in config["RNA_Samples"]])
        input_list.append(["fastq/RNA/" + s + "_R2.fastq.gz" for s in config["RNA_Samples"]])

        '''Fusions'''
        input_list.append(["STAR/" + s + "Aligned.sortedByCoord.out.bam" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/Fusions/" + s + ".Arriba.HighConfidence.fusions.tsv" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/Arriba.fusions.tsv" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/Fusions/" + s + ".Arriba.fusions.pdf" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/Arriba.fusions.pdf" for s in config["RNA_Samples"]])
        input_list.append(["STAR2/" + s + "Chimeric.out.junction" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/Fusions/star-fusion.fusion_predictions.tsv" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/star-fusion.fusion_predictions.abridged.coding_effect.tsv" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/Fusion_inspector_web.html" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/FusionCatcher_summary_candidate_fusions.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/Fusions_" + s + ".tsv" for s in config["RNA_Samples"]])
        #input_list.append(["FI/" + s + "/inspector.FusionInspector.fusions.abridged.tsv" for s in config["RNA_Samples"]])

        '''Imbalance'''
        input_list.append("Results/RNA/Imbalance/imbalance_all_gene.txt")
        input_list.append("Results/RNA/Imbalance/imbalance_called_gene.txt")

        '''Exon skipping'''
        #input_list.append("Results/RNA/Exon_skipping/exon_skipping.txt")
        input_list.append(["Results/RNA/" + s + "/Fusions/" + s + "_MET_exon_skipping.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/" + s + "_exon_skipping.txt" for s in config["RNA_Samples"]])

        '''QC'''
        input_list.append(["Results/RNA/" + s + "/QC/Housekeeping_gene_coverage.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/Exon_gene_coverage_all.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/Exon_gene_coverage_low.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC_bam_stat.txt" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.clipping_profile.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.deletion_profile.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.insertion_profile.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.DupRate_plot.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.GC_plot.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.inner_distance_plot.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC_read_distribution.txt" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.junction_plot.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.geneBodyCoverage.r" for s in config["RNA_Samples"]])
        #input_list.append(["Results/RNA/" + s + "/QC/RSeQC.FPKM.xls" for s in config["RNA_Samples"]])
        input_list.append("Results/RNA/Bam_stats.txt")

        '''QC2'''
        input_list.append(["qc/" + s + "/" + s + "_Stat_table.csv" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + "Aligned.sortedByCoord.out_fastqc.html" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + "Aligned.sortedByCoord.out_fastqc.zip" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + ".samtools-stats.txt" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + ".HsMetrics.txt" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + "_stats_mqc.csv" for s in config["RNA_Samples"]])
        input_list.append("qc/batchQC_stats_mqc.json")
        input_list.append("qc/batchQC_stats_unsorted.csv")
        input_list.append("Results/RNA/MultiQC.html")
        input_list.append(["qc/" + s + "/" + s + ".insert_size_metrics.txt" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + ".alignment_summary_metrics.txt" for s in config["RNA_Samples"]])
        input_list.append(["qc/" + s + "/" + s + "_avg_CV_genes_over_500X.txt" for s in config["RNA_Samples"]])

    return input_list

rule all:
    input:
        get_input()


include: "src/Snakemake/workflow/Twist_RNA_workflow.smk"
