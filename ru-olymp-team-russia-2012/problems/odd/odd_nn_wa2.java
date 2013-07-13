import static java.util.Arrays.deepToString;
import static java.util.Arrays.fill;

import java.io.*;
import java.util.Random;

public class odd_nn_wa2 {
	static final String PROBLEM_ID;

	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	static int nextInt(BufferedReader br) throws IOException {
		int c = br.read();
		while (c < '0' || c > '9') {
			c = br.read();
		}
		int ret = 0;
		while (c >= '0' && c <= '9') {
			ret = ret * 10 + c - '0';
			c = br.read();
		}
		return ret;
	}

	static int[][] getAdjacencyLists(int n, int m, int[] from, int[] to) {
		int[] deg = new int[n];
		for (int i = 0; i < m; i++) {
			deg[from[i]]++;
			deg[to[i]]++;
		}
		int[][] edges = new int[n][];
		for (int i = 0; i < n; i++) {
			edges[i] = new int[deg[i]];
		}
		for (int i = 0; i < m; i++) {
			edges[from[i]][--deg[from[i]]] = to[i];
			edges[to[i]][--deg[to[i]]] = from[i];
		}
		return edges;
	}

	static boolean[] restoreAnswer(int n, int m, int[] from, int[] to,
			int[][] edges, boolean[][] dontTakeEdge) {
		int[] deg = new int[n];
		for (int i = 0; i < m; i++) {
			deg[from[i]]++;
			deg[to[i]]++;
		}
		boolean[] take = new boolean[m];
		fill(take, true);
		for (int i = 0; i < m; i++) {
			if (dontTakeEdge[from[i]][--deg[from[i]]] != dontTakeEdge[to[i]][--deg[to[i]]]) {
				take[i] = false;
			}
		}
		return take;
	}

	static int[][] edges;
	static boolean[][] dontTakeEdge;
	static boolean[] was;
	static boolean[] isEven;

	static boolean dfs0(int v, int p) {
		was[v] = true;
		boolean odd = true;
		for (int i : edges[v]) {
			if (was[i]) {
				continue;
			}
			odd ^= dfs0(i, v);
		}
		return odd;
	}

	static int[] visited;

	static boolean findPath(int u, int p) {
		if (p != -1 && isEven[u]) {
			return true;
		}
		for (int i = 0; i < edges[u].length; i++) {
			int v = edges[u][i];
			if (visited[v] == visited[u]) {
				continue;
			}
			visited[v] = visited[u];
			if (findPath(v, u)) {
				dontTakeEdge[u][i] ^= true;
				return true;
			}
		}
		return false;
	}

	static Random rng = new Random(58);

	static int[] randomPermutation(int n) {
		int[] p = new int[n];
		for (int i = 0; i < n; i++) {
			int j = rng.nextInt(i + 1);
			p[i] = p[j];
			p[j] = i;
		}
		return p;
	}

	static boolean[] solve(int n, int m, int[] from, int[] to) {
		edges = getAdjacencyLists(n, m, from, to);
		was = new boolean[n];
		for (int root = 0; root < n; root++) {
			if (was[root]) {
				continue;
			}
			if (dfs0(root, -1)) {
				return null;
			}
		}

		isEven = new boolean[n];
		dontTakeEdge = new boolean[n][];
		for (int i = 0; i < n; i++) {
			isEven[i] = (edges[i].length & 1) == 0;
			dontTakeEdge[i] = new boolean[edges[i].length];
		}
		int[] p = randomPermutation(n);
		visited = new int[n];
		int time = 0;
		for (int u : p) {
			if (!isEven[u]) {
				continue;
			}
			visited[u] = ++time;
			findPath(u, -1);
		}

		boolean[] answer = restoreAnswer(n, m, from, to, edges, dontTakeEdge);
		return answer;
	}

	static void debug(Object... a) {
		System.err.println(deepToString(a));
	}

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(PROBLEM_ID
				+ ".in"));
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		int n = nextInt(br);
		int m = nextInt(br);
		int[] from = new int[m];
		int[] to = new int[m];
		for (int i = 0; i < m; i++) {
			from[i] = nextInt(br) - 1;
			to[i] = nextInt(br) - 1;
		}
		boolean[] answer = solve(n, m, from, to);
		if (answer == null) {
			out.println(-1);
		} else {
			int count = 0;
			for (boolean e : answer) {
				count += e ? 1 : 0;
			}
			out.println(count);
			boolean first = true;
			for (int i = 0; i < m; i++) {
				if (!answer[i]) {
					continue;
				}
				if (first) {
					first = false;
				} else {
					out.print(' ');
				}
				out.print(i + 1);
			}
			out.println();
		}
		out.close();
		br.close();
	}

}