import java.util.*;
import java.io.*;

public class radio_as {
    BufferedReader in;
    StringTokenizer st;

    int nextInt() {
        if (st == null || !st.hasMoreTokens()) {
            try {
                st = new StringTokenizer(in.readLine());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return Integer.parseInt(st.nextToken());
    }

    public void run() throws IOException {
        in = new BufferedReader(new FileReader("radio.in"));
        PrintWriter out = new PrintWriter(new File("radio.out"));

        int m = nextInt();
        int n = nextInt();
        int[][] a = new int[m + 1][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                a[i][j] = nextInt();
            }
        }
        int[] b = new int[m + 1];
        for (int i = 0; i < m; i++) {
            b[i] = nextInt();
        }
        int[] c = new int[n];
        for (int i = 0; i < n; i++) {
            c[i] = nextInt();
        }

        for (int i = m; i > 0; i--) {
            b[i] = b[i] - b[i - 1];
            for (int j = 0; j < n; j++) {
                a[i][j] = a[i][j] - a[i - 1][j];
            }
        }

        Graph g = new Graph(m + 3);
        Set<Edge> needCap = new HashSet<Edge>();
        for (int i = 0; i < m + 1; i++) {
            if (b[i] > 0) {
                needCap.add(g.addEdge(0, i + 1, b[i], 0));
            } else if (b[i] < 0) {
                needCap.add(g.addEdge(i + 1, m + 2, -b[i], 0));
            }
        }
        Edge[] xs = new Edge[n];
        for (int i = 0; i < n; i++) {
            int st = -1;
            int tg = -1;
            for (int j = 0; j < m + 1; j++) {
                if (a[j][i] == 1) {
                    st = j;
                }
                if (a[j][i] == -1) {
                    tg = j;
                }
            }
            if (st != -1) {
                xs[i] = g.addEdge(st + 1, tg + 1, Integer.MAX_VALUE, c[i]);
            }
        }

        int v = g.minCostFlow(0, m + 2);

        boolean ok = true;
        for (Edge e : needCap) {
            if (e.f < e.c) {
                ok = false;
            }
        }

        if (ok) {
            out.println(v);
            for (Edge e : xs) {
                if (e == null) {
                    out.print("0 ");
                } else {
                    out.print(e.f + " ");
                }
            }
            out.println();
        } else {
            out.println(-1);
        }

        in.close();
        out.close();
    }

    public class Graph {
        int n;
        List<Edge>[] edges;

        @SuppressWarnings("unchecked")
        public Graph(int n) {
            this.n = n;
            edges = new List[n];
            for (int i = 0; i < n; i++) {
                edges[i] = new ArrayList<Edge>();
            }
        }

        public Edge addEdge(int s, int d, int c, int p) {
            Edge ef = new Edge(s, d, c, p, 0);
            Edge er = new Edge(d, s, 0, -p, 0);
            ef.r = er;
            er.r = ef;
            edges[s].add(ef);
            edges[d].add(er);
            return ef;
        }

        int minCostFlow(int s, int t) {
            int[] d = new int[n];
            boolean[] u = new boolean[n];

            // Run Bellman-Ford algorithm
            d[s] = 0;
            u[s] = true;
            boolean changed = true;
            while (changed) {
                changed = false;
                for (int i = 0; i < n; i++) {
                    if (u[i]) {
                        for (Edge e: edges[i]) {
                            if (e.c > 0 && (!u[e.d] || d[e.d] > d[i] + e.p)) {
                                u[e.d] = true;
                                d[e.d] = d[i] + e.p;
                                changed = true;
                            }
                        }
                    }
                }
            }

            // Potentials
            int[] q = new int[n];
            for (int i = 0; i < n; i++) {
                q[i] = d[i];
            }

            int cost = 0;

            int[] c = new int[n];
            Edge[] from = new Edge[n];
            Heap h = new Heap(n);
            while (u[t]) {
                Arrays.fill(u, false);
                Arrays.fill(c, 0);
                Arrays.fill(d, 0);

                // Run Dijkstra
                d[s] = 0;
                u[s] = true;
                c[s] = Integer.MAX_VALUE;
                h.clean();
                h.insert(s, 0);

                while (h.size() > 0) {
                    int k = h.extractMin();

                    for (Edge e: edges[k]) {
                        if (e.c > e.f) {
                            int newd = d[k] + e.p + q[e.s] - q[e.d];
                            if (!u[e.d] || d[e.d] > newd) {
                                if (!u[e.d]) {
                                    h.insert(e.d, newd);
                                } else {
                                    h.decreaseKey(e.d, newd);
                                }
                                u[e.d] = true;
                                d[e.d] = newd;
                                c[e.d] = Math.min(c[k], e.c - e.f);
                                from[e.d] = e;
                            }
                        }
                    }
                }

                if (!u[t]) {
                    break;
                }

                cost += (q[t] + d[t]) * c[t];

                int k = t;
                while (k != s) {
                    Edge e = from[k];
                    e.f += c[t];
                    e.r.f -= c[t];
                    k = e.s;
                }

                for (int i = 0; i < n; i++) {
                    q[i] += d[i];
                }
            }

            return cost;
        }
    }

    public class Heap {
        int s;
        Pair[] h;
        int[] pos;

        public Heap(int n) {
            h = new Pair[n];
            pos = new int[n];
            s = 0;
        }

        public void clean() {
            s = 0;
        }

        public void insert(int key, int value) {
            h[s] = new Pair(key, value);
            pos[key] = s;
            s++;
            siftUp(s - 1);
        }

        public void decreaseKey(int key, int value) {
            int x = pos[key];
            h[x].value = value;
            siftUp(x);
        }

        public int extractMin() {
            int r = h[0].key;
            h[0] = h[s - 1];
            pos[h[0].key] = 0;
            s--;
            siftDown(0);
            return r;
        }

        public void siftUp(int x) {
            Pair t = h[x];
            while (x > 0 && h[(x - 1) / 2].value > t.value) {
                h[x] = h[(x - 1) / 2];
                pos[h[x].key] = x;
                x = (x - 1) / 2;
            }
            h[x] = t;
            pos[h[x].key] = x;
        }

        public void siftDown(int x) {
            while (2 * x + 1 < s) {
                int y = x;
                if (h[2 * x + 1].value < h[y].value) {
                    y = 2 * x + 1;
                }
                if (2 * x + 2 < s && h[2 * x + 2].value < h[y].value) {
                    y = 2 * x + 2;
                }
                if (y == x) {
                    break;
                }
                Pair t = h[x]; h[x] = h[y]; h[y] = t;
                pos[h[x].key] = x;
                pos[h[y].key] = y;
                x = y;
            }
        }

        int size() {
            return s;
        }
    }

    public class Pair {
        int key;
        int value;

        public Pair(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    public class Edge {
        int s;
        int d;
        int c;
        int p;
        int f;
        Edge r;

        public Edge(int s, int d, int c, int p, int f) {
            this.s = s;
            this.d = d;
            this.c = c;
            this.p = p;
            this.f = f;
        }


    }

    public static void main(String[] arg) throws IOException {
        new radio_as().run();
    }
}
