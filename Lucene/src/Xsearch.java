import java.io.FileNotFoundException;
import java.io.RandomAccessFile;
import java.util.Scanner;

public class Xsearch {


    public static void main(String args[]){

        RandomAccessFile inputFiles = null;
        RandomAccessFile query = null;


        int threads;
        //RandomAccessFile in = null;
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of threads:");
        threads = scanner.nextInt();

        Code c = new Code();
        try {
            inputFiles = new RandomAccessFile(args[0], "r");
            query = new RandomAccessFile(args[1], "r");

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        c.indexing(inputFiles,threads);
        c.indexSearch(query);


        System.exit(0);
    }
}
