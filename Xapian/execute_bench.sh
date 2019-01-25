echo "Running for meta data dumps"

date 
echo "################# STARTED RUNNING FOR 1000 files ##############"

echo "Running  with 2 threads, 1000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 2 1000 /home/cc/Xsearch_Xapian/Metadata/terms1.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T2_1000_50.txt

sleep 5
 
echo "Running  with 4 threads, 1000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 4 1000 /home/cc/Xsearch_Xapian/Metadata/terms2.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T4_1000_250.txt

sleep 5

echo "Running  with 6 threads, 1000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 6 1000 /home/cc/Xsearch_Xapian/Metadata/terms3.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T6_1000_500.txt 
 
 sleep 5
 
echo "Running  with 12 threads, 1000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 12 1000 /home/cc/Xsearch_Xapian/Metadata/terms4.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T12_1000_750.txt

sleep 5

echo "Running  with 24 threads, 1000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 24 1000 /home/cc/Xsearch_Xapian/Metadata/terms5.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T24_1000_1000.txt
date
echo "################# COMPLETED RUNNING FOR 1000 files ##############"

sleep 5

echo "################# STARTED RUNNING FOR 10000 files ##############"
date
echo "Running  with 2 threads, 10000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 2 10000 /home/cc/Xsearch_Xapian/Metadata/terms1.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T2_10000_50.txt

sleep 5
 
echo "Running  with 4 threads, 10000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 4 10000 /home/cc/Xsearch_Xapian/Metadata/terms2.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T4_10000_250.txt

sleep 5

echo "Running  with 6 threads, 10000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 6 10000 /home/cc/Xsearch_Xapian/Metadata/terms3.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T6_10000_500.txt 
 
sleep 5
 
echo "Running  with 12 threads, 10000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 12 10000 /home/cc/Xsearch_Xapian/Metadata/terms4.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T12_10000_750.txt

sleep 5

echo "Running  with 24 threads, 10000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 24 10000 /home/cc/Xsearch_Xapian/Metadata/terms5.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T24_10000_1000.txt

date
echo "################# COMPLETED RUNNING FOR 10000 files ##############"

sleep 5
echo "################# STARTED RUNNING FOR 20000 files ##############"
date
echo "Running  with 2 threads, 20000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 2 20000 /home/cc/Xsearch_Xapian/Metadata/terms1.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T2_20000_50.txt

 sleep 5
 
echo "Running  with 4 threads, 20000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 4 20000 /home/cc/Xsearch_Xapian/Metadata/terms2.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T4_20000_250.txt

sleep 5

echo "Running  with 6 threads, 20000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 6 20000 /home/cc/Xsearch_Xapian/Metadata/terms3.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T6_20000_250.txt 
 
sleep 5
 
echo "Running  with 12 threads, 20000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 12 20000 /home/cc/Xsearch_Xapian/Metadata/terms4.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T12_20000_250.txt

sleep 5

echo "Running  with 24 threads, 20000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 24 20000 /home/cc/Xsearch_Xapian/Metadata/terms5.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T24_20000_250.txt

date
echo "################# COMPLETED RUNNING FOR 20000 files ##############"

sleep 5

echo "################# STARTED RUNNING FOR 30000 files ##############"
date
echo "Running  with 2 threads, 30000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 2 30000 /home/cc/Xsearch_Xapian/Metadata/terms1.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T2_30000_250.txt

sleep 5
 
echo "Running  with 4 threads, 30000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 4 30000 /home/cc/Xsearch_Xapian/Metadata/terms2.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T4_30000_250.txt

sleep 5

echo "Running  with 6 threads, 30000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 6 30000 /home/cc/Xsearch_Xapian/Metadata/terms3.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T6_30000_250.txt 
 
sleep 5
 
echo "Running  with 12 threads, 30000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 12 30000 /home/cc/Xsearch_Xapian/Metadata/terms4.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T12_30000_250.txt

sleep 5

echo "Running  with 24 threads, 30000 files, 250 queries "
time java -Djava.library.path=built -classpath .:built/xapian.jar:docs/examples/ SimpleIndex /home/cc/METADATA_DUMP/input_file.dat 24 30000 /home/cc/Xsearch_Xapian/Metadata/terms5.dat >> /home/cc/Xsearch_Xapian/xapian-bindings-1.4.9/java/benchmarking/T24_30000_250.txt

date
echo "################# COMPLETED RUNNING FOR 30000 files ##############"

