import java.io.*;
import java.util.*;
import java.math.*;

public class road_ab_number_only implements Runnable {

    final String INF = "Infinity";
    final int MAX = 1000;   
    
    
    private void solve() throws IOException {
        long[] x = new long[4];
        long[] y = new long[4];
        for (int i = 0; i < 4; ++i) {
            x[i] = 2 * in.nextInt();
            y[i] = 2 * in.nextInt();
            myAssert(Math.abs(x[i]) <= 2 * MAX);
            myAssert(Math.abs(y[i]) <= 2 * MAX);
            for (int j = 0; j < i; ++j) {
                if (x[i] == x[j] && y[i] == y[j]) {
                    out.println(INF);
                    return;
                }
            }
        }
        ArrayList<long[]> ll = new ArrayList<long[]>();
        double ans = 0;
        
        for (int i = 0; i < 2; ++i) {
            loop:
            for (int j = i + 1; j < 4; ++j) {
                int k = 0;
                for (; k == i || k == j; ++k);
                int l = 6 - i - j - k;
                long[] l1 = createLine(x[i] - x[j], y[i] - y[j], (x[i] + x[j]) / 2, (y[i] + y[j]) / 2);
                long[] l2 = createLine(x[k] - x[l], y[k] - y[l], (x[k] + x[l]) / 2, (y[k] + y[l]) / 2);
                long[] pc = vmul(l1, l2);
                if (isZero(pc)) {
                    ans += Double.POSITIVE_INFINITY;
                }
                if (pc[0] != 0) {
                    long td1 = (x[i] * pc[0] - pc[1]) * (x[i] * pc[0] - pc[1]) + (y[i] * pc[0] - pc[2]) * (y[i] * pc[0] - pc[2]);  
                    long td2 = (x[k] * pc[0] - pc[1]) * (x[k] * pc[0] - pc[1]) + (y[k] * pc[0] - pc[2]) * (y[k] * pc[0] - pc[2]);  
                    if (td1 == td2) {
                        ans += Double.POSITIVE_INFINITY;
                    } else {
                        for (long[] t : ll) {
                            if (isZero(vmul(t, pc))) continue loop;
                        }
                        ll.add(pc.clone());
                        ++ans;
                    }
                }
            }
        }
        
        loop:
        for (int i = 0; i < 4; ++i) {
            int a = 0;
            for (; a == i; ++a);
            int b = 0;
            for (; b == i || b == a; ++b);
            int c = 0;
            for (; c == i || c == a || c == b; ++c);
            
            if ((x[b] - x[a]) * (y[c] - y[a]) == (y[b] - y[a]) * (x[c] - x[a])) {
                continue;
            }
            
            long[] l1 = createLine(x[a] - x[b], y[a] - y[b], (x[a] + x[b]) / 2, (y[a] + y[b]) / 2);
            long[] l2 = createLine(x[b] - x[c], y[b] - y[c], (x[b] + x[c]) / 2, (y[b] + y[c]) / 2);
            long[] pc = vmul(l1, l2);
            
            long td1 = (x[i] * pc[0] - pc[1]) * (x[i] * pc[0] - pc[1]) + (y[i] * pc[0] - pc[2]) * (y[i] * pc[0] - pc[2]);  
            long td2 = (x[a] * pc[0] - pc[1]) * (x[a] * pc[0] - pc[1]) + (y[a] * pc[0] - pc[2]) * (y[a] * pc[0] - pc[2]);
            
            if (td1 == td2) {
                ans += Double.POSITIVE_INFINITY;
            } else {
                for (long[] t : ll) {
                    if (isZero(vmul(t, pc))) continue loop;
                }
                ll.add(pc.clone());
                ++ans;
            }
        }
        
        if (ans == Double.POSITIVE_INFINITY) {
            out.println(INF);
        } else {
            out.println((int)ans);
        }
    }

    long[] createLine(long a, long b, long x0, long y0) {
        long[] ans = new long[3];
        ans[0] = - a * x0 - b * y0;
        ans[1] = a;
        ans[2] = b;
        return ans;
    }
    
    long[] vmul(long[] a, long[] b) {
        long[] ans = new long[3];
        for (int i = 0; i < 3; ++i) {
            ans[i] = a[(i + 1) % 3] * b[(i + 2) % 3] - b[(i + 1) % 3] * a[(i + 2) % 3]; 
        }
        return ans;
    }
    
    long smul(long[] a, long[] b) {
        long ans = 0;
        for (int i = 0; i < 3; ++i) {
            ans += a[i] * b[i];
        }
        return ans;
    }
    
    
    boolean isZero(long[] a) {
        for (int i = 0; i < 3; ++i) {
            if (a[i] != 0) return false; 
        }
        return true;
    }
    
    void myAssert(boolean e) {
        if (!e) throw new Error();
    }
    
    final String FILE_NAME = "road";

    SimpleScanner in;
    PrintWriter out;

    public void run() {
        try {
            in = new SimpleScanner(new FileReader(FILE_NAME + ".in"));
            out = new PrintWriter(FILE_NAME + ".out");
            solve();
            out.close();
            in.close();
        } catch (Throwable e) {
            e.printStackTrace();
            System.exit(-1);
        }
    }

    public static void main(String[] args) {
        new road_ab_number_only().run();
    }

    class SimpleScanner extends BufferedReader {

        private StringTokenizer st;
        private boolean eof;

        public SimpleScanner(Reader a) {
            super(a);
        }

        String next() {
            while (st == null || !st.hasMoreElements()) {
                try {
                    st = new StringTokenizer(readLine());
                } catch (Exception e) {
                    eof = true;
                    return "";
                }
            }
            return st.nextToken();
        }

        boolean seekEof() {
            String s = next();
            if ("".equals(s) && eof)
                return true;
            st = new StringTokenizer(s + " " + st.toString());
            return false;
        }

        private String cnv(String s) {
            if (s.length() == 0)
                return "0";
            return s;
        }

        int nextInt() {
            return Integer.parseInt(cnv(next()));
        }

        double nextDouble() {
            return Double.parseDouble(cnv(next()));
        }

        long nextLong() {
            return Long.parseLong(cnv(next()));
        }
    }
}
