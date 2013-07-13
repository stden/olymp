import java.util.*;
import java.io.*;

public class young_as_slow {
    public void run() throws FileNotFoundException {
        Scanner in = new Scanner(new File("young.in"));
        int n = in.nextInt();
        in.close();

        List<State>[][] a = new List[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                a[i][j] = new LinkedList<State>();
            }
        }

        a[0][0].add(new State(0));

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                List<State> l = a[i][j];
                for (State s: l) {
                    for (int k = Math.max(1, j); i + k <= n; k++) {
                        State p = s.add(k);
                        List<State> nl = a[i + k][k];
                        boolean need = true;
                        for (Iterator<State> it = nl.iterator(); it.hasNext();) {
                            State np = it.next();
                            if (np.worse(p)) {
                                it.remove();
                            }
                            if (p.worse(np)) {
                                need = false;
                            }
                        }
                        if (need) {
                            nl.add(p);
                        }
                    }
                }
            }
        }

        State best = null;
        for (int i = 1; i <= n; i++) {
            List<State> l = a[n][i];
            for (State s: l) {
                if (best == null || s.count > best.count) {
                    best = s;
                }
            }
        }

        PrintWriter out = new PrintWriter(new File("young.out"));
        out.println(best.count - 1);
        out.println(best);
        out.close();
    }

    public class State {
        long count;
        long[] b;
        State from;
        int last;

        public State(int n) {
            count = n + 1;
            b = new long[n + 1];
            for (int i = 0; i <= n; i++) {
                b[i] = 1;
            }
        }

        public State(long count, long[] b, State from, int last) {
            this.count = count;
            this.b = b;
            this.from = from;
            this.last = last;
        }

        boolean worse(State s) {
            long our = 0;
            long his = 0;
            for (int i = 0; i < b.length; i++) {
                our += b[i];
                his += s.b[i];
                if (our > his) {
                    return false;
                }
            }

            assert our == count;
            return true;
        }

        public State add(int k) {
            long[] a = new long[k + 1];
            a[0] = b[0];
            long ncount = a[0];
            for (int i = 1; i <= k; i++) {
                if (i < b.length) {
                    a[i] = a[i - 1] + b[i];
                } else {
                    a[i] = a[i - 1];
                }
                ncount += a[i];
            }
            return new State(ncount, a, this, k);
        }

        public boolean equals(Object o) {
            final State state = (State) o;

            if (count != state.count) return false;
            if (!Arrays.equals(b, state.b)) return false;

            return true;
        }

        public String toString() {
            if (last == 0) {
                return "";
            } else {
                return last + " " + from.toString();
            }
        }
    }

    public static void main(String[] args) throws FileNotFoundException {
        new young_as_slow().run();
    }
}
