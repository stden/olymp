import java.io.*;
import java.util.*;
import java.math.*;

public class shooting_aa {
	public static void main(String[] args) {
		new shooting_aa().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("shooting.in"));
			out = new PrintWriter("shooting.out");
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
		int n = inBounds(nextInt(), 3, 100000, "n");
		int[] a = new int[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = inBounds(nextInt(), 1, 1000, "a_" + (i + 1));
		}
		int max = 0;
		for (int i = 0; i < a.length; i++) {
			max = Math.max(max, a[i]);
		}
		boolean m = false;
		int fm = 0;
		for (int i = 0; i + 1 < a.length; i++) {
			if (m && a[i] % 10 == 5 && a[i] > a[i + 1]) {
				fm = Math.max(fm, a[i]);
			}
			if (a[i] == max) {
				m = true;
			}
		}
		if (fm == 0) {
			out.println("0");
			return;
		}
		int bigger = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] > fm) {
				bigger++;
			}
		}
		out.println(bigger + 1);
	}

}
