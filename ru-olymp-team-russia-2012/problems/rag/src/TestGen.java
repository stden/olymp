import java.io.*;
import java.util.*;

public class TestGen {
	public static void main(String[] args) {
		new TestGen().run();
	}

	BufferedReader br;
	StringTokenizer in;
	PrintWriter out;

	public String nextToken() throws IOException {
		while (in == null || !in.hasMoreTokens()) {
			in = new StringTokenizer(br.readLine());
		}
		return in.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	int tNumber;

	Random rnd = new Random(239);

	Point[] toPoint(int[][] a) {
		int n = a.length;
		Point[] p = new Point[n];
		for (int i = 0; i < n; i++) {
			p[i] = new Point(a[i][0], a[i][1]);
		}
		return p;
	}

	class Test {
		Point[] a;
		long w, h;

		public Test(Point[] a, int w, int h) {
			int minx = w;
			int miny = h;
			for (int i = 0; i < a.length; i++) {
				minx = (int) Math.min(minx, a[i].x);
				miny = (int) Math.min(miny, a[i].y);
			}
			w = w - minx + 1;
			h = h - miny + 1;
			this.a = new Point[a.length];
			for (int i = 0; i < a.length; i++) {
				this.a[i] = new Point(a[i].x - minx + 1, a[i].y - miny + 1);
			}
			this.w = w;
			this.h = h;
		}
	}

	ArrayList<Test> small = new ArrayList<Test>();

	void printp(Point[] a, int n, int m) throws IOException {
		if (a.length < 200 && n < 4000) {
			small.add(new Test(a, n, m));
		}
		if (tNumber < 10) {
			out = new PrintWriter("../tests/0" + tNumber);
		} else {
			out = new PrintWriter("../tests/" + tNumber);
		}
		out.println(n + " " + m);
		out.println(a.length);
		for (int i = 0; i < a.length; i++) {
			out.println(a[i]);
		}
		out.close();
		tNumber++;
	}

	Point[] gen(Point[] a, int st, int en) {
		int n = a.length;
		Point[] p = new Point[n];
		int t = 0;
		// System.err.println(st + " " + en);
		for (int i = 0; i < st; i++) {
			p[t++] = a[i];
		}
		for (int i = en; i >= st; --i) {
			p[t++] = a[i];
		}
		for (int i = en + 1; i < n; i++) {
			p[t++] = a[i];
		}
		return p;
	}

	Point[] del(Point[] a, int d) {
		int n = a.length;
		Point[] p = new Point[n - 1];
		int t = 0;
		// System.err.println(st + " " + en);
		for (int i = 0; i < d; i++) {
			p[t++] = a[i];
		}
		for (int i = d + 1; i < n; i++) {
			p[t++] = a[i];
		}
		return p;
	}

	void genrandom(int h, int w, int n) throws IOException {
		System.err.println("Generate Random Test");
		HashSet<Point> p = new HashSet<Point>();
		Point[] a = new Point[n];
		Point[] old = new Point[n];
		for (int i = 0; i < n; i++) {
			a[i] = new Point(rnd.nextInt(h - 1) + 1, rnd.nextInt(w - 1) + 1);
			if (i == 0) {
				a[i].y = w;
			}
			if (i == n - 1) {
				a[i].x = h;
			}
			while (p.contains(a[i])
					|| ((i >= 2) && new Segment(a[i - 2], a[i - 1], 1)
							.inter(new Segment(a[i], a[i - 1], 0)))) {
				a[i] = new Point(rnd.nextInt(h) + 1, rnd.nextInt(w) + 1);
				if (i == 0) {
					a[i].y = w;
				}
				if (i == n - 1) {
					a[i].x = h;
				}
			}
			p.add(a[i]);
			old[i] = new Point(a[i].x, a[i].y);
		}

		while (true) {
			Segment[] x = checkPolygon(a);
			if (x == null) {
				break;
			}
			n = a.length;
			int[] num = new int[4];
			for (int i = 0; i < n; i++) {
				if (x[0].p1 == a[i]) {
					num[0] = i;
				}
				if (x[0].p2 == a[i]) {
					num[1] = i;
				}
				if (x[1].p1 == a[i]) {
					num[2] = i;
				}
				if (x[1].p2 == a[i]) {
					num[3] = i;
				}
			}
			Arrays.sort(num);
			if (num[1] == num[2]) {
				a = del(a, num[1]);
			} else {
				a = gen(a, num[1], num[2]);
			}
		}
		printp(a, h, w);
	}

	public void genspiral(int w, int h, int n) throws IOException {
		n = n ^ 1;
		Point[] p = new Point[n];
		p[0] = new Point(w - 1, h);
		p[n - 1] = new Point(w, rnd.nextInt(h - 4) + 1);
		int st = 1;
		int minx = 1;
		int miny = 1;
		int maxx = w - 1;
		int maxy = h - 1;
		while (p[st] == null) {
			if (st % 4 == 1) {
				p[st] = new Point(maxx, maxy);
				p[n - st - 1] = new Point(maxx - 1, maxy - 1);
			}
			if (st % 4 == 2) {
				p[st] = new Point(minx, maxy);
				p[n - st - 1] = new Point(minx + 1, maxy - 1);
			}
			if (st % 4 == 3) {
				p[st] = new Point(minx, miny);
				p[n - st - 1] = new Point(minx + 1, miny + 1);
			}
			if (st % 4 == 0) {
				p[st] = new Point(maxx, miny);
				p[n - st - 1] = new Point(maxx - 1, miny + 1);
				maxx -= 2;
				maxy -= 2;
				minx += 2;
				miny += 2;
			}
			st++;
		}
		printp(p, w, h);

	}

	void gencircle(int w, int h, int n) throws IOException {
		Point[] a = new Point[n];
		int r = Math.min(w / 2, h / 2);
		a[0] = new Point(w - r, h);
		a[1] = new Point(w, h - r);
		HashSet<Point> p = new HashSet<Point>();
		p.add(a[0]);
		p.add(a[1]);
		for (int i = 2; i < n; i++) {
			double angle = (i - 1) * 1.0 / n * Math.PI / 2 - Math.PI;
			a[i] = new Point((int) (r * Math.cos(angle) + w), (int) (r
					* Math.sin(angle) + h));
			p.add(a[i]);
		}
		Arrays.sort(a, 1, n);
		printp(a, w, h);
	}

	void genawful(int w, int h, int n) throws IOException {
		Point[] a = new Point[n + 1];
		for (int i = 0; i <= n; i++) {
			a[i] = new Point(i + 1, 2);
		}
		a[0].y = 3;
		a[n].y = 1;
		printp(a, w, h);
	}

	void genpile1(int w, int h, int n) throws IOException {
		while (n % 4 != 2) {
			n--;
		}
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[n - 1] = new Point(w, h / 3);
		int sty = h;
		int enx = w;
		int pos = 1;
		while (a[pos] == null) {
			sty--;
			enx--;
			a[pos] = new Point(w / 3 + rnd.nextInt(15) - 5, sty);
			sty--;
			a[pos + 1] = new Point(w / 3, sty);
			a[n - pos - 1] = new Point(enx, rnd.nextInt(h - 1) + 1);
			enx--;
			a[n - pos - 2] = new Point(enx, h / 3);
			pos += 2;
		}
		printp(a, w, h);

	}

	void genpile2(int w, int h, int n) throws IOException {
		while (n % 4 != 2) {
			n--;
		}
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[n - 1] = new Point(w, h / 3);
		int sty = h;
		int enx = w;
		int pos = 1;
		while (a[pos] == null) {
			sty--;
			enx--;
			a[pos] = new Point(rnd.nextInt(w - 1) + 1, sty);
			sty--;
			a[pos + 1] = new Point(w / 3, sty);
			a[n - pos - 1] = new Point(enx, h / 3 + rnd.nextInt(15));
			enx--;
			a[n - pos - 2] = new Point(enx, h / 3);
			pos += 2;
		}
		printp(a, w, h);

	}

	void genpile3(int w, int h, int n) throws IOException {
		while (n % 4 != 2) {
			n--;
		}
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[n - 1] = new Point(w, h / 3);
		int sty = h;
		int enx = w;
		int pos = 1;
		while (a[pos] == null) {
			sty--;
			enx--;
			a[pos] = new Point(w / 3 + w / 20, sty);
			sty--;
			a[pos + 1] = new Point(w / 3, sty);
			a[n - pos - 1] = new Point(enx, h / 3 + h / 20);
			enx--;
			a[n - pos - 2] = new Point(enx, h / 3);
			pos += 2;
		}
		printp(a, w, h);
	}

	void genpile4(int w, int h, int n) throws IOException {
		while (n % 4 != 2) {
			n--;
		}
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[n - 1] = new Point(w, h / 3);
		int sty = h;
		int enx = w;
		int pos = 1;
		while (a[pos] == null) {
			sty--;
			enx--;
			a[pos] = new Point(w + (sty - h) - 1, sty);
			sty--;
			a[pos + 1] = new Point(w / 3, sty);
			a[n - pos - 1] = new Point(enx, h + enx - w - 1);
			enx--;
			a[n - pos - 2] = new Point(enx, h / 3);
			pos += 2;
		}
		printp(a, w, h);
	}

	void genpile5(int w, int h, int n) throws IOException {
		while (n % 4 != 2) {
			n--;
		}
		int hh = h/4;
		int ww = w/4;
		Point[] a = new Point[n];
		a[0] = new Point(ww, h);
		a[n - 1] = new Point(w, hh);
		int sty = h;
		int enx = w;
		int pos = 1;
		while (a[pos] == null) {
			sty--;
			enx--;
			a[pos] = new Point(ww - (sty - h-1)/2, sty);
			sty--;
			a[pos + 1] = new Point(ww, sty);
			a[n - pos - 1] = new Point(enx, hh - (enx - w-1)/2);
			enx--;
			a[n - pos - 2] = new Point(enx, hh);
			pos += 2;
		}
		printp(a, w, h);
	}

	void gensnake1(int w, int h, int n) throws IOException {
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		int ps = h;
		for (int i = 1; i < n; i += 4) {
			ps--;
			a[i] = new Point(w / 3, ps);
			int curx = rnd.nextInt(w - 1) + 1;
			while (curx == w/3) {
				curx = rnd.nextInt(w - 1) + 1;
			}					
			if (i + 1 < n) {
				a[i + 1] = new Point(curx, ps);
			}
			ps--;
			if (i + 2 < n) {
				a[i + 2] = new Point(curx, ps);
			}
			if (i + 3 < n) {
				a[i + 3] = new Point(w / 3, ps);
			}
		}
		a[n - 1].x = w;
		printp(a, w, h);
	}

	void gensnake2(int w, int h, int n) throws IOException {
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		int ps = h;
		for (int i = 1; i < n; i += 4) {
			ps--;
			a[i] = new Point(w / 3, ps);
			int curx = w - 1;
			if (i + 1 < n) {
				a[i + 1] = new Point(curx, ps);
			}
			ps--;
			if (i + 2 < n) {
				a[i + 2] = new Point(curx, ps);
			}
			if (i + 3 < n) {
				a[i + 3] = new Point(w / 3, ps);
			}
		}
		a[n - 1].x = w;
		printp(a, w, h);
	}

	void gensnake3(int w, int h, int n) throws IOException {
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[1] = new Point(w / 3, h / 3);
		int ps = w / 3;
		for (int i = 2; i < n; i += 4) {
			ps++;
			a[i] = new Point(ps, h / 3);
			int cury = h - 1;
			if (i + 1 < n) {
				a[i + 1] = new Point(ps, cury);
			}
			ps++;
			if (i + 2 < n) {
				a[i + 2] = new Point(ps, cury);
			}
			if (i + 3 < n) {
				a[i + 3] = new Point(ps, h / 3);
			}
		}
		a[n - 1].x = w;
		printp(a, w, h);
	}

	void gensnake4(int w, int h, int n) throws IOException {
		Point[] a = new Point[n];
		a[0] = new Point(w / 3, h);
		a[1] = new Point(w / 3, h / 3);
		int ps = w / 3;
		for (int i = 2; i < n; i += 4) {
			ps++;
			a[i] = new Point(ps, h / 3);
			int cury = rnd.nextInt(h - 1) + 1;
			while (cury == h/3) {
				cury = rnd.nextInt(h - 1) + 1;					
			}
			if (i + 1 < n) {
				a[i + 1] = new Point(ps, cury);
			}
			ps++;
			if (i + 2 < n) {
				a[i + 2] = new Point(ps, cury);
			}
			if (i + 3 < n) {
				a[i + 3] = new Point(ps, h / 3);
			}
		}
		a[n - 1].x = w;
		printp(a, w, h);
	}

	void genspecialTests() throws IOException {
		System.err.println("genspecialTests");
		genspiral(90 + rnd.nextInt(10), 90 + rnd.nextInt(10),
				90 + rnd.nextInt(10));
		genspiral(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		gencircle(80 + rnd.nextInt(80), 80 + rnd.nextInt(80),
				10 + rnd.nextInt(10));
		gencircle(80000 + rnd.nextInt(20000), 80000 + rnd.nextInt(20000),
				50 + rnd.nextInt(50));

		int tmp = 50 + rnd.nextInt(50);
		genawful(tmp, 3, tmp - 1);
		int tmp1 = 50000 + rnd.nextInt(50000);
		genawful(tmp1, 3, tmp1 - 1);

		genpile1(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		genpile1(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		genpile2(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		genpile2(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		genpile3(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		genpile3(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		genpile4(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		genpile4(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		genpile5(90 + rnd.nextInt(10), 90 + rnd.nextInt(10),
				90 + rnd.nextInt(10));
		genpile5(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		gensnake1(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		gensnake1(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		gensnake2(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		gensnake2(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		gensnake3(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		gensnake3(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));

		gensnake4(100 + rnd.nextInt(100), 100 + rnd.nextInt(100),
				90 + rnd.nextInt(10));
		gensnake4(90000 + rnd.nextInt(10000), 90000 + rnd.nextInt(10000),
				90000 + rnd.nextInt(10000));
	}

	public void solve() throws IOException {
		tNumber = 1;
		int[][] f1 = { { 3, 7 }, { 4, 5 }, { 5, 6 }, { 4, 4 }, { 5, 2 },
				{ 6, 4 }, { 7, 2 }, { 8, 3 }, { 9, 2 } };
		printp(toPoint(f1), 9, 7);
		int[][] f2 = { { 7, 8 }, { 7, 7 }, { 1, 7 }, { 1, 1 }, { 6, 1 },
				{ 6, 5 }, { 3, 5 }, { 3, 3 }, { 4, 3 }, { 4, 4 }, { 5, 4 },
				{ 5, 2 }, { 2, 2 }, { 2, 6 }, { 7, 6 }, { 7, 3 }, { 8, 3 } };
		printp(toPoint(f2), 8, 8);
		for (int i = 0; i < 5; i++) {
			genrandom(rnd.nextInt(80) + 10, rnd.nextInt(80) + 10,
					2 + rnd.nextInt(20));
		}
		for (int i = 0; i < 5; i++) {
			genrandom(rnd.nextInt(500) + 1000, rnd.nextInt(500) + 1000,
					rnd.nextInt(200) + 200);
		}
		genspecialTests();
		for (int i = 0; i < 10; i++) {
			genRandomTest(rnd.nextInt(2000) + 2000, rnd.nextInt(2000) + 2000,
					100);
		}
		for (int i = 0; i < 10; i++) {
			genRandomTest(rnd.nextInt(10000) + 90000,
					rnd.nextInt(10000) + 90000, 100000);
		}

		genGenaTest();
	}

	void genGenaTest() throws IOException {
		System.err.println("GenGenaTest");
		ArrayList<Point> p = new ArrayList<Point>();
		int n = 99998;

		p.add(new Point(n - 1, n));
        for (int i = 0; i < n-2; i += 2) {
            p.add(new Point(n - 2 - i, n - 2 - i));
            p.add(new Point(n - 2 - i - 1, n - 1));
        }
        p.add(new Point(1, 1));
        p.add(new Point(n, 1));
		Point[] a = new Point[p.size()];
		for (int i = 0; i < p.size(); i++) {
			a[i] = p.get(i);
		}
		printp(a, n, n);
	}

	private void genRandomTest(int w, int h, int it) throws IOException {
		System.err.println("GenAnotherRandomTest");
		int stx = rnd.nextInt(w / 3 - 1) + 1;
		int sty = h;
		ArrayList<Point> p = new ArrayList<Point>();
		//p.add(new Point(stx, sty));
		for (int i = 0; i < it; i++) {
			Test tst = small.get(rnd.nextInt(small.size()));
			if (stx + tst.w >= w - 1) {
				continue;
			}
			if (sty - tst.h <= 1) {
				continue;
			}
			if (p.size() + tst.a.length >= 99999) {
				continue;
			}
			for (int j = 0; j < tst.a.length; j++) {
				p.add(new Point(tst.a[j].x + stx, sty - (tst.h - tst.a[j].y)));
			}
			stx += tst.w;
			sty -= tst.h;
		}
		p.add(new Point(w, 1));
		Point[] a = new Point[p.size()];
		for (int i = 0; i < p.size(); i++) {
			a[i] = p.get(i);
		}
		printp(a, w, h);

	}

	public void run() {
		try {
			// br = new BufferedReader(new FileReader("polygon.in"));
			out = new PrintWriter(System.out);

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	class Point implements Comparable<Point> {
		long x, y;

		Point(long x2, long y2) {
			this.x = x2;
			this.y = y2;
		}

		@Override
		public int compareTo(Point o) {
			if (x != o.x)
				return sign(x - o.x);
			return sign(y - o.y);
		}

		@Override
		public String toString() {
			return x + " " + y;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getOuterType().hashCode();
			result = prime * result + (int) (x ^ (x >>> 32));
			result = prime * result + (int) (y ^ (y >>> 32));
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Point other = (Point) obj;
			if (!getOuterType().equals(other.getOuterType()))
				return false;
			if (x != other.x)
				return false;
			if (y != other.y)
				return false;
			return true;
		}

		private TestGen getOuterType() {
			return TestGen.this;
		}

	}

	class Segment {
		Point p1, p2;
		long a, b, c;
		int num;

		Segment(Point p1, Point p2, int n) {
			num = n;
			if (p2.compareTo(p1) > 0) {
				this.p1 = p1;
				this.p2 = p2;
			} else {
				this.p1 = p2;
				this.p2 = p1;
			}
			a = p2.y - p1.y;
			b = p1.x - p2.x;
			c = -a * p1.x - b * p1.y;
		}

		@Override
		public boolean equals(Object o) {
			if (!(o instanceof Segment))
				return false;
			Segment s = (Segment) o;
			return p1.compareTo(s.p1) == 0 && p2.compareTo(s.p2) == 0;
		}

		int side(Point p) {
			return sign(a * p.x + b * p.y + c);
		}

		boolean inside(Point p) {
			if (side(p) != 0)
				return false;
			long sm1 = smul(p.x - p1.x, p.y - p1.y, p2.x - p1.x, p2.y - p1.y);
			long sm2 = smul(p.x - p2.x, p.y - p2.y, p1.x - p2.x, p1.y - p2.y);
			if (sm1 > 0 && sm2 > 0)
				return true;
			return false;
		}

		boolean inter(Segment s) {
			if (equals(s))
				return true;
			int s1 = side(s.p1) * side(s.p2);
			int s2 = s.side(p1) * s.side(p2);
			if (s1 < 0 && s2 < 0)
				return true;
			if (inside(s.p1) || inside(s.p2))
				return true;
			if (s.inside(p1) || s.inside(p2))
				return true;
			return false;
		}

		@Override
		public String toString() {
			return p1 + " " + p2;
		}
	}

	static int sign(long l) {
		if (l < 0)
			return -1;
		if (l > 0)
			return 1;
		return 0;
	}

	static long smul(long x1, long y1, long x2, long y2) {
		return x1 * x2 + y1 * y2;
	}

	static boolean inBound(int x, int l, int r) {
		return l <= x && x <= r;
	}

	Segment[] checkPolygon(Point[] p) {
		int n = p.length;
		Segment[] s = new Segment[n - 1];
		Segment[] res = new Segment[2];
		for (int i = 0; i < n - 1; i++) {
			s[i] = new Segment(p[i], p[(i + 1) % n], i);
		}
		for (int i = 0; i < 100; i++) {
			int j = rnd.nextInt(n - 1);
			int k = rnd.nextInt(n - 1);
			while (j == k) {
				k = rnd.nextInt(n - 1);
			}
			if (s[j].inter(s[k])) {
				res[0] = s[j];
				res[1] = s[k];
				return res;
			}
		}
		for (int j = 0; j < n - 1; j++) {
			for (int k = j + 1; k < n - 1; k++) {
				if (s[j].inter(s[k])) {
					res[0] = s[j];
					res[1] = s[k];
					return res;
				}
			}
		}
		return null;
	}

}