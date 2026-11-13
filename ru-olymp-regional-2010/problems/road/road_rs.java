import java.io.*;
import java.util.*;

public class road_rs implements Runnable {
    private BufferedReader in;
    private PrintWriter out;
   
    private void check(boolean expr, String msg) {
        if (!expr) {
            throw new Error(msg);
        }
    }
   
    private void checkBounds(int n, int low, int hi, String nStr) {
        check((low <= n) && (n <= hi), nStr + " is not in [" + low + ", " + hi + "]");
    }

    private class Rational {
        private long num, denom;

        private long gcd(long a, long b) {
            while (b > 0) {
                long tmp = a % b;
                a = b;
                b = tmp;
            }
            return a;
        }

        public Rational(long num, long denom) {
            long g = gcd(Math.abs(num), Math.abs(denom));
            if (g != 1) {
                num /= g;
                denom /= g;
            }
            if (denom < 0) {
                num = -num;
                denom = -denom;
            }
            this.num = num;
            this.denom = denom;
        }

        @Override
        public boolean equals(Object o) {
            Rational that = (Rational) o;
            return (num == that.num) && (denom == that.denom);
        }

        @Override
        public String toString() {
            return num + "/" + denom;
        }

        public double doubleValue() {
            return 1.0 * num / denom;
        }
    }

    private int[] x, y;
    private Rational[] xc, yc;
    private int count;
    private boolean infinity;
    private double ansx;
    private double ansy;
    private double ansr;

    private void testCircle(int u, int v, int k) {
        long a1 = 2 * (x[v] - x[u]);
        long b1 = 2 * (y[v] - y[u]);
        long c1 = (-a1 * (x[u] + x[v]) - b1 * (y[u] + y[v])) / 2;
        long a2 = 2 * (x[k] - x[u]);
        long b2 = 2 * (y[k] - y[u]);
        long c2 = (-a2 * (x[u] + x[k]) - b2 * (y[u] + y[k])) / 2;

        long d = a1 * b2 - a2 * b1;
        if (d == 0) {
            return;
        }

        xc[count] = new Rational(-(c1 * b2 - c2 * b1), d);
        yc[count] = new Rational(-(a1 * c2 - a2 * c1), d);
        count++;
    }

    private void testCircle2(int i, int j, int u, int v) {
        long a1 = 2 * (x[j] - x[i]);
        long b1 = 2 * (y[j] - y[i]);
        long c1 = (-a1 * (x[i] + x[j]) - b1 * (y[i] + y[j])) / 2;

        long a2 = 2 * (x[v] - x[u]);
        long b2 = 2 * (y[v] - y[u]);
        long c2 = (-a2 * (x[u] + x[v]) - b2 * (y[u] + y[v])) / 2;

        long d = a1 * b2 - a2 * b1;
        if (d == 0) {
            if ((a1 * c2 == a2 * c1) && (b1 * c2 == b2 * c1)) {
                double x0 = (x[i] + x[j]) / 2.0;
                double y0 = (y[i] + y[j]) / 2.0;
                double r0 = (Math.hypot(x0 - x[i], y0 - y[i]) + Math.hypot(x0 - x[u], y0 - y[u])) / 2.0;
                if (r0 < ansr) {
                    ansr = r0;
                    ansx = x0;
                    ansy = y0;
                }
                infinity = true;
                return;
            }
            return;
        }

        xc[count] = new Rational(-(c1 * b2 - c2 * b1), d);
        yc[count] = new Rational(-(a1 * c2 - a2 * c1), d);
        count++;
    }
   
    private void solve() throws IOException {
        x = new int[4];
        y = new int[4];
        for (int i = 0; i < 4; i++) {
            StringTokenizer st = new StringTokenizer(in.readLine());
            x[i] = Integer.parseInt(st.nextToken());
            y[i] = Integer.parseInt(st.nextToken());
            checkBounds(x[i], -100, 100, "x[i]");
            checkBounds(y[i], -100, 100, "x[i]");
        }
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < i; j++) {
                check((x[i] != x[j]) || (y[i] != y[j]), "at least two points coincide");
            }
        }
        xc = new Rational[7];
        yc = new Rational[7];
        ansx = 0.0;
        ansy = 0.0;
        ansr = 1e100;
        for (int u = 0; u < 4; u++) {
            for (int v = u + 1; v < 4; v++) {
                for (int k = v + 1; k < 4; k++) {
                    testCircle(u, v, k);
                }
            }
        }
        for (int i = 0; i < count; i++) {
            for (int j = 0; j < i; j++) {
                if (xc[i].equals(xc[j]) && yc[i].equals(yc[j])) {
                    infinity = true;
                    out.println("Infinity");
                    out.printf("%.8f %.8f %.8f\n", xc[i].doubleValue(), yc[i].doubleValue(), 0.0);
                    return;
                }
            }
        }
        infinity = false;
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < i; j++) {
                for (int u = 0; u < i; u++) {
                    for (int v = 0; v < u; v++) {
                        if (u == i || u == j || v == i || v == j) {
                            continue;
                        }
                        testCircle2(i, j, u, v);
                    }
                }
            }
        }
        int answer = 0;
        LOOP:
        for (int i = 0; i < count; i++) {
            for (int j = 0; j < i; j++) {
                if (xc[i].equals(xc[j]) && yc[i].equals(yc[j])) {
                    continue LOOP;
                }
            }
            answer++;
        }
        if (infinity) {
            out.println("Infinity");
        } else {
            out.println(answer);
        }
        double[] dist = new double[4];
        for (int i = 0; i < count; i++) {
            double x0 = xc[i].doubleValue();
            double y0 = yc[i].doubleValue();
            for (int j = 0; j < 4; j++) {
                dist[j] = Math.hypot(x0 - x[j], y0 - y[j]);
            }
            Arrays.sort(dist);
            double r0 = (dist[0] + dist[3]) / 2.0;
            if (r0 < ansr) {
                ansr = r0;
                ansx = x0;
                ansy = y0;
            }
        }
        out.printf("%.8f %.8f %.8f\n", ansx, ansy, ansr);
    }
   
    public static void main(String[] args) {
        new road_rs().run();
    }

    public void run() {
        String problem = getClass().getName().split("_")[0];
        try {
            Locale.setDefault(Locale.US);
            in = new BufferedReader(new FileReader(new File(problem + ".in")));
            out = new PrintWriter(new File(problem + ".out"));
            solve();
            in.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
