import java.io.*;
import java.util.*;

public class Tests {
    int testNo = 0;

    PrintWriter TestComments;


    class Test {
       int n;
       int[] a;     
       Test(int... b){
           n = 0;
           for (int j:b)
              n++;
           a = b.clone();     
       }
    }

    Random rnd = new Random(239017);

    int lastn = -1;

    public void printTest(Test test) {
        if (test == null)
            return;
        testNo++;
        PrintWriter out = null;
        try {
            new File("../tests").mkdir();
            if (testNo >= 10)
                out = new PrintWriter("../tests/" + testNo / 10 + testNo % 10);
            else
                out = new PrintWriter("../tests/0"+testNo);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return;
        }

        int n = test.n;
        out.println(n);
        lastn = n;
        for (int i = 0; i < n; i++){
            out.print(test.a[i]);
            if (i == n-1)
                out.println();
            else
                out.print(" ");
        }
        out.close();
    }
    void handTests() throws IOException{

        for (File f: new File(".").listFiles()){
            if (f.isDirectory() || !f.getName().endsWith(".hand"))
                continue;
            Scanner in = new Scanner(f);
            Test test = new Test();
            test.n = in.nextInt();
            test.a = new int[test.n];
            for (int i = 0; i < test.n; i++){
                test.a[i] = in.nextInt();
            }
            printTest(test);
            in.close();
            Comment("Hand test "+f.getName());
        }
    }

    void sortedTest(int n,boolean type){
       Test test = new Test();
       test.n = n;
       test.a = new int[test.n];
       for (int i = 0; i < test.n; i++){
           if (type == false)
              test.a[i] = i+1;
           else
              test.a[i] = n-i;
       }

       printTest(test);
       Comment("Sorted " + (type?"up":"down"));
    }


    void shiftedTest(int n,int b,boolean type){
       Test test = new Test();
       test.n = n;
       test.a = new int[test.n];
       for (int i = 0; i < test.n; i++){
           if (type)
               test.a[i] = (i+b+1)%n;
           else
               test.a[i] = (n-i+b)%n;
           if (test.a[i] == 0)
              test.a[i] = n;
       }

       printTest(test);
       Comment("Sorted "+ (type?"up":"down")+" shifted by "+b);
    }


    void randomTest(int n){
       Test test = new Test();
       test.n = n;
       test.a = new int[test.n];
       for (int i = 0; i < test.n; i++){
           int id = rnd.nextInt(i+1);
           test.a[i] = i+1;
           int t = test.a[id];
           test.a[id] = i+1;
           test.a[i] = t;
       }                 
       printTest(test);
       Comment("Random test");
    }

    Test genMaxTest(int n){
       Test test = new Test();
       test.n = n;
       test.a = new int[test.n];

       for (int i = 0; i < n; i++){
           if (i % 2 == 0)
             test.a[i] = n/2 + i/2 + 1;
           else
             test.a[i] = n/2 - (i+1)/2 + 1;
       }        

       int t = test.a[1];
       test.a[1] = test.a[0];
       test.a[0] = t;
       return test;
    }

    void maxTest(int n){
       printTest(genMaxTest(n));    
       Comment("Test with N-2 swaps");
    }


    void maxTestWithNoise(int n){
       Test test = genMaxTest(n);
       for (int i = 0; i < 10; i++){
           int x = rnd.nextInt(n);
           int y = rnd.nextInt(n);
           int t = test.a[x];
           test.a[x] = test.a[y];
           test.a[y] = t;
       }                     
       printTest(test);    
       Comment("Test with N-2 swaps with some noise");
    }



    void Comment(String comment){
        System.err.printf("%02d - %s (N = %d)\r\n",testNo, comment, lastn);
        TestComments.printf("%02d - %s (N = %d)\r\n",testNo, comment, lastn);
    }


    void run() throws IOException{
        TestComments = new PrintWriter("testcomments.txt");
        handTests();
        sortedTest(3,true);
        sortedTest(3,false);
        sortedTest(10,true);
        sortedTest(10,false);
        sortedTest(1000,true);
        sortedTest(1000,false);

        randomTest(10);
        for (int i = 0; i < 10; i++)
            randomTest(1000);

        maxTest(4);
        maxTest(100);
        maxTest(1000);
        maxTestWithNoise(100);
        maxTestWithNoise(1000);

        shiftedTest(10,5,true);
        shiftedTest(1000,500,true);
        shiftedTest(10,5,false);
        shiftedTest(1000,500,false);
        shiftedTest(1000,rnd.nextInt(999)+1,true);
        shiftedTest(1000,rnd.nextInt(999)+1,false);

        TestComments.close();  
    }


    public static void main(String[] args) {
        try{
            new Tests().run();   
        } catch (Exception e){
            e.printStackTrace();
            System.exit(239);
        }
    }
}

