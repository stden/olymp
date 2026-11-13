import java.io.*;
import java.util.*;
import java.math.*;

public class chess_aa_right {
	public static void main(String[] args) {
		new chess_aa_right().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("chess.in"));
			out = new PrintWriter("chess.out");
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
		int m = inBounds(nextInt(), 1, 1000000000, "m");
		int n = inBounds(nextInt(), 1, 1000000000, "n");
		int i = inBounds(nextInt(), 1, m, "i");
		int j = inBounds(nextInt(), 1, n, "j");
		int c = inBounds(nextInt(), 0, 1, "c");
		if (n * m % 2 == 0) {
			out.println("equal");
			return;
		}
		out.println((((i + j) % 2) ^ c) == 0 ? "black" : "white");
	}

}
