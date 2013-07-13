import java.io.*;
import java.util.*;

/**
 * @author Roman V Satyukov
 */
public class triangle_rs implements Runnable {
    private final String problemID = getClass().getName().split("_")[0].toLowerCase();
    private BufferedReader in;
    private PrintWriter out;

    private void check(boolean expr, String message) {
        if (!expr) {
            throw new AssertionError(message);
        }
    }
    
    private class Vector implements Comparable<Vector> {
        public long dx, dy;
        public long length;

        public void setCoordinates(long dx, long dy) {
            check(dx != 0 || dy != 0, "There are at least two coincide points");
            this.dx = dx;
            this.dy = dy;
            this.length = dx * dx + dy * dy;
        }

        public int compareTo(Vector that) {
            long diff = length - that.length;
            if (diff != 0) {
                return (diff > 0 ? 1 : -1);
            }
            if (dx != that.dx) {
                return (dx > that.dx ? 1 : -1);
            }
            return (dy > that.dy ? 1 : -1);
        }
        
        @Override
        public String toString() {
            return dx + " " + dy;
        }
    }
    
    private long process(Vector[] w, int sz) {
        int u = 0;
        int v = sz - 1;
        long answer = sz * (sz - 1) / 2;
        while (u <= v) {
            while (v >= u && (w[v].dx > -w[u].dx || (w[v].dx == -w[u].dx && w[v].dy > -w[u].dy))) {
                v--;
            }
            if (v < u) {
                break;
            }
            if (w[v].dx + w[u].dx == 0 && w[v].dy + w[u].dy == 0) {
                answer--;
            }
            u++;
        }
        return answer;
    }

    private void solve() throws IOException {
        int n = Integer.parseInt(in.readLine());
        long[] x = new long[n];
        long[] y = new long[n];
        for (int i = 0; i < n; i++) {
            StringTokenizer st = new StringTokenizer(in.readLine());
            x[i] = Integer.parseInt(st.nextToken());
            y[i] = Integer.parseInt(st.nextToken());
            check(Math.abs(x[i]) <= 1000000000, "Some of |x[i]| is greater than 10^9");
            check(Math.abs(y[i]) <= 1000000000, "Some of |y[i]| is greater than 10^9");
        }
        Vector[] vectors = new Vector[n - 1];
        Vector[] w = new Vector[n - 1];
        for (int i = 0; i < vectors.length; i++) {
            vectors[i] = new Vector();
            w[i] = new Vector();
        }
        long answer = 0;
        for (int i = 0; i < n; i++) {
            int sz = 0;
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    vectors[sz++].setCoordinates(x[j] - x[i], y[j] - y[i]);
                }
            }
            Arrays.sort(vectors);
            sz = 0;
            for (int j = 0; j < n - 1; j++) {
                if (j > 0 && vectors[j].length != vectors[j - 1].length) {
                    answer += process(w, sz);
                    sz = 0;
                }
                w[sz++] = vectors[j];
            }
            answer += process(w, sz);
        }
        out.println(answer);
    }

    public void run() {
        try {
            in = new BufferedReader(new FileReader(new File(problemID + ".in")));
            out = new PrintWriter(new File(problemID + ".out"));
            solve();
            in.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public static void main(String[] args) {
        new Thread(new triangle_rs()).start();
    }
}
