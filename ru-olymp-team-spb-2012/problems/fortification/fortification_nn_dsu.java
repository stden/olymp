import static java.util.Arrays.fill;

import java.io.*;

/**
 * Correct solution, that uses Disjoint Set Union.
 * 
 * @author niyaz.nigmatullin
 *
 */
public class fortification_nn_dsu {

	static final int MOD = 1000000007;
	static final String PROBLEM_ID;
	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	static int nextInt(BufferedReader br) throws IOException {
		int c = br.read();
		while (c <= 32) {
			c = br.read();
		}
		int ret = 0;
		while (c >= '0' && c <= '9') {
			ret = ret * 10 + c - '0';
			c = br.read();
		}
		return ret;
	}

	static int solve(int n, int[] from, int[] to) {
		DSU dsu = new DSU(n);
		for (int i = 0; i < from.length; i++) {
			dsu.union(from[i], to[i]);
		}
		int answer = 1;
		for (int i = 0; i < n; i++) {
			if (dsu.get(i) != i) {
				continue;
			}
			if (dsu.v[i] == dsu.e[i]) {
				answer = (int) ((long) answer * dsu.v[i] % MOD);
			}
		}
		return answer;
	}

	static class DSU {
		int[] p;
		int[] v;
		int[] e;

		public DSU(int n) {
			p = new int[n];
			v = new int[n];
			e = new int[n];
			fill(v, 1);
			for (int i = 0; i < n; i++) {
				p[i] = i;
			}
		}

		int get(int x) {
			return x == p[x] ? x : (p[x] = get(p[x]));
		}

		void union(int x, int y) {
			x = get(x);
			y = get(y);
			if (x != y) {
				e[y] += e[x];
				v[y] += v[x];
			}
			e[y]++;
			p[x] = y;
		}

	}

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(PROBLEM_ID
				+ ".in"));
		int n = nextInt(br);
		int m = nextInt(br);
		int[] from = new int[m];
		int[] to = new int[m];
		for (int i = 0; i < m; i++) {
			from[i] = nextInt(br) - 1;
			to[i] = nextInt(br) - 1;
		}
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		out.println(solve(n, from, to));
		out.close();
	}
}
