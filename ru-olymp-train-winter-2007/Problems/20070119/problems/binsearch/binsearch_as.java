import java.util.*;
import java.io.*;

public class binsearch_as {
    int[][][] alies;
    boolean[][][] ulies;

    int truth(int n) {
        int r = 0;
        while (n > 1) {
            n = (n + 1) / 2;
            r++;
        }
        return r + 1;
    }

    int lies(int n, int l, int r) {
        if (r < 0) {
            return truth(n - l);
        }
        if (l > n) {
            return truth(r);
        }
        if (ulies[n][l][r]) {
            return alies[n][l][r];
        }
        ulies[n][l][r] = true;

        if (n == 1) {
            return alies[n][l][r] = 0;
        }

        int best = 3 * n;
        int besti = 0;
        boolean answergt = false;
        for (int i = 1; i < n; i++) {
            int ale = 0, agt = 0;
            if (l <= i && i <= r) {
                ale = lies(r, l, i);
                agt = lies(n - l + 1, i - l + 2, r - l + 1);
            } else if (i <= l && i <= r) {
                ale = lies(r, l, i);
                agt = lies(n - i, l - i, r - i);
            } else if (i >= l && i >= r) {
                ale = lies(i, l, r);
                agt = lies(n - l, i - l, r - l);
            } else if (r <= i && i <= l) {
                ale = truth(r);
                agt = truth(n - l);
            } else {
                System.out.println("?!! " + n + " " + l + " " + r + " " + i);
                throw new RuntimeException();
            }
            int worst = Math.max(ale, agt) + 1;
            if (worst < best) {
                best = worst;
                besti = i;
                if (agt > ale) {
                    answergt = true;
                } else {
                    answergt = false;
                }
            }
        }

        if (false && n == 77) {
        System.out.printf("[%d, %d, %d] = %d (at %d, %s)\n", n, l, r, best, besti,
                answergt ? "gt" : "le"
        );
        }

        return alies[n][l][r] = best;
    }

    public void run() throws IOException {
        Scanner in = new Scanner(new File("binsearch.in"));
        int n = in.nextInt() + 1;
        in.close();

        alies = new int[n + 1][n + 1][n + 1];
        ulies = new boolean[n + 1][n + 1][n + 1];
        atruth = new int[n + 1];
        utruth = new boolean[n + 1];
        int answer = lies(n, 0, n);

        PrintWriter out = new PrintWriter(new File("binsearch.out"));
        System.out.println(answer);
        out.println(answer);
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new binsearch_as().run();
    }
}
