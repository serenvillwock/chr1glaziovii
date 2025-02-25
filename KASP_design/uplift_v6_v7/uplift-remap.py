class SNPData:
    def __init__(self, id, chrom, pos, escFreq, glazFreq, absFreqDiff, countedA, altAllele, glazAllele, idmType, cM):
        self.id = id
        self.chrom = chrom
        self.pos = pos
        self.escFreq = escFreq
        self.glazFreq = glazFreq
        self.absFreqDiff = absFreqDiff
        self.countedA = countedA,
        self.altAllele = altAllele,
        self.glazAllele = glazAllele,
        self.idmType = idmType,
        self.cM = cM
    id = ""
    chrom = ""
    pos = ""
    escFreq = ""
    glazFreq = ""
    absFreqDiff = ""
    countedA = ""
    altAllele = ""
    glazAllele = ""
    idmType = ""
    cM = ""


snp_data = {}

with open("IDM_list_headerless.csv", "r") as f:
    for line in f:
        vals = line.strip('\n').split(',')
        #print(vals)
        snp_data[vals[0]] = SNPData(vals[0], vals[1], vals[2], vals[3], vals[4], vals[5], vals[6], vals[7], vals[8], vals[9], vals[10])


with open("IDMlist_all_v8uplifted.bed", "r") as t:
    for line in t:
        line = line.strip('\n')
        vals = line.split('\t')
        key = vals[3]
        snp_data[key].chrom = vals[0]
        snp_data[key].pos = str(int(vals[1])+1)
        obj = snp_data[key]
        new_line = str(obj.id) + ',' + str(obj.chrom) + ',' + str(obj.pos) + ',' + str(obj.escFreq) + ',' + str(obj.glazFreq) + ',' + str(obj.absFreqDiff) + ',' + str(obj.countedA[0]) + ',' + str(obj.altAllele[0]) + ',' + str(obj.glazAllele[0]) + ',' + str(obj.idmType[0]) + ',' + str(obj.cM)
        print(new_line)

