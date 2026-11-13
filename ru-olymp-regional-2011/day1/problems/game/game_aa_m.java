import java.io.*;
import java.util.*;
import java.math.*;

public class game_aa_m {
	public static void main(String[] args) {
		new game_aa_m().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("game.in"));
			out = new PrintWriter("game.out");
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
		myAssert(l <= x && x <= r, name + " = " + x + " is not in [" + l + ".."
				+ r + "]");
		return x;
	}

	private void solve() throws IOException {
		int n = inBounds(nextInt(), 1, 10000, "n");
		int m = inBounds(nextInt(), 1, 100000, "m");
		int k = inBounds(nextInt(), 1, 100000, "k");
		int[] a = new int[m + 1];
		Arrays.fill(a, Integer.MAX_VALUE / 2);
		a[0] = 0;
		for (int i = 0; i + 1 < a.length; i++) {
			a[i + 1] = Math.min(a[i + 1], a[i] + 1);
			if (i + k < a.length) {
				a[i + k] = Math.min(a[i + k], a[i] + 1);
			}
		}
		int max = 0;
		for (int i = 0; i < a.length; i++) {
			max = Math.max(max, a[i]);
		}
		out.println(max * n);
	}

}
