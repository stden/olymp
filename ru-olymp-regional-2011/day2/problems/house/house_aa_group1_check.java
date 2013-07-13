import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_group1_check {
	public static void main(String[] args) {
		new house_aa_group1_check().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("house.in"));
			out = new PrintWriter("house.out");
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
		int n = nextInt();
		int maxx = Integer.MIN_VALUE;
		int maxy = Integer.MIN_VALUE;
		int minx = Integer.MAX_VALUE;
		int miny = Integer.MAX_VALUE;
		for (int i = 0; i < n; i++) {
			int x1 = nextInt();
			int y1 = nextInt();
			int x2 = nextInt();
			int y2 = nextInt();
			if (x1 == x2) {
				minx = Math.min(minx, x1);
				maxx = Math.max(maxx, x1);
			} else if (y1 == y2) {
				miny = Math.min(miny, y1);
				maxy = Math.max(maxy, y1);
			} else {
				myAssert(false, "Wrong line " + x1 + " " + y1 + " " + x2 + " "
						+ y2);
			}
		}
		out.println((minx + maxx) / 2.0 + " " + (miny + maxy) / 2.0);
	}

}
