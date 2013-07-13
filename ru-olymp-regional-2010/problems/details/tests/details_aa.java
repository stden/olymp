import java.io.*;
import java.util.*;

public class details_aa implements Runnable {

	public static void main(String[] args) {
		new Thread(new details_aa()).start();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;
	Random rand = new Random(this.hashCode());

	@Override
	public void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader(FNAME + ".in"));
			out = new PrintWriter(FNAME + ".out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (Exception e) {
				eof = true;
				return "0";
			}
		}
		return st.nextToken();
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	void myAssert(boolean u, String message) {
		if (!u) {
			throw new Error("Assertion failed!!! " + message);
		}
	}

	int inBounds(int x, int l, int r, String name) {
		myAssert(l <= x && x <= r, name + " not in bounds!!! " + x
				+ " not in [" + l + ".." + r + "]");
		return x;
	}

	String FNAME = "details";

	private void solve() throws IOException {
		int n = inBounds(nextInt(), 1, 100000, "n");
		long[] p = new long[n];
		for (int i = 0; i < p.length; i++) {
			p[i] = inBounds(nextInt(), 1, 1000000000, "p[" + (i + 1) + "]");
		}
		int sk = 0;
		int[][] g = new int[n][];
		for (int i = 0; i < g.length; i++) {
			g[i] = new int[nextInt()];
			sk += g[i].length;
			for (int j = 0; j < g[i].length; j++) {
				g[i][j] = inBounds(nextInt(), 1, n, "g[" + (i + 1) + "]["
						+ (j + 1) + "]") - 1;
			}
		}
		inBounds(sk, 0, 200000, "sum of Ks");
		int[] u = new int[n];
		dfs(g, u, 0);
		long ans = 0;
		for (int i = 0; i < u.length; i++) {
			if (u[i] == 1) {
				ans += p[i];
			}
		}
		Arrays.fill(u, 0);
		int[] t = new int[n];
		Arrays.fill(t, -1);
		topsort(0, t, g, u);
		int[] a = new int[n];
		int k = 0;
		for (int i = 0; i < t.length; i++) {
			if (t[i] >= 0) {
				a[t[i]] = i;
				k++;
			}
		}
		out.println(ans + " " + k);
		for (int i = 0; i < k; i++) {
			out.print(a[i] + 1 + " ");
		}
	}

	private void topsort(int x, int[] t, int[][] g, int[] u) {
		u[x] = 1;
		for (int i : g[x]) {
			myAssert(u[i] != 1, "there are loops!!!");
			if (u[i] == 0) {
				topsort(i, t, g, u);
			}
		}
		u[x] = 2;
		t[x] = time++;
	}

	int time = 0;

	private void dfs(int[][] g, int[] u, int x) {
		u[x] = 1;
		for (int i : g[x]) {
			if (u[i] == 0) {
				dfs(g, u, i);
			}
		}
	}

}
