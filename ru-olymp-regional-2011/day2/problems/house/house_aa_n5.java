import java.io.*;
import java.util.*;
import java.math.*;

public class house_aa_n5 {
	public static void main(String[] args) {
		new house_aa_n5().run();
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
		Line[] a = new Line[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = new Line(nextInt(), nextInt(), nextInt(), nextInt());
		}
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < i; j++) {
				equalDist(a[i], a[j]);
			}
		}
		for (int i = 0; i < al.size(); i++) {
			Line l1 = al.get(i);
			for (int j = 0; j < i; j++) {
				Line l2 = al.get(j);
				cross(l1, l2);
			}
			points.add(new Point(l1.x0, l1.y0));
		}
		Point best = null;
		double ans = Double.POSITIVE_INFINITY;
		for (Point p : points) {
			double max = 0;
			for (Line l : a) {
				max = Math.max(max, Math.abs(l.a * p.x + l.b * p.y + l.c));
			}
			if (max < ans) {
				ans = max;
				best = p;
			}
		}
		out.println(best.x + " " + best.y);
	}

	private void cross(Line l1, Line l2) {
		double d = l1.a * l2.b - l2.a * l1.b;
		if (Math.abs(d) < eps) {
			return;
		}
		double x0 = -(l1.c * l2.b - l2.c * l1.b) / d;
		double y0 = -(l1.a * l2.c - l2.a * l1.c) / d;
		points.add(new Point(x0, y0));
	}

	ArrayList<Point> points = new ArrayList<Point>();

	class Point {
		public Point(double x0, double y0) {
			x = x0;
			y = y0;
		}

		double x, y;
	}

	private void equalDist(Line l1, Line l2) {
		double d = l1.a * l2.b - l2.a * l1.b;
		if (Math.abs(d) < eps) {
			double a = l1.a;
			double b = l1.b;
			double c = (l1.c + l2.c) / 2;
			double x0 = -a * c;
			double y0 = -b * c;
			double x1 = x0 + b;
			double y1 = y0 - a;
			al.add(new Line(x0, y0, x1, y1));
		} else {
			double x0 = -(l1.c * l2.b - l2.c * l1.b) / d;
			double y0 = -(l1.a * l2.c - l2.a * l1.c) / d;
			double x1 = x0 + l1.dx + l2.dx;
			double y1 = y0 + l1.dy + l2.dy;
			double x2 = x0 + l1.dx - l2.dx;
			double y2 = y0 + l1.dy - l2.dy;
			al.add(new Line(x0, y0, x1, y1));
			al.add(new Line(x0, y0, x2, y2));
		}
	}

	ArrayList<Line> al = new ArrayList<Line>();

	double eps = 1e-7;

	class Line {
		public Line(double x02, double y02, double x1, double y1) {
			a = y02 - y1;
			b = x1 - x02;
			double d = Math.sqrt(a * a + b * b);
			if (a < -eps || (Math.abs(a) < eps && b < -eps)) {
				d = -d;
			}
			a /= d;
			b /= d;
			dx = b;
			dy = -a;
			x0 = x02;
			y0 = y02;
			c = -x0 * a - y0 * b;
		}

		double a, b, c;
		double x0, y0, dx, dy;
	}

}
