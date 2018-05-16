To run load script:
python run.py

scripts provided:
run.py
load_pop.py
load_electricity.py
load_health_spending.py
load_le.py
load_income.py


In order to read the csv files provided, we imported the CSV module within Python. The module's purpose was to allow us to deal with the csv formatted file. The reader function takes each line of the file and makes a list containing all the line's columns and was used to read the data from the csv files. Therefore, our script reads the CSV file and uses its contents to create separate insert statements for each of the sets of data provided. The insert statement output is appended into the hw5_load.sql file in order to have all the insert statements within one .sql while being able to run separate .py scripts to load the CSV files.

Therefore, in order to run the scripts, each of the above python files (for example, 'python load_pop.py' would run the load script for the population CSV file)would need to be run once. After running all five load python files, the hw5_load.sql file would contain the insert statements for all five CSV files. However, we have provided a script (run.py) that runs all the python scripts at once.

