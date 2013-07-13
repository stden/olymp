import java.util.*;
import java.io.*;

public class pairs_as implements Runnable {
    class Edge {
        int s;
        int d;
        int i;

        public Edge(int s, int d, int i) {
            this.s = s;
            this.d = d;
            this.i = i;
        }

        public String toString() {
            return s + "->" + d;
        }
    }

    int n1;
    int n2;

    ArrayList<Edge>[] e1;
    ArrayList<Edge>[] e2;

    boolean[] u;
    Edge[] mx;
    Edge[] my;

    ArrayList<Edge>[] ref;
    ArrayList<Edge>[] rer;

    boolean[] counted;

    boolean dfs(int i) {
        u[i] = true;
        for (Edge e : e1[i]) {
            if (my[e.d] == null || !u[my[e.d].s]) {
                if (my[e.d] == null || dfs(my[e.d].s)) {
                    my[e.d] = e;
                    mx[i] = e;
                    return true;
                }
            }
        }
        return false;
    }

    int findMatching() {
        u = new boolean[n1];
        mx = new Edge[n1];
        my = new Edge[n2];

        int size = 0;
        for (int i = 0; i < n1; i++) {
            Arrays.fill(u, false);
            if (dfs(i)) {
                size++;
            }
        }
        return size;
    }

    boolean increaseMatching() {
        Arrays.fill(u, false);
        for (int i = 0; i < n1; i++) {
            if (mx[i] == null && dfs(i)) {
                return true;
            }
        }
        return false;
    }

    boolean[] vis;
    int[] ls;
    int sp;
    int[] color;
    int nColors;

    void dfsscc1(int i) {
        vis[i] = true;
        for (Edge e : ref[i]) {
            if (!vis[e.d]) {
                dfsscc1(e.d);
            }
        }
        ls[sp++] = i;
    }

    void dfsscc2(int i, int c) {
        color[i] = c;
        vis[i] = true;
        for (Edge e : rer[i]) {
            if (!vis[e.d]) {
                dfsscc2(e.d, c);
            }
        }
    }

    void dfsvisf(int i) {
        vis[i] = true;
        for (Edge e : ref[i]) {
            if (!vis[e.d]) {
                dfsvisf(e.d);
            }
        }
    }

    void dfsvisr(int i) {
        vis[i] = true;
        for (Edge e : rer[i]) {
            if (!vis[e.d]) {
                dfsvisr(e.d);
            }
        }
    }

    void findStronglyConnectedComponents() {
        vis = new boolean[n1 + n2];
        ls = new int[n1 + n2];
        sp = 0;
        for (int i = 0; i < n1 + n2; i++) {
            if (!vis[i]) {
                dfsscc1(i);
            }
        }

        color = new int[n1 + n2];
        Arrays.fill(vis, false);
        nColors = 0;
        for (int i = sp - 1; i >= 0; i--) {
            if (!vis[ls[i]]) {
                dfsscc2(ls[i], nColors++);
            }
        }
    }

    @SuppressWarnings("unchecked")
    int countCriticalEdges() {
        ref = new ArrayList[n1 + n2];
        rer = new ArrayList[n1 + n2];
        for (int i = 0; i < n1 + n2; i++) {
            ref[i] = new ArrayList<Edge>();
            rer[i] = new ArrayList<Edge>();
        }

        for (int i = 0; i < n1; i++) {
            for (Edge e : e1[i]) {
                if (e == mx[i]) {
                    ref[n1 + e.d].add(new Edge(n1 + e.d, i, e.i));
                    rer[i].add(new Edge(i, n1 + e.d, e.i));
                } else {
                    ref[i].add(new Edge(i, n1 + e.d, e.i));
                    rer[n1 + e.d].add(new Edge(n1 + e.d, i, e.i));
                }
            }
        }

        findStronglyConnectedComponents();

        Arrays.fill(vis, false);
        for (int i = 0; i < n1; i++) {
            if (mx[i] == null && !vis[i]) {
                dfsvisf(i);
            }
        }
        for (int i = 0; i < n2; i++) {
            if (my[i] == null && !vis[n1 + i]) {
                dfsvisr(n1 + i);
            }
        }

        int nBridges = 0;
        for (int i = n1; i < n1 + n2; i++) {
            for (Edge e : ref[i]) {
                if (color[e.s] != color[e.d] && !vis[e.s] && !vis[e.d]) {
                    if (!counted[e.i]) {
                        nBridges++;
                    }
                }
            }
        }

        return nBridges;
    }

    @SuppressWarnings("unchecked")
    public void solve() throws IOException {
        Scanner in = new Scanner(new File("pairs.in"));
        PrintWriter out = new PrintWriter(new File("pairs.out"));

        n1 = in.nextInt();
        n2 = in.nextInt();
        int m = in.nextInt();
        e1 = new ArrayList[n1];
        for (int i = 0; i < n1; i++) {
            e1[i] = new ArrayList<Edge>();
        }
        e2 = new ArrayList[n2];
        for (int i = 0; i < n2; i++) {
            e2[i] = new ArrayList<Edge>();
        }

        for (int i = 0; i < m; i++) {
            int x = in.nextInt() - 1;
            int y = in.nextInt() - 1;
            Edge e = new Edge(x, y, i);
            e1[x].add(e);
            e2[y].add(e);
        }


        int ms = findMatching();

        counted = new boolean[m];
        int nBridges = countCriticalEdges();
        int nOther = m - ms;
        int answer = nBridges * (nBridges - 1) / 2 + nBridges * nOther;

        Edge[] smx = new Edge[n1];
        Edge[] smy = new Edge[n2];
        System.arraycopy(mx, 0, smx, 0, n1);
        System.arraycopy(my, 0, smy, 0, n2);
        for (int i = 0; i < n1; i++) {
            if (mx[i] != null) {
                Edge e = mx[i];
                e1[e.s].remove(e);
                e2[e.d].remove(e);
                mx[e.s] = null;
                my[e.d] = null;

                if (increaseMatching()) {
                    answer += countCriticalEdges();
                    counted[e.i] = true;
                }

                e1[e.s].add(e);
                e2[e.d].add(e);

                System.arraycopy(smx, 0, mx, 0, n1);
                System.arraycopy(smy, 0, my, 0, n2);
            }
        }

        out.println(answer);


        in.close();
        out.close();
    }

    public void run() {
        try {
            solve();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] arg) throws IOException {
        new Thread(new pairs_as()).start();
    }
}
