import java.io.*;
import java.util.*;

public class Tests {
    int testNo = 0;

    PrintWriter TestComments;


    class Test {
        int n;
        int w,h;
        int[] a;
        int[] b;

        Test(int w,int h, int[] a,int[] b) {
            this.n = a.length;
            assert(this.n == b.length);
            this.w = w;
            this.h = h;
            this.a = a.clone();
            this.b = b.clone();
        }
        Test(){
            n = w = h = 0;
            a = b = null;
        }

        Test shuffle(){
            for (int i = 0; i < n; i++){
                int id = rnd.nextInt(i+1);
                int t = a[i];
                a[i] = a[id];
                a[id] = t;
                t = b[i];
                b[i] = b[id];
                b[id] = t;
            }
            return this;                
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

        lastn = test.n;
        out.println(test.n+" "+test.w+" "+test.h);
        for (int i = 0; i < test.n; i++)
           out.println(test.a[i]+" "+test.b[i]);
        out.close(); 
    }

    final static int MAXC = 1000000000;

    void Comment(String comment){
        System.err.printf("%02d - %s (N = %d)\r\n",testNo, comment, lastn);
        TestComments.printf("%02d - %s (N = %d)\r\n",testNo, comment, lastn);
    }

    Test RandomTest(int n,int MAXC,int proba,int prob){
        int w = rnd.nextInt(this.MAXC)+1;
        int h = rnd.nextInt(this.MAXC)+1;
        int[] a = new int[n];
        int[] b = new int[n];
        for (int i = 0; i < n; i++){
            a[i] = rnd.nextInt(MAXC)+1;
            if (i != 0 && proba != 0 && rnd.nextInt(proba) <= prob)
                b[i] = b[i-1];
            else
                b[i] = rnd.nextInt(MAXC)+1;
        }
        return new Test(w,h,a,b);
    }

    void handTests() throws IOException{

        for (File f: new File(".").listFiles()){
            if (f.isDirectory() || !f.getName().endsWith(".hand"))
                continue;
            Scanner in = new Scanner(f);
            Test test = new Test();
            test.n = in.nextInt();
            test.w = in.nextInt();
            test.h = in.nextInt();
            test.a = new int[test.n];
            test.b = new int[test.n];
            for (int i = 0; i < test.n; i++){
                test.a[i] = in.nextInt();
                test.b[i] = in.nextInt();
            }
            printTest(test);
            in.close();
            Comment("Hand test "+f.getName());
        }
    }


    void run() throws IOException{
        TestComments = new PrintWriter("testcomments.txt");              
        handTests();
        printTest(RandomTest(10,10,0,0));
        Comment("small random test");
        printTest(RandomTest(10,10,1,0));
        Comment("small random test");
        printTest(RandomTest(1000,1000,5,0));
        Comment("random test");
        printTest(RandomTest(100000,10,10,0));
        Comment("random test with small words");
        printTest(RandomTest(100000,MAXC/1000,1,0));
        Comment("random test with all equal h");              
        for (int i = 0; i <= 5; i++){
            printTest(RandomTest(rnd.nextInt(10000)+90000,MAXC/1000,i,0));   
            Comment("big random test");
        }
        for (int i = 0; i <= 3; i++){  
            printTest(RandomTest(rnd.nextInt(10000)+90000,MAXC/1000,100,98));
            Comment("big random test with many equal h in a row");
            printTest(RandomTest(rnd.nextInt(10000)+90000,MAXC/1000,50,48).shuffle());
            Comment("big random test with many equal h not in a raw");
        }
        for (int i = 0; i <= 3; i++){
            printTest(RandomTest(100000,MAXC,0,0));
            Comment("fully random max test");
        }
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

