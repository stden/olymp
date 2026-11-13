import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_group2 {
	public static void main(String[] args) {
		new house_aa_group2().run();
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
			a = y1 - y2;
			b = x2 - x1;
			double d = Math.sqrt(a * a + b * b);
			if (y1 < y2 || y1 == y2 && x2 < x1) {
				d = -d;
			}
			a /= d;
			b /= d;
			double c = -a * x1 - b * y1;
			cmin = Math.min(cmin, c);
			cmax = Math.max(cmax, c);
		}
		double c = (cmin + cmax) / 2;
		out.println(-a * c + " " + -b * c);
	}

}
