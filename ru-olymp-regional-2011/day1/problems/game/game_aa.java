import java.io.*;
import java.util.*;
import java.math.*;

public class game_aa {
	public static void main(String[] args) {
		new game_aa().run();
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
		long n = inBounds(nextInt(), 1, 10000, "n");
		long m = inBounds(nextInt(), 1, 100000, "m");
		long k = inBounds(nextInt(), 1, 100000, "k");
		if (m < k) {
			out.println(n * m);
			return;
		}
		long ans = n * (k - 1 + m / k);
		out.println(ans);
	}

}
