The main development environment we used was Linux (Ubuntu).
1) Download Hadoop1.1.1 (URL --> https://archive.apache.org/dist/hadoop/core/hadoop-1.1.1/hadoop-1.1.1-bin.tar.gz) and set up environment variables similar to those found in the tutorials.

2) cd inside the hadoop1.1.1 folder

To run to WordCount example from the tutorial using the WordCount.java source code found in the src/examples folder from hadoop-1.2.1: 

javac -classpath hadoop-core-1.1.1.jar:lib/commons-cli-1.2.jar -d wordcount_classes WordCount.java

Note: The "lib/commons-cli-1.2.jar" keeps the compiler from throwing an error about a missing dependency.

3) create the jar using: 

jar -cvf wordcount.jar -C wordcount_classes/ .

4)  To run Hadoop with the SOPA.htm file in the input folder: 
bin/hadoop jar wordcount.jar org.myorg.WordCount input output


------
Running BigramCounter is very similar to running WordCount
(Current directory is the Hadoop folder)

3) Compile with the following command: 

javac -classpath hadoop-core-1.1.1.jar:lib/commons-cli-1.2.jar -d bigramcounter_classes BigramCounter.java

4) Create the jar with the following command:
jar -cvf BigramCounter.jar -C bigramcounter_classes/ .

5) Run hadoop with the following command: 
bin/hadoop jar BigramCounter.jar BigramCounter input output
