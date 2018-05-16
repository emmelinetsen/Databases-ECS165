import csv

ofile = open('hw5_load.sql', 'a')
ifile = open('gm-pop.csv', "rb")
reader = csv.reader(ifile)

rownum = 0
for row in reader:
        # Save header row
        if rownum == 0:
                header = row
        else:
                colnum = 0
                for col in row:
                        data = col
                        if (col == "" or col == "-"):
                                data = "NULL"
                        if (colnum != 0):

                                ofile.write('insert into POPULATION values(\''+row[0].replace("'","''")+'\', %s, %s);\n' % (header[colnum],data))
                        colnum += 1

        rownum += 1
ifile.close()
ofile.close()
