import static java.util.Arrays.deepToString;

import java.io.*;

public class odd_nn {
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

	static int[][] edges;
	static boolean[] was;
	static int[] parent;
	static boolean[] odd;

	static void dfs(int v, int p) {
		parent[v] = p;
		was[v] = true;
		odd[v] = true;
		for (int i : edges[v]) {
			if (was[i]) {
				continue;
			}
			dfs(i, v);
			odd[v] ^= odd[i];
		}
	}

	static boolean[] solve(int n, int m, int[] from, int[] to) {
		edges = getAdjacencyLists(n, m, from, to);
		was = new boolean[n];
		parent = new int[n];
		odd = new boolean[n];
		for (int root = 0; root < n; root++) {
			if (was[root]) {
				continue;
			}
			dfs(root, -1);
			if (odd[root]) {
				return null;
			}
		}
		boolean[] answer = new boolean[m];
		for (int i = 0; i < m; i++) {
			if (parent[from[i]] == to[i]) {
				answer[i] = odd[from[i]];
			}
			if (parent[to[i]] == from[i]) {
				answer[i] = odd[to[i]];
			}
		}
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
