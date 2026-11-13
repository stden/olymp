import java.io.*;
import java.math.*;
import java.util.*;

public class btrees_ir {
    public static void main(String[] args) throws Exception {
        new btrees_ir().run();
    }

    int t;
    BigInteger[][][] cache;

    BigInteger calc(int n, int h, int k) {
        if (cache[n][h][k] != null) {
            return cache[n][h][k];
        }
        cache[n][h][k] = BigInteger.ZERO;
        if (k > 1) {
            for (int i = 1; i < n; i++) {
                cache[n][h][k] = cache[n][h][k].add(calc(n - i, h, k - 1).multiply(calc(i, h, 1)));
            }
            return cache[n][h][k];
        }
        if (h == 1) {
            if (n >= t - 1 && n <= 2 * t - 1) {
                cache[n][h][k] = BigInteger.ONE;
            }
            return cache[n][h][k];
        }
        for (int i = t; i <= 2 * t; i++) {
            cache[n][h][k] = cache[n][h][k].add(calc(n, h - 1, i));
        }
        return cache[n][h][k];
    }

    void run() throws Exception {
        Scanner in = new Scanner(new File("btrees.in"));
        int n = in.nextInt();
        t = in.nextInt();
        in.close();
        ArrayList<BigInteger> least = new ArrayList<BigInteger>();
        ArrayList<BigInteger> most = new ArrayList<BigInteger>();
        least.add(BigInteger.ONE);
        most.add(BigInteger.ONE);
        while (least.get(least.size() - 1).multiply(BigInteger.valueOf(t - 1)).compareTo(BigInteger.valueOf(n)) <= 0) {
            least.add(least.get(least.size() - 1).multiply(BigInteger.valueOf(t)));
            most.add(most.get(most.size() - 1).multiply(BigInteger.valueOf(2 * t)));
        }
        int maxHeight = least.size() - 1;
        if (maxHeight == 1) {
            PrintWriter out = new PrintWriter(new File("btrees.out"));
            if (n >= t - 1 && n <= 2 * t - 1) {
                out.println(1);
            }
            else {
                out.println(0);
            }
            out.close();
            return;
        }
        cache = new BigInteger[n + 1][maxHeight + 1][2 * t + 1];
        BigInteger ans = BigInteger.ZERO;
        for (int i = 1; i <= maxHeight; i++) {
            if (most.get(i - 1).multiply(BigInteger.valueOf(2 * t - 1)).compareTo(BigInteger.valueOf(n)) == -1) {
                continue;
            }
            ans = ans.add(calc(n, i, 1));
        }
        PrintWriter out = new PrintWriter(new File("btrees.out"));
        out.println(ans);
        out.close();
    }
}
