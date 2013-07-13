import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.StringTokenizer;

public class rag_vd_slow {
	BufferedReader in;
	StringTokenizer str;
	PrintWriter out;
	String SK;

	String next() throws IOException {
		while ((str == null) || (!str.hasMoreTokens())) {
			SK = in.readLine();
			if (SK == null)
				return null;
			str = new StringTokenizer(SK);
		}
		return str.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(next());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(next());
	}

	long nextLong() throws IOException {
		return Long.parseLong(next());
	}

	class Point {
		long x, y;

		public Point(long x1, long y1) {
			x = x1;
			y = y1;
		}
	}

	long gy = 0;

	class Segment implements Comparable<Segment> {
		Point st;
		Point en;

		public Segment(Point st1, Point en1) {
			if (en1.y > st1.y) {
				st = en1;
				en = st1;
			} else {
				st = st1;
				en = en1;
			}
		}

		public int compareTo(Segment o) {
			long a = en.y - st.y;
			long b = st.x - en.x;
			long c = -a * st.x - b * st.y;

			long a1 = o.en.y - o.st.y;
			long b1 = o.st.x - o.en.x;
			long c1 = -a1 * o.st.x - b1 * o.st.y;
			return Long.signum(a1 * (-b * gy - c) - (-b1 * gy - c1) * a);
		}

		double inter(int y) {
			long a = en.y - st.y;
			long b = st.x - en.x;
			long c = -a * st.x - b * st.y;
			return 1.0 * (-b * y - c) / a;
		}
	}

	void solve() throws IOException {
		int w = 2 * nextInt();
		int h = 2 * nextInt();
		int n = nextInt();
		Point[] a = new Point[n];
		Segment[] x = new Segment[n - 1];
		HashSet<Integer> was = new HashSet<Integer>();
		ArrayList<Integer> arr = new ArrayList<Integer>();
		for (int i = 0; i < n; i++) {
			a[i] = new Point(2 * nextInt(), 2 * nextInt());
			if (i > 0) {
				x[i - 1] = new Segment(a[i], a[i - 1]);
			}
			if (!was.contains((int) a[i].y)) {
				arr.add((int) a[i].y);
				was.add((int) a[i].y);
			}
		}
		Collections.sort(arr);
		double s = 0;
		for (int i = 0; i < arr.size() - 1; i++) {
			gy = (arr.get(i) + arr.get(i + 1)) / 2;
			Segment opt = null;
			int k = 0;
			for (int j = 0; j < n - 1; j++) {
				if (x[j].st.y > gy && x[j].en.y < gy) {
					if (opt == null || opt.compareTo(x[j]) < 0) {
						opt = x[j];
					}
					k++;
				}
			}
			if (k % 2 != 0) {
				s += Math.abs((arr.get(i) - arr.get(i + 1))
						* (w - opt.inter(arr.get(i)) + w - opt.inter(arr
								.get(i + 1))) / 2);
			}
		}
		out.println(s / 4);
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("rag.in"));
		out = new PrintWriter("rag.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new rag_vd_slow().run();
	}

}