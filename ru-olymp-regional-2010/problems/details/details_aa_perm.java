import java.io.*;
import java.util.*;
import java.math.*;

public class details_aa_perm implements Runnable {

	public static void main(String[] args) {
		new Thread(new details_aa_perm()).start();
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
		int[][] g = new int[n][n];
		for (int i = 0; i < g.length; i++) {
			int k = inBounds(nextInt(), 0, n - 1, "k[" + (i + 1) + "]");
			sk += k;
			for (int j = 0; j < k; j++) {
				g[i][inBounds(nextInt(), 1, n, "g[" + (i + 1) + "][" + (j + 1)
						+ "]") - 1] = 1;
			}
		}
		inBounds(sk, 0, 200000, "sum of Ks");
		int[] a = new int[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = i;
		}
		int[] ans = a.clone();
		long min = Long.MAX_VALUE;
		while (true) {
			// System.out.println(Arrays.toString(a));
			boolean good = true;
			for (int i = 0; i < ans.length; i++) {
				for (int j = 0; j < i; j++) {
					if (g[a[j]][a[i]] == 1) {
						good = false;
						break;
					}
				}
			}
			if (good) {
				long x = 0;
				for (int i = 0; i < ans.length; i++) {
					x += p[a[i]];
					if (a[i] == 0) {
						break;
					}
				}
				if (x < min) {
					min = x;
					ans = a.clone();
				}
			}
			if (!next(a)) {
				break;
			}
		}
		int k = 0;
		for (int i = 0; i < ans.length; i++) {
			k++;
			if (ans[i] == 0) {
				break;
			}
		}
		out.println(min + " " + k);
		for (int i = 0; i < k; i++) {
			out.print(ans[i] + 1 + " ");
		}
	}

	private boolean next(int[] a) {
		boolean[] q = new boolean[a.length];
		int k = a.length - 1;
		while (k > 0 && a[k] < a[k - 1]) {
			q[a[k--]] = true;
		}
		if (k == 0) {
			return false;
		}
		q[a[k]] = true;
		q[a[k - 1]] = true;
		int j = a[k - 1] + 1;
		while (!q[j]) {
			j++;
		}
		a[k - 1] = j;
		q[j] = false;
		j = 0;
		for (int i = k; i < a.length; i++) {
			while (!q[j]) {
				j++;
			}
			a[i] = j;
			q[j] = false;
		}
		return true;
	}

}
