import static java.util.Arrays.deepToString;
import static java.util.Arrays.fill;

import java.io.*;
import java.util.*;

public class odd_nn_ok2 {
	static final String PROBLEM_ID;

	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	static StringTokenizer st;

	static int nextInt(BufferedReader br) throws IOException {
		while (st == null || !st.hasMoreTokens()) {
			String line = br.readLine();
			if (line == null) {
				return Integer.MIN_VALUE;
			}
			st = new StringTokenizer(line);
		}
		return Integer.parseInt(st.nextToken());
	}

	static List<Integer>[] edges;
	static boolean[] was;
	static int[] parent;
	static boolean[] odd;

	static void dfs(int v, int p) {
		parent[v] = p;
		was[v] = true;
		odd[v] = (edges[v].size() & 1) == 0;
		for (int i : edges[v]) {
			if (was[i]) {
				continue;
			}
			dfs(i, v);
			odd[v] ^= odd[i];
		}
	}

	static boolean[] solve(int n, int m, int[] from, int[] to) {
		edges = new List[n];
		for (int i = 0; i < n; i++) {
			edges[i] = new ArrayList<Integer>();
		}
		for (int i = 0; i < m; i++) {
			edges[from[i]].add(to[i]);
			edges[to[i]].add(from[i]);
		}
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
		fill(answer, true);
		for (int i = 0; i < m; i++) {
			if (parent[from[i]] == to[i]) {
				answer[i] = !odd[from[i]];
			}
			if (parent[to[i]] == from[i]) {
				answer[i] = !odd[to[i]];
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
