import static java.util.Arrays.deepToString;

import java.io.*;
import java.util.Random;

public class odd_nn_tl3 {
	static final String PROBLEM_ID;
	static final Random rand = new Random(58);

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

	static boolean dfs(int v) {
		was[v] = true;
		boolean odd = true;
		for (int i : edges[v]) {
			if (was[i]) {
				continue;
			}
			odd ^= dfs(i);
		}
		return odd;
	}

	static boolean[] solve(int n, int m, int[] from, int[] to) {
		edges = getAdjacencyLists(n, m, from, to);
		was = new boolean[n];
		for (int i = 0; i < n; i++) {
			if (was[i]) {
				continue;
			}
			if (dfs(i)) {
				return null;
			}
		}
		int[] p = randomPermutation(m);
		boolean[] odd = new boolean[n];
		for (int i = 0; i < m; i++) {
			odd[from[i]] ^= true;
			odd[to[i]] ^= true;
		}
		boolean[] removeEdge = new boolean[m];
		while (true) {
			shuffle(p);
			boolean ok = false;
			for (int i = 0; i < n; i++) {
				if (!odd[i]) {
					ok = true;
					break;
				}
			}
			if (!ok) {
				break;
			}
			for (int i : p) {
				if (!odd[from[i]] || !odd[to[i]]) {
					removeEdge[i] ^= true;
					odd[from[i]] ^= true;
					odd[to[i]] ^= true;
				}
			}
		}
		for (int i = 0; i < m; i++) {
			removeEdge[i] ^= true;
		}
		return removeEdge;
	}

	static int[] randomPermutation(int n) {
		int[] ret = new int[n];
		for (int i = 0; i < n; i++) {
			ret[i] = i;
		}
		shuffle(ret);
		return ret;
	}

	static void shuffle(int[] a) {
		for (int i = 0; i < a.length; i++) {
			int j = rand.nextInt(i + 1);
			int t = a[i];
			a[i] = a[j];
			a[j] = t;
		}
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
