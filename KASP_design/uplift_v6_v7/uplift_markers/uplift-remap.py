class SNPData:
    def __init__(self, id, chrom, pos, Intk_ID, TYPE):
        self.id = id
        self.chrom = chrom
        self.pos = pos
        self.Intk_ID = Intk_ID
        self.TYPE = TYPE
    id = ""
    chrom = ""
    pos = ""
    Intk_ID = ""
    TYPE = ""


snp_data = {}

with open("all_markers_to-up_headless.csv", "r") as f:
    for line in f:
        vals = line.strip('\n').split(',')
        #print(vals)
        snp_data[vals[0]] = SNPData(vals[0], vals[1], vals[2], vals[3], vals[4])


with open("all_markers_uplifted.bed", "r") as t:
    for line in t:
        line = line.strip('\n')
        vals = line.split('\t')
        key = vals[3]
        snp_data[key].chrom = vals[0]
        snp_data[key].pos = str(int(vals[1])+1)
        obj = snp_data[key]
        new_line = str(obj.id) + ',' + str(obj.chrom) + ',' + str(obj.pos) + ',' + str(obj.Intk_ID) + ',' + str(obj.TYPE)
        print(new_line)

