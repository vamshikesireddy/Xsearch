#include <iostream>
#include <fstream>
#include <string>
#include <thread>
#include <exception>
#include <LuceneHeaders.h>
#include <ConcurrentMergeScheduler.h>
#include <FileUtils.h>
#include <MiscUtils.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <boost/asio/io_service.hpp>
#include <boost/bind.hpp>
#include <boost/thread/thread.hpp>
#include <boost/smart_ptr/scoped_ptr.hpp>
#include <mutex>

extern "C"
{
    #include <string.h>
    #include <sys/time.h>
}

#define NUM_THREADS boost::thread::hardware_concurrency()

std::mutex count_mutex;
using namespace std;
using namespace Lucene;

/*void parallel_index(int tid, int num_threads, IndexWriterPtr iwriter, 
        vector<DocumentPtr> documents)
{
    cout << "inside parallel index function " << endl;
    for (int i=0; i < documents.size(); i++) {
        iwriter->addDocument(documents[tid]);
    }
    //vector<DocumentPtr>().swap(documents);

}*/
/*void parallel_index(IndexWriterPtr iwriter,DocumentPtr document)
{
  try{
      iwriter->addDocument(document);
      iwriter->commit();
      cout << "In thread";
      return;
    }catch(LuceneException& e) {
  wcout << e.getError() << endl;
}
}*/
void parallel_index(int tid, int num_threads, IndexWriterPtr iwriter, 
        vector<DocumentPtr> documents)
{
  int start =0;
  int end = documents.size()/num_threads;
  int batch = end;
  for(int i=1;i<=tid;i++){
      start += batch;
      end += batch;
    }
 
    for (int i=start; i < end; i++) {
        iwriter->addDocument(documents[i]);
    }
}

int main(int argc, char **argv)
{

    AnalyzerPtr analyzer;
    RAMDirectoryPtr directory;
    IndexWriterPtr iwriter;
    IndexReaderPtr ireader;
    IndexSearcherPtr isearcher;
    QueryParserPtr parser;
    ifstream in;
    vector<string> inputFiles;
    vector<DocumentPtr> documents;
    struct timeval start, end;
    long indexTime, indexSize, searchTime;
    //long* indexTime_ptr = &indexTime;
    ConcurrentMergeSchedulerPtr scheduler;
    vector<thread> threads;
    int* pointer_int;
    indexTime = 0;
    indexSize = 0;
    searchTime = 0;
    float indexThroughput;
    //int count=0;
    
    try {
       // use the standard text analyzer
        analyzer = newLucene<StandardAnalyzer>(LuceneVersion::LUCENE_CURRENT);

        //use the simple text analyzer
        //analyzer = newLucene<SimpleAnalyzer>();

        // store the index in main memory (RAM)
        directory = newLucene<RAMDirectory>();

        // create index writer
        iwriter = newLucene<IndexWriter>(directory, analyzer, true,
        IndexWriter::MaxFieldLengthUNLIMITED);

        scheduler = boost::static_pointer_cast<ConcurrentMergeScheduler>(
          iwriter->getMergeScheduler());

        scheduler->setMaxThreadCount(NUM_THREADS);
         iwriter->setMergeScheduler(scheduler);

  
  std::string line;
  char filename[1024];
  int count = 1000;
  //std::vector<std::string> myLines;
  std::ifstream myfile(argv[1], ifstream::in);
  documents = vector<DocumentPtr>();
  while (std::getline(myfile, line))
  {
    
    if(count>1){
    DocumentPtr document = newLucene<Document>();

     strcpy(filename, line.c_str());
     cout << "filepath: " << filename << endl;

     String sourceFile(StringUtils::toUnicode(filename));

      document->add(newLucene<Field>(L"content",
        newLucene<FileReader>(sourceFile)));

      document->add(newLucene<Field>(L"filepath", sourceFile,
        Field::STORE_YES, Field::INDEX_NOT_ANALYZED));


     documents.push_back(document);
     //count_mutex.lock();
     count--;
     //count_mutex.unlock();
          
     }else{
      
      DocumentPtr document = newLucene<Document>();

     strcpy(filename, line.c_str());
     cout << "filepath: " << filename << endl;

     String sourceFile(StringUtils::toUnicode(filename));

      document->add(newLucene<Field>(L"content",
        newLucene<FileReader>(sourceFile)));

      document->add(newLucene<Field>(L"filepath", sourceFile,
        Field::STORE_YES, Field::INDEX_NOT_ANALYZED));


     documents.push_back(document);
      //count_mutex.lock();
      count  =  1000;
      gettimeofday(&start, NULL);
      //count_mutex.unlock();
      for (int tid = 0; tid < NUM_THREADS; tid++) {
          threads.push_back(thread(parallel_index, tid, NUM_THREADS, 
            iwriter, documents));
      }
      for (auto& th : threads) {
          th.join();
      } 
      iwriter->commit();
      gettimeofday(&end, NULL);
              // calculate the time taken to index the files
     indexTime += (((long) end.tv_sec - (long) start.tv_sec)
                * 1000000 + (end.tv_usec - start.tv_usec)) / 1000;
                line.clear();
      documents.clear();
      threads.clear();
      //cout << "Cutte";   
     }
     
     
   }

   gettimeofday(&start, NULL);
   if(count>0){
   
      //count_mutex.unlock();
      for (int tid = 0; tid < NUM_THREADS; tid++) {
          threads.push_back(thread(parallel_index, tid, NUM_THREADS, 
            iwriter, documents));
      }
      for (auto& th : threads) {
          th.join();
      } 
      
     iwriter->commit();
      //cout << "Cutte";   
     }
     gettimeofday(&end, NULL);
              // calculate the time taken to index the files
     indexTime += (((long) end.tv_sec - (long) start.tv_sec)
                * 1000000 + (end.tv_usec - start.tv_usec)) / 1000;
                line.clear();

      documents.clear();
      threads.clear();
     
     
         myfile.close();
         //ioService.stop();



indexSize = directory->sizeInBytes() / 1000;

iwriter->close();

// create an index reader
ireader = IndexReader::open(directory);
isearcher = newLucene<IndexSearcher>(ireader);
parser = newLucene<QueryParser>(LuceneVersion::LUCENE_CURRENT,
        L"content", analyzer);

// read the terms from the second input file and search the index
in.open(argv[2], ifstream::in);
gettimeofday(&start, NULL);
while(in.good()) {
    char word[1024];

    in.getline(word, 1024);
    if (strlen(word) <= 0) {
        break;
    }
        cout << "Searching Term: " << word << endl;

    String term(StringUtils::toUnicode(word));
    QueryPtr query = parser->parse(term);

    Collection<ScoreDocPtr> hits = isearcher->search(
            query, 1000)->scoreDocs;
                cout << "Hints Size After Searching (File Count): " << hits.size() << endl;
}
in.close();
gettimeofday(&end, NULL);
isearcher->close();
directory->close();

// calculate the time it took to search all the terms
searchTime += (((long) end.tv_sec - (long) start.tv_sec)
        * 1000000 + (end.tv_usec - start.tv_usec)) / 1000;
} catch(LuceneException& e) {
wcout << e.getError() << endl;
} catch(std::runtime_error& e) {
cout << e.what() << endl;
}
ireader->close();

cout << "IndexTime: " << indexTime << " ms" << endl;
cout << "Index Throughput: " << indexThroughput << " MB/ms" << endl;
cout << "IndexSize: " << indexSize << " kB" << endl;
cout << "SearchTime: " << searchTime << " ms" << endl;


return 0;
}
