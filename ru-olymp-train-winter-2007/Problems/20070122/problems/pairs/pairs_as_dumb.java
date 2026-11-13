import java.util.*;
import java.io.*;

public class pairs_as_dumb {
    int n1;
    int n2;
    int m;
    int[] x;
    int[] y;
    boolean[][] a;
    boolean[] u;
    int[] p;

    boolean dfs(int x) {
        u[x] = true;

        for (int j = 0; j < n2; j++) {
            if (a[x][j] && (p[j] == -1 || !u[p[j]])) {
                if (p[j] == -1 || dfs(p[j])) {
                    p[j] = x;
                    return true;
                }
            }
        }
        return false;
    }

    int match() {
        int r = 0;
        Arrays.fill(p, -1);
        for (int i = 0; i < n1; i++) {
            Arrays.fill(u, false);
            if (dfs(i)) {
                r++;
            }
        }
        return r;
    }

    public void run() throws IOException {
        Scanner in = new Scanner(new File("pairs.in"));
        PrintWriter out = new PrintWriter(new File("pairs.out"));

        n1 = in.nextInt();
        n2 = in.nextInt();
        int m = in.nextInt();
        x = new int[m];
        y = new int[m];
        a = new boolean[n1][n2];
        u = new boolean[n1];
        p = new int[n2];

        for (int i = 0; i < m; i++) {
            x[i] = in.nextInt() - 1;
            y[i] = in.nextInt() - 1;
            a[x[i]][y[i]] = true;
        }

        int ans = 0;
        int mm = match();
        for (int i = 0; i < m; i++) {
            for (int j = i + 1; j < m; j++) {
                a[x[i]][y[i]] = false;
                a[x[j]][y[j]] = false;
                int r = match();
                if (r < mm) {
//                    out.println((i + 1) + " " + (j + 1));
                    ans++;
                }
                a[x[i]][y[i]] = true;
                a[x[j]][y[j]] = true;
            }
        }

        out.println(ans);

        in.close();
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new pairs_as_dumb().run();
    }
}
