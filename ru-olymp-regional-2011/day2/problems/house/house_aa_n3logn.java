import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_n3logn {
	public static void main(String[] args) {
		new house_aa_n3logn().run();
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

	final static private int MAX = 10000;

	private void solve() throws IOException {
		int n = nextInt();
		double[] a = new double[n];
		double[] b = new double[n];
		double[] c = new double[n];
		for (int i = 0; i < a.length; i++) {
			int x1 = inBounds(nextInt(), -MAX, MAX, "x1_" + (i + 1));
			int y1 = inBounds(nextInt(), -MAX, MAX, "y1_" + (i + 1));
			int x2 = inBounds(nextInt(), -MAX, MAX, "x2_" + (i + 1));
			int y2 = inBounds(nextInt(), -MAX, MAX, "y2_" + (i + 1));
			a[i] = y1 - y2;
			b[i] = x2 - x1;
			double d = Math.sqrt(a[i] * a[i] + b[i] * b[i]);
			if (a[i] < -eps || (Math.abs(a[i]) < eps && b[i] < -eps)) {
				d = -d;
			}
			a[i] /= d;
			b[i] /= d;
			c[i] = -a[i] * x1 - b[i] * y1;
		}
		if (n == 1) {
			double x = -a[0] * c[0];
			double y = -b[0] * c[0];
			out.println(x + " " + y);
			return;
		}
		double l = 0;
		double r = 1 << 15;
		Point lastGood = null;
		for (int step = 0; step < 50; step++) {
			double d = (l + r) / 2;
			ArrayList<Point> al = new ArrayList<Point>();
			for (int i = 0; i < a.length; i++) {
				double a1 = a[i];
				double b1 = b[i];
				for (int ii = -1; ii <= 1; ii += 2) {
					double c1 = c[i] + ii * d;
					for (int j = 0; j < i; j++) {
						double a2 = a[j];
						double b2 = b[j];
						for (int jj = -1; jj <= 1; jj += 2) {
							double c2 = c[j] + jj * d;
							addCross(al, a1, b1, c1, a2, b2, c2);
						}
					}
				}
			}
			boolean good = false;
			for (Point p : al) {
				double max = 0;
				for (int i = 0; i < a.length; i++) {
					max = Math.max(max,
							Math.abs(a[i] * p.x + b[i] * p.y + c[i]));
				}
				if (Math.abs(d - max) / Math.max(1, d) <= 2.1 * eps) {
					lastGood = p;
					good = true;
					break;
				}
			}
			if (good) {
				r = d;
			} else {
				l = d;
			}
		}
		out.println(lastGood.x + " " + lastGood.y);
		// System.out.println(r);
	}

	private final static double eps = 1e-7;

	private void addCross(ArrayList<Point> al, double a1, double b1, double c1,
			double a2, double b2, double c2) {
		double d = a1 * b2 - a2 * b1;
		if (Math.abs(d) < eps) {
			al.add(new Point(-a1 * (c1 + c2) / 2, -b1 * (c1 + c2) / 2));
		} else {
			double x = -(c1 * b2 - c2 * b1) / d;
			double y = -(a1 * c2 - a2 * c1) / d;
			al.add(new Point(x, y));
		}
	}

	class Point {
		public Point(double d, double e) {
			x = d;
			y = e;

		}

		double x, y;
	}
}
