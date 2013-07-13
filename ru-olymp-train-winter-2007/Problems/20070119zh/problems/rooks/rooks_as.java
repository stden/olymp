import java.io.*;
import java.util.*;
import java.math.BigInteger;

public class rooks_as {

    public void run() throws IOException {
        Scanner in = new Scanner(new File("rooks.in"));
        int m = in.nextInt();
        int n = in.nextInt();
        int r1 = in.nextInt();
        int r2 = in.nextInt();
        int rn = Math.max(r1, r2);
        in.close();

        int s = n * m + 1;
        BigInteger[][] c = new BigInteger[s][s];
        for (int i = 0; i < s; i++) {
            Arrays.fill(c[i], BigInteger.ZERO);
            c[i][0] = BigInteger.ONE;
            for (int j = 1; j <= i; j++) {
                c[i][j] = c[i - 1][j - 1].add(c[i - 1][j]);
            }
        }

        BigInteger[][][] x = new BigInteger[m + 1][n + 1][rn + 1];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= rn; k++) {
                    if (k > i * j) {
                        x[i][j][k] = BigInteger.ZERO;
                    } else {
                        x[i][j][k] = c[i * j][k];
                        for (int p = 0; p <= i; p++) {
                            for (int q = 0; q <= j; q++) {
                                if (p < i || q < j && p * q >= k) {
                                    x[i][j][k] = x[i][j][k].subtract(
                                            c[i][p].multiply(c[j][q]).multiply(x[p][q][k])
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }

        BigInteger answer = BigInteger.ZERO;
        for (int i1 = 1; i1 < m; i1++) {
            for (int i2 = 1; i1 + i2 <= m; i2++) {
                for (int j1 = 1; j1 < n; j1++) {
                    for (int j2 = 1; j1 + j2 <= n; j2++) {
                        BigInteger r = c[m][i1].multiply(c[m - i1][i2]).multiply(c[n][j1]).
                                multiply(c[n - j1][j2]).multiply(x[i1][j1][r1]).multiply(x[i2][j2][r2]);
                        if (!r.equals(BigInteger.ZERO)) {
                            System.out.println(i1 + " " + i2 + " " + j1 + " " + j2 + " " + r);
                        }
                        answer = answer.add(r);
                    }
                }
            }
        }

        PrintWriter out = new PrintWriter(new File("rooks.out"));
        out.println(answer);
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new rooks_as().run();
    }
}
