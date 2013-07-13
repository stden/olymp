import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Random;
import java.util.StringTokenizer;

public class details_aa_floyd implements Runnable {

	public static void main(String[] args) {
		new Thread(new details_aa_floyd()).start();
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
		for (int k = 0; k < g.length; k++) {
			for (int i = 0; i < g.length; i++) {
				for (int j = 0; j < g.length; j++) {
					if (g[i][k] == 1 && g[k][j] == 1) {
						g[i][j] = 1;
					}
				}
			}
		}
		long ans = p[0];
		for (int i = 0; i < g[0].length; i++) {
			if (g[0][i] == 1) {
				ans += p[i];
			}
		}
		ArrayList<Integer> al = new ArrayList<Integer>();
		boolean[] u = new boolean[n];
		while (true) {
			int a = 0;
			for (int i = 0; i < g.length; i++) {
				if (g[0][i] == 1 && !u[i]) {
					boolean allZero = true;
					for (int j = 0; j < g[i].length; j++) {
						allZero &= g[i][j] == 0;
					}
					if (allZero) {
						a = i;
						break;
					}
				}
			}
			for (int i = 0; i < g.length; i++) {
				g[i][a] = 0;
			}
			al.add(a + 1);
			u[a] = true;
			if (a == 0) {
				break;
			}
		}
		out.println(ans + " " + al.size());
		for (int i : al) {
			out.print(i + " ");
		}
	}

}
