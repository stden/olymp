import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class young_as {
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

        int longest = 0;
        for (int j = n; j >= 1; j--) {
            a[j][j].add(new State(j));
            for (int i = j; i <= n; i++) {
                List<State> l = a[i][j];
                if (l.size() > longest) {
                    longest = l.size();
                }
                for (State s: l) {
//                    System.out.println("prolonging [" + s + "] = " + s.count);
                    for (int k = 1; k <= j && i + k <= n; k++) {
                        State p = s.add(k);
                        List<State> nl = a[i + k][k];
                        boolean need = true;
                        for (Iterator<State> it = nl.iterator(); it.hasNext();) {
                            State np = it.next();
                            if (np.worse(p)) {
                                it.remove();
//                                System.out.println("removing  [" + np + "] because [" + p + "] is better");
                            }
                            if (p.worse(np)) {
//                                System.out.println("ignoring [" + p + "] because [" + np + "] is better");
                                need = false;
                                break;
                            }
                        }
                        if (need) {
//                            System.out.println("using [" + p + "]");
                            nl.add(p);
                        }
                    }
                }
            }
        }

        System.out.println("Longest border: " + longest);

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
        out.println(best.count);
        out.println(best);
        out.close();
    }

    public class State {
        long count;
        long[] b;
        State from;
        int last;

        public State(int n) {
            count = n;
            last = n;
            b = new long[n + 1];
            for (int i = 1; i <= n; i++) {
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
            if (count > s.count) {
                return false;
            }

            long our = 0;
            long his = 0;
            for (int i = b.length - 1; i >= 0; i--) {
                our += b[i];
                his += s.b[i];
                if (our > his) {
                    return false;
                }
            }

            return true;
        }

        public State add(int k) {
            long[] a = new long[k + 1];
            a[0] = b[0];
            long t = 0;
            long ncount = 0;
            for (int i = b.length - 1; i >= 0; i--) {
                t += b[i];
                if (i <= k) {
                    a[i] = t;
                    ncount += t;
                }
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
            if (from == null) {
                return "" + last;
            } else {
                return from.toString() + " " + last;
            }
        }
    }

    public static void main(String[] args) throws FileNotFoundException {
        new young_as().run();
    }
}
