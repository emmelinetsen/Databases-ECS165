import csv

ofile = open('Bridge.sql', 'w')
ifile = open('165 - both have.csv', "rb")
reader = csv.reader(ifile)
rownum = 0

for row in reader:
        # Save header row
        if rownum == 0:
                header = row
        else:
                colnum = 0
                for col in row:
                        ofile.write('insert into BridgeTable values(\'\', \''+row[0]+'\');\n')

                        colnum += 1

        rownum += 1
ifile.close()
ofile.close()

