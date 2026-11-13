import java.util.*;
import java.io.*;
import java.math.BigInteger;

public class pines_as {
    public void run() throws IOException {
        Scanner in = new Scanner(new File("pines.in"));
        PrintWriter out = new PrintWriter(new File("pines.out"));
        int n = in.nextInt();

        if (n == 3) {
            out.println(1);
            out.close();
            return;
        }

        BigInteger[][] c = new BigInteger[2 * n + 1][n + 1];

        Arrays.fill(c[0], BigInteger.ZERO);
        c[0][0] = BigInteger.ONE;

        for (int i = 1; i <= 2 * n; i++) {
            c[i][0] = BigInteger.ONE;
            for (int j = 1; j <= n; j++) {
                c[i][j] = c[i - 1][j - 1].add(c[i - 1][j]);
            }
        }


        BigInteger r = BigInteger.ZERO;
        for (int i = 1; i < n && n - 2 * i > 1; i++) {
            BigInteger tn = c[n - 2 * i - 2][i - 1].multiply(c[n - 2 * i - 1][i - 1]).divide(BigInteger.valueOf(i));
            r = r.add(tn);
        }

        out.println(r);

        in.close();
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new pines_as().run();
    }
}
