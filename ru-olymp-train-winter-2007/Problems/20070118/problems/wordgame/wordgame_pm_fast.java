import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.math.BigInteger;

public class wordgame_pm_fast {
    final String TASK_ID = "wordgame";
    final String IN_FILE = TASK_ID + ".in";
    final String OUT_FILE = TASK_ID + ".out";


    static class KMPMatcher {
        String needle;
        int[] phi;

        public KMPMatcher(String needle) {
            this.needle = needle;
            phi = new int[needle.length() + 1];
            phi[0] = 0;
            phi[1] = 0;
            for (int i = 2; i <= needle.length(); ++i) {
                phi[i] = iterate(phi[i - 1], needle.charAt(i - 1));
            }
        }

        public int iterate(int state, char ch) {
            int j = state;
            if (j == needle.length())
                j = phi[j];

            while (true) {
                if (needle.charAt(j) == ch) {
                    ++j;
                    break;
                }
                if (j == 0) break;
                j = phi[j];
            }
            return j;
        }
    }


    public static void main(String[] args) throws FileNotFoundException {
        new wordgame_pm_fast().run();
    }


    private void run() throws FileNotFoundException {
        Scanner scanner = new Scanner(new File(IN_FILE));
        PrintWriter writer = new PrintWriter(OUT_FILE);

/*        int base = maxCh - minCh + 1;
        int[] p = new int[10];
        p[0] = 1;
        for (int i = 1; i < p.length; ++i)
            p[i] = base * p[i - 1];

        for (int len = 1; len <= 5; ++len) {
            BigInteger sum = BigInteger.ZERO;
            for (int state = 0; state < p[len]; ++state) {
                String s = "";
                int cur = state;
                for (int i = 0; i < len; ++i) {
                    s += (char) ('a' + cur % base);
                    cur /= base;
                }
                sum = sum.add(count(s, 1));
            }
            writer.println(sum.doubleValue() / p[len]);
        }
        writer.println();*/

        while (true) {
            if (!scanner.hasNext())
                break;
            int numChars = scanner.nextInt();
            if (numChars == 0)
                break;
            int num = scanner.nextInt();
            String s = scanner.next();

            BigInteger answer = count(s, num, 'a', (char) ('a' + numChars - 1));

            writer.println(/*s + " - " + */answer + ".000000");
        }

        writer.close();
    }

    private BigInteger count(String s, int num, char minCh, char maxCh) {
        KMPMatcher m = new KMPMatcher(s);
        int n = s.length();
        int base = maxCh - minCh + 1;

        BigInteger res = BigInteger.ZERO;

        int i = n;

        while (i > 0) {
            res = res.add(BigInteger.valueOf(base).pow(i));
            i = m.phi[i];
        }

        res = res.add(BigInteger.valueOf(num - 1).multiply(BigInteger.valueOf(base).pow(n)));

        return res;
    }
}
