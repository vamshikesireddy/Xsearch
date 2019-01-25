import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StoredField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.QueryBuilder;

import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class Code {


    private Analyzer analyzer;
    private RAMDirectory directory;
    private IndexWriterConfig config;
    private IndexWriter iwriter;
    private DirectoryReader ireader;
    private IndexSearcher isearcher;
    private QueryBuilder builder;
    private RandomAccessFile in,in1;
    private ArrayList<String> inputFiles;
    private ArrayList<Document> documents;
    private String line;
    private long start, end;
    private long searchTimeInSec;
    private float searchTime;
    //private FSDirectory dir,dir1;
    private int num;
    private  ArrayList<ScoreDoc[]> a;
    private ArrayList<Directory> sample;
    private int n;
    private int count=0;
    private int files;
    private float fileSize,indexSize,indexTime;

    class Multi_Threading implements Runnable{

        String input;
        public Multi_Threading(String input) {
            this.input = input;
        }

        @Override
        public void run() {
            try {
                File file = new File(input);
                Document document = new Document();

                Field contentField;
                FileInputStream fis = new FileInputStream(file);
                contentField = new Field("content", new InputStreamReader(fis),
                        TextField.TYPE_NOT_STORED);

                Field filenameField = new Field("filename", file.getName(), StoredField.TYPE);
                Field filepathField = new Field("filepath", file.getCanonicalPath(), StoredField.TYPE);

                document.add(contentField);
                document.add(filenameField);
                document.add(filepathField);
                iwriter.addDocument(document);
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void indexing(RandomAccessFile in,int threads){
        try {

            indexTime = 0;
            indexSize = 0;

            // use the standard text analyzer
            analyzer = new StandardAnalyzer();
            //Using Simple analyzer has decreased the index time.
            //analyzer = new SimpleAnalyzer();
            // store the index in main memory (RAM)
            directory = new RAMDirectory();


            // create and index writer
            config = new IndexWriterConfig(analyzer);
            //-------------Tuning IndexWriterConfig Parameters---------------------------
            // Create a new index in the directory, removing any previously indexed documents:
            config.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
            config.setMaxBufferedDocs(5000);
            config.setRAMBufferSizeMB(190000);
            config.setUseCompoundFile(false);
            config.setCommitOnClose(false);
            LogMergePolicy mergePolicy = new LogByteSizeMergePolicy();
            mergePolicy.setMaxMergeDocs(300);
            config.setMergePolicy(mergePolicy);
            config.setReaderPooling(IndexWriterConfig.DEFAULT_READER_POOLING);
            //config.setCodec();
            iwriter = new IndexWriter(directory,config);


            // read the file paths from the input file
            inputFiles = new ArrayList<String>();



            while ((line = in.readLine()) != null ) {
                inputFiles.add(line);
            }


            Scanner scanner = new Scanner(System.in);
            System.out.println("Total Number of documents ready to be indexed:"+inputFiles.size());
            System.out.println("Enter number of files to be indexed:");
            files = scanner.nextInt();
            fileSize = files*4;
            while(files>inputFiles.size()){
                System.out.println("Enter correct number of files with in range");
                System.out.println("Enter number of files to be indexed:");
                files = scanner.nextInt();
            }

            //design change
            ExecutorService executor = Executors.newFixedThreadPool(threads);
            start = System.currentTimeMillis();


            for(String inputFile : inputFiles.subList(0,files)){

                executor.submit(new Multi_Threading(inputFile));
            }


            executor.shutdown();

            try {
                executor.awaitTermination(1, TimeUnit.DAYS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            end = System.currentTimeMillis();

            //No of documents indexed
            num = iwriter.maxDoc();
            System.out.println("Number of documents indexed: "+num);

            iwriter.commit();
            iwriter.close();


            // calculate the time taken to index the files
            indexTime = (end - start);

            // get the total size of the index
            indexSize = directory.ramBytesUsed()/1000;
            System.out.println("IndexTime: " + indexTime + " ms");
            System.out.println("IndexSize: " + indexSize + " KB | " +indexSize/1000+" MB");
            System.out.println("File size:"+fileSize+" MB");
            System.out.println("Index ThroughPut:"+(fileSize)/(indexTime/1000)+" MB/sec");
            in.close();
        }catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void indexSearch(RandomAccessFile in1) {
        try {

            // create an index reader
            ireader = DirectoryReader.open(directory);
            builder = new QueryBuilder(analyzer);
            isearcher = new IndexSearcher(ireader);
            //isearcher.setSimilarity(new customSimilarity());

            // read the terms from the second input file and search the index
            //in = new RandomAccessFile("/Users/vamshi/Desktop/Java/Data/terms.dat", "r");

            //Creating a dynamic array list to store hits.
            a = new ArrayList<>();
            ScoreDoc[] hits = new ScoreDoc[0];
            start = System.currentTimeMillis();
            while ((line = in1.readLine()) != null) {

                Query query = builder.createBooleanQuery("content", line);
                hits = isearcher.search(query, 1000).scoreDocs;
                /*if (hits.length < 1) {
                    System.out.println("Incorrect search result!");
                }*/
                a.add(hits);
                count++;

            }

            end = System.currentTimeMillis();
            searchTime = (end - start);
            //count++;
            System.out.println("SearchTime of query: " + searchTime + " ms");
            System.out.println("Query Throughput: "+searchTime/count+ " ms/query");
            /*System.out.println(a.get(3).length);
            System.out.println(a.get(3));
            System.out.println(a.get(3)[1].doc);
            System.out.println(a.get(0)[0].score);*/

            //To Extract the filename,score and filepath for matched query
            /*for(int i=0;i<a.size();i++) {
                for (int j = 0; j < a.get(i).length; j++) {
                    Document hit = isearcher.doc(a.get(i)[j].doc);
                    System.out.println("Filename: "+hit.get("filename")+" | Score: "+a.get(i)[j].score+" | FilePath: "+hit.get("filepath"));
                }
                System.out.println("-----------------------------------------------------------------------------------------------");
            }*/

            // calculate the time it took to search the term

            in1.close();
            ireader.close();
            directory.close();


        }catch (IOException e) {
            e.printStackTrace();
        }
    }
}
