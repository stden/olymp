import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.StringTokenizer;
import java.util.TreeSet;

public class rag_vd {
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

		long a, b, c;
			

		public Segment(Point st1, Point en1) {
			if (en1.y > st1.y) {
				st = en1;
				en = st1;
			} else {
				st = st1;
				en = en1;
			}
			a = en.y - st.y;
		        b = st.x - en.x;
			c = -a * st.x - b * st.y;
		}

		public int compareTo(Segment o) {                                
			return Long.signum(o.a * (-b * gy - c) - (-o.b * gy - o.c) * a);
		}

		double inter(int y) {
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
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for (int i = 0; i < arr.size(); i++) {
			map.put(arr.get(i), i);
		}
		ArrayList<Segment>[] rem = new ArrayList[arr.size()];
		ArrayList<Segment>[] add = new ArrayList[arr.size()];
		for (int i = 0; i < arr.size(); i++) {
			rem[i] = new ArrayList<Segment>();
			add[i] = new ArrayList<Segment>();
		}
		for (int i = 0; i < n - 1; i++) {
			if (x[i].st.y != x[i].en.y) {
				int ind = map.get((int) x[i].st.y);
				rem[ind].add(x[i]);
				ind = map.get((int) x[i].en.y);
				add[ind].add(x[i]);
			}
		}

		TreeSet<Segment> tree = new TreeSet<Segment>();

		double s = 0;
		for (int i = 0; i < arr.size() - 1; i++) {
			for (Segment e : rem[i]) {
				tree.remove(e);
			}
			gy = (arr.get(i) + arr.get(i + 1)) / 2;
			for (Segment e : add[i]) {
				tree.add(e);
			}
			if (tree.size() % 2 != 0) {
              			Segment opt = tree.last();
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
		new rag_vd().run();
	}

}