import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

public class Tests {

    Random random = new Random(666);
    int testNo = 0;

    public PrintWriter TestComments;

    final int signsInTestNumber = 2;

    public String format(int number) {
        String result = String.format("%d", number);
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < signsInTestNumber - result.length(); i ++) {
            stringBuilder.append("0");
        }
        stringBuilder.append(result);
        return stringBuilder.toString();
    }

    private int lastA;
    private int lastB;

    public class Test {
        public int a;
        public int b;

        public Test(int a, int b) {
            this.a = a;
            this.b = b;
        }

        public Test() {
        }

        Test ordered() {
            if (a > b) {
                return new Test(a, b);
            } else {
                return new Test(b, a);
            }
        }

        Test reversed() {
            return new Test(b, a);
        }
    }

    public Answer solve(Test test) {
        return new Answer(test.a / (test.b + 1),
                ((test.a + 1) % test.b == 0) ? ((test.a + 1) / test.b - 1) : ((test.a + 1)) / test.b);
    }

    public class Answer {
        public int min;
        public int max;

        public Answer(int min, int max) {
            this.min = min;
            this.max = max;
        }
    }

    public void printTest(Test test) {
        if (test == null) {
            return;
        }
        PrintWriter out = null;
        testNo ++;
        try {
            new File("../tests").mkdir();
            out = new PrintWriter("../tests/" + format(testNo));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return;
        }
        out.println(lastA = test.a);
        out.println(lastB = test.b);
        out.close();
    }

    public void Comment(String cmt) {
        Answer answer = solve(new Test(lastA, lastB));
        String comment = String.format("%s: a = %d, b = %d. %s; answer = (%d, %d)", format(testNo), lastA, lastB, cmt,
                answer.min, answer.max);
        System.err.println(comment);
        TestComments.println(comment);
    }

    public void processHandTests() throws IOException {
        ArrayList<String> handTests = new ArrayList<String>();
        for (File f: new File(".").listFiles()) {
            if (!f.isDirectory() && f.getName().endsWith(".hand")) {
                handTests.add(f.getName());
            }
        }
        Collections.sort(handTests);
        for (String fileName: handTests) {
            Scanner in = new Scanner(new File(fileName));
            int a = in.nextInt();
            int b = in.nextInt();
            printTest(new Test(a, b));
            Comment("hand test from " + fileName);
        }
    }

    public Test genRandomTest(int maxA, int maxB) {
        return genRandomTest(1, maxA, 1, maxB);
    }

    public Test genEqualTest(int min, int max) {
        int value = random.nextInt(max - min) + min;
        return new Test(value, value);
    }

    public Test genRandomTest(int minA, int maxA, int minB, int maxB) {
        int a = random.nextInt(maxA - minA) + minA;
        int b = random.nextInt(maxB - minB) + minB;
        return new Test(a, b).ordered();
    }

    public boolean isTrivial(Test test) {
        Answer answer = solve(test);
        return answer.max == answer.min;
    }

    private final int ITERATIONS = 1000;

    public Test genNonTrivialRandomTest(int minA, int maxA, int minB, int maxB) {
        Test test = null;
        for(int i = 0; i < ITERATIONS; i ++) {
            if (test != null && !isTrivial(test)) {
                break;
            }
            test = genRandomTest(minA, maxA, minB, maxB);
        }
        return test;
    }

    public Test genTrivialRandomTest(int minA, int maxA, int minB, int maxB) {
        Test test = null;
        for(int i = 0; i < ITERATIONS; i ++) {
            if (test != null && isTrivial(test)) {
                break;
            }
            test = genRandomTest(minA, maxA, minB, maxB);
        }
        return test;
    }

    public Test specialCase() {
        int b = random.nextInt(900) + 100;
        int c = random.nextInt(900) + 100;
        return new Test(b * c - 1, b);
    }

    public Test genBigSpecialTest   (int b) {
        int c = ((int)1e9) / b;
        return new Test(b * c - 1, b);
    }

    public void run() throws IOException {
        TestComments = new PrintWriter("testcomments.txt");

        processHandTests();
        //small tests
        for (int i = 0; i < 3; i ++) {
            printTest(genRandomTest(100, 100));
            Comment("small random test");
        }
        printTest(genRandomTest(100, 100).reversed());
        Comment("small reversed test");
        printTest(genEqualTest(1, 100));
        Comment("small equal test");
        for (int i = 0; i < 3; i ++) {
            printTest(genNonTrivialRandomTest(1, 100, 1, 100));
            Comment("small nontrivial random test");
        }
        printTest(genTrivialRandomTest(1, 100, 1, 100));
        Comment("small trivial random test");
        //average tests
        int N = (int)1e5;
        for (int i = 0; i < 3; i ++) {
            printTest(genRandomTest(N, N));
            Comment("average random test");
        }
        printTest(genRandomTest(N, N).reversed());
        Comment("average reversed test");
        printTest(genEqualTest(1, N));
        Comment("average equal test");
        for (int i = 0; i < 3; i ++) {
            printTest(genNonTrivialRandomTest(1, N, 1, N));
            Comment("average nontrivial random test");
        }
        printTest(genTrivialRandomTest(1, N, 1, N));
        Comment("average trivial random test");

        //big tests
        for (int i = 0; i < 3; i ++) {
            printTest(specialCase());
            Comment("special test");
        }
        N = (int)1e9;
        for (int i = 0; i < 3; i ++) {
            printTest(genRandomTest(N, N));
            Comment("large random test");
        }
        printTest(genRandomTest(N, N).reversed());
        Comment("large reversed test");
        printTest(genEqualTest(1, N));
        Comment("large equal test");
        printTest(genTrivialRandomTest(1, N, 1, N));
        Comment("large trivial random test");

        // tests big vs small:

        for (int i = 0; i < 5; i ++) {
            printTest(genRandomTest(N / 10, N, 100, 1000));
            Comment("large random test with big answer");
        }
        for (int i = 0; i < 3; i ++) {
            printTest(genRandomTest(N / 10, N, 10, 100));
            Comment("large random test with very big answer");
        }
        for (int i = 0; i < 3; i ++) {
            printTest(genRandomTest(N / 10, N, 1, 10));
            Comment("large random test with extremely big answer");
        }

        //max tests
        for (int i = 0; i < 2; i ++) {
            printTest(genBigSpecialTest(random.nextInt(10) + 5));
            Comment("max special test ");
        }

        int maxN = (int)1e9;
        printTest(new Test(1, maxN));
        Comment("max test");
        printTest(new Test(maxN, maxN));
        Comment("max test");
        printTest(new Test(maxN, 1));
        Comment("max test");
        printTest(new Test(maxN, maxN / 2));
        Comment("max test");
        printTest(new Test(maxN, maxN - 1));
        Comment("max test");
        TestComments.close();
    }


    public static void main(String[] args) throws IOException {
        Tests tests = new Tests();
        tests.run();
    }
}