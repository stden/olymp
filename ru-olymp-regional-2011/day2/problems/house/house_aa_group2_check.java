import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_group2_check {
	public static void main(String[] args) {
		new house_aa_group2_check().run();
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
		double a = 0;
		double b = 0;
		double cmin = Double.POSITIVE_INFINITY;
		double cmax = Double.NEGATIVE_INFINITY;
		for (int i = 0; i < n; i++) {
			int x1 = nextInt();
			int y1 = nextInt();
			int x2 = nextInt();
			int y2 = nextInt();
			double aa = a;
			double bb = b;
			a = y1 - y2;
			b = x2 - x1;
			double d = Math.sqrt(a * a + b * b);
			if (y1 < y2 || y1 == y2 && x2 < x1) {
				d = -d;
			}
			a /= d;
			b /= d;
			if (i > 0) {
				myAssert(Math.abs(a - aa) < 1e-7 && Math.abs(b - bb) < 1e-7,
						(i + 1) + "th line is not parallel");
			}
			double c = -a * x1 - b * y1;
			cmin = Math.min(cmin, c);
			cmax = Math.max(cmax, c);
		}
		double c = (cmin + cmax) / 2;
		out.println(-a * c + " " + -b * c);
	}

}
