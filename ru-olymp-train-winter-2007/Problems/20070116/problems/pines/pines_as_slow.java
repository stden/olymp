import java.util.*;
import java.io.*;
import java.math.BigInteger;

public class pines_as_slow {
    public void run() throws IOException {
        Scanner in = new Scanner(new File("pines.in"));
        PrintWriter out = new PrintWriter(new File("pines.out"));
        int n = in.nextInt();

        BigInteger[][][] f = new BigInteger[2 * n + 1][n][2];
        for (int j = 0; j < 2 * n + 1; j++) {
            for (int k = 0; k < n; k++) {
                for (int l = 0; l < 2; l++) {
                    f[j][k][l] = BigInteger.ZERO;
                }
            }
        }
        f[0][0][0] = BigInteger.ONE;

        BigInteger[][] tn = new BigInteger[n + 1][n + 1];
        for (int i = 0; i < n + 1; i++) {
            for (int j = 0; j < n + 1; j++) {
               tn[i][j] = BigInteger.ZERO;
            }
        }
        tn[1][1] = BigInteger.ONE;
        for (int i = 1; i <= 2 * n - 2; i++) {
            BigInteger[][][] g = f;
            f = new BigInteger[2 * n + 1][n][2];
            for (int j = 0; j < 2 * n + 1; j++) {
                for (int k = 0; k < n; k++) {
                    for (int l = 0; l < 2; l++) {
                        f[j][k][l] = BigInteger.ZERO;
                    }
                }
            }

            for (int j = 0; j <= i; j++) {
                for (int k = 0; k < i && k < n; k++) {
                    if (j > 0) {
                        f[j][k][0] = f[j][k][0].add(g[j - 1][k][0]).add(g[j - 1][k][1]);
                    }
                    if (j < i) {
                        if (k > 0) {
                            f[j][k][1] = f[j][k][1].add(g[j + 1][k - 1][0]);
                        }
                        f[j][k][1] = f[j][k][1].add(g[j + 1][k][1]);
                    }
                }
            }

            if (i % 2 == 0) {
                for (int j = 0; j <= i && j < n; j++) {
                    tn[i / 2 + 1][j] = f[0][j][1];
                }
            }
        }

        BigInteger r = BigInteger.ZERO;
        for (int i = 0; i < n && n - 2 * i > 0; i++) {
            r = r.add(tn[n - 2 * i][i]);
        }

        out.println(r);

        in.close();
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new pines_as_slow().run();
    }
}
