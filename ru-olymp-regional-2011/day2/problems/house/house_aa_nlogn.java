import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_nlogn {
	public static void main(String[] args) {
		new house_aa_nlogn().run();
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
		int n = inBounds(nextInt(), 1, 100000, "n");
		SemiPlane[] a = new SemiPlane[n];
		for (int i = 0; i < n; i++) {
			a[i] = nextSemiPlane();
			a[i].positive();
		}
		Arrays.sort(a);
		{
			ArrayList<SemiPlane> tmp = new ArrayList<house_aa_nlogn.SemiPlane>();
			for (int i = 0; i < a.length; i++) {
				if (i == 0 || a[i].compareTo(a[i - 1]) != 0) {
					tmp.add(a[i]);
				}
			}
			n = tmp.size();
			a = new SemiPlane[n];
			for (int i = 0; i < a.length; i++) {
				a[i] = tmp.get(i);
			}
			if (n == 1) {
				out.println(a[0].x0 + " " + a[0].y0);
				return;
			}
		}
		boolean allPar = true;
		for (int i = 1; i < a.length; i++) {
			allPar &= Math.abs(a[i].a - a[i - 1].a) < 1e-9
					&& Math.abs(a[i].b - a[i - 1].b) < 1e-9;
		}
		if (allPar) {
			double aa = a[0].a;
			double bb = a[0].b;
			double cmin = Double.POSITIVE_INFINITY;
			double cmax = Double.NEGATIVE_INFINITY;
			for (int i = 0; i < a.length; i++) {
				cmin = Math.min(cmin, a[i].c);
				cmax = Math.max(cmax, a[i].c);
			}
			double c = (cmin + cmax) / 2;
			out.println(-aa * c + " " + -bb * c);
			return;
		}
		double l = 0;
		double r = 1 << 16;
		int top = 0;
		SemiPlane[] stack = new SemiPlane[4 * n + 4];
		double[] t = new double[4 * n + 4];
		double ax = Double.NaN;
		double ay = Double.NaN;
		SemiPlane[] buff = new SemiPlane[2 * a.length];
		for (int i = 0; i < a.length; i++) {
			buff[2 * i] = new SemiPlane(a[i].a, a[i].b, a[i].c);
			buff[2 * i + 1] = new SemiPlane(-a[i].a, -a[i].b, -a[i].c);
		}
		SemiPlane[] al = new SemiPlane[2 * a.length];
		for (int i = 0; i < a.length; i++) {
			al[2 * i] = buff[2 * i];
			al[2 * i + 1] = buff[2 * i + 1];
		}
		Arrays.sort(al, 0, 2 * a.length);
		for (int step = 0; step < 50; step++) {
			double d = (l + r) / 2;
			for (int i = 0; i < a.length; i++) {
				buff[2 * i].changeC(a[i].c - d);
				buff[2 * i + 1].changeC(-a[i].c - d);
			}
			top = 0;
			loop: for (SemiPlane s : al) {
				while (top - 1 >= 0) {
					SemiPlane ss = stack[top - 1];
					double tt = ss.cross(s);
					if (Double.isInfinite(tt) && tt > 0) {
						continue loop;
					}
					if (tt <= t[top - 1]) {
						top--;
					} else {
						break;
					}
				}
				stack[top] = s;
				t[top] = top > 0 ? s.cross(stack[top - 1])
						: Double.NEGATIVE_INFINITY;
				top++;
			}
			int ttop = top;
			ff: for (int i = 0; i < ttop; i++) {
				SemiPlane s = stack[i];
				while (top - 1 >= 0) {
					SemiPlane ss = stack[top - 1];
					double tt = ss.cross(s);
					if (Double.isInfinite(tt) && tt > 0) {
						continue ff;
					}
					if (tt <= t[top - 1]) {
						top--;
					} else {
						break;
					}
				}
				stack[top] = s;
				t[top] = top > 0 ? s.cross(stack[top - 1])
						: Double.NEGATIVE_INFINITY;
				top++;
			}
			double x1 = stack[top - 1].x0 + stack[top - 1].dx * t[top - 1];
			double y1 = stack[top - 1].y0 + stack[top - 1].dy * t[top - 1];
			double max = 0;
			for (int i = 0; i < a.length; i++) {
				max = Math.max(max,
						Math.abs(a[i].a * x1 + a[i].b * y1 + a[i].c));
			}
			if (Math.abs(d - max) / Math.max(1, d) <= 2.1 * eps) {
				ax = x1;
				ay = y1;
				r = d;
				continue;
			}
			l = d;
		}
		out.println(ax + " " + ay);
	}

	private SemiPlane nextSemiPlane() {
		int x1 = inBounds(nextInt(), -10000, 10000, "x1");
		int y1 = inBounds(nextInt(), -10000, 10000, "y1");
		int x2 = inBounds(nextInt(), -10000, 10000, "x2");
		int y2 = inBounds(nextInt(), -10000, 10000, "y2");
		double a = y2 - y1;
		double b = x1 - x2;
		double d = Math.sqrt(a * a + b * b);
		a /= d;
		b /= d;
		double angle = Math.atan2(b, a);
		if (angle > 0) {
			a = -a;
			b = -b;
		}
		double c = -a * x1 - b * y1;
		return new SemiPlane(a, b, c);
	}

	double eps = 1e-7;

	class SemiPlane implements Comparable<SemiPlane> {
		double a, b, c;
		double angle;
		double x0, y0, dx, dy;

		public SemiPlane(double a2, double b2, double c2) {
			a = a2;
			b = b2;
			c = c2;
			angle = -Math.atan2(b, a);
			if (angle < -Math.PI + eps) {
				angle = Math.PI;
			}
			x0 = -a * c;
			y0 = -b * c;
			dx = b;
			dy = -a;
		}

		public void positive() {
			if (a < -eps || (Math.abs(a) < eps && b < -eps)) {
				a = -a;
				b = -b;
				c = -c;
				dx = -dx;
				dy = -dy;
			}
		}

		public void changeC(double d) {
			c = d;
			x0 = -a * c;
			y0 = -b * c;
		}

		public double cross(SemiPlane s) {
			double d = (s.a * dx + s.b * dy);
			if (Math.abs(d) < 1e-12) {
				if (a * s.x0 + b * s.y0 + c > 0) {
					return Double.POSITIVE_INFINITY;
				} else {
					return Double.NEGATIVE_INFINITY;
				}
			}
			return -(s.c + s.a * x0 + s.b * y0) / d;
		}

		@Override
		public int compareTo(SemiPlane o) {
			if (Math.abs(angle - o.angle) < eps) {
				if (Math.abs(a - o.a) < eps) {
					if (Math.abs(b - o.b) < eps) {
						if (Math.abs(c - o.c) < eps) {
							return 0;
						}
						return c < o.c ? -1 : 1;
					}
					return b < o.b ? -1 : 1;
				}
				return a < o.a ? -1 : 1;
			}
			return angle < o.angle ? -1 : 1;
		}
	}

}
