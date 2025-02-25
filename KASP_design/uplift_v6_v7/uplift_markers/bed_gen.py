import csv

snp_data = {}

with open("IDM_list.csv", "r") as f:
    for line in f:
        vals = line.split(',')
        thing = str(vals[1]) + "\t" + str(int(vals[2])-1) + "\t" + str(int(vals[2])) + "\t" + str(vals[0])
        
        print(thing)
    
