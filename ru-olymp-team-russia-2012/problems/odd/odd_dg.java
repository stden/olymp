import static java.math.BigInteger.valueOf;

import java.util.*;
import java.io.*;

public class odd_dg implements Runnable {
	FastScanner in;
	PrintWriter out;

	class Edge implements Comparable<Edge>{
		int from, to, idx;

		public Edge(int from, int to, int idx) {
			super();
			this.from = from;
			this.to = to;
			this.idx = idx;
		}
		
		public Edge(Edge o) {
			super();
			this.from = o.to;
			this.to = o.from;
			this.idx = o.idx;
		}
		@Override
		public int compareTo(Edge o) {
			return Integer.compare(this.idx, o.idx);
		}

	}

	Edge[][] graph;

	int dfsComponent(int cur, boolean[] used) {
		used[cur] = true;
		int cnt = 0;
		for (Edge i : graph[cur]) {
			if (!used[i.to]) {
				cnt += dfsComponent(i.to, used);
			}
		}
		return cnt + 1;
	}

	boolean wrapperDfsComponent() {
		boolean[] used = new boolean[graph.length];
		for (int i = 0; i < graph.length; i++) {
			if (!used[i]) {
				int temp = dfsComponent(i, used);
//				System.err.println(i + " " + temp);
				if (temp % 2 != 0) {
					return false;
				}
			}
		}
		return true;
	}
	
	TreeSet<Edge> answer = new TreeSet<Edge>();
	
	int dfsCountVertices(int cur, boolean[] used) {
		used[cur] = true;
		int cnt = 0;
		for (Edge i : graph[cur]) {
			if (!used[i.to]) {
				int temp = dfsCountVertices(i.to, used);
//				System.err.println((i.from + 1) + "->" + (i.to + 1) + " " + i.idx);
				if (temp % 2 == 1) {
					answer.add(i);
//					System.err.println("||" + answer.size());
				}
				cnt += temp;
			}
		}
//		System.err.println(cur + " " + (cnt + 1));
		return cnt + 1;
	}
	
	void wrapperDfsVertices() {
		boolean[] used = new boolean[graph.length];
		for (int i = 0; i < graph.length; i++) {
			if (!used[i]) {
//				System.err.println("->>>>" + (i + 1));
				dfsCountVertices(i, used);
			}
		}
	}

	public void solve() throws IOException {
		int n = in.nextInt(), m = in.nextInt();
		int[] deg = new int[n];
		Edge[] edges = new Edge[m];
		graph = new Edge[n][];
		for (int i = 0; i < m; i++) {
			edges[i] = new Edge(in.nextInt() - 1, in.nextInt() - 1, i);
			deg[edges[i].from]++;
			deg[edges[i].to]++;
		}

		for (int i = 0; i < n; i++) {
			graph[i] = new Edge[deg[i]];
		}
		for (Edge e : edges) {
			graph[e.from][--deg[e.from]] = e;
			graph[e.to][--deg[e.to]] = new Edge(e);
		}
//		System.err.println("->>" + graph[0].length);
		if (!wrapperDfsComponent()) {
			out.println(-1);
			return;
		}
		wrapperDfsVertices();
		out.println(answer.size());
		while(!answer.isEmpty()) {
			Edge e = answer.pollFirst();
			deg[e.from]++;
			deg[e.to]++;
			out.println(e.idx + 1);
		}
		for (int i = 0; i < n; i++) {
			if (deg[i] % 2 != 1) {
				System.err.println("SAD");
				return;
			}
		}
		System.err.println("YAY!");
	}

	public void run() {
		try {
			in = new FastScanner(new File("odd.in"));
			out = new PrintWriter(new File("odd.out"));

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class FastScanner {
		BufferedReader br;
		StringTokenizer st;

		FastScanner(File f) {
			try {
				br = new BufferedReader(new FileReader(f));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		String next() {
			while (st == null || !st.hasMoreTokens()) {
				try {
					st = new StringTokenizer(br.readLine());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return st.nextToken();
		}

		int nextInt() {
			return Integer.parseInt(next());
		}
	}

	public static void main(String[] arg) {
		new Thread(new odd_dg()).start();
	}
}