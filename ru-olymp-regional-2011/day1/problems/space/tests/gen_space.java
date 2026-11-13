import java.io.*;
import java.util.*;

public class gen_space implements Runnable {
	public static void main(String[] args) {
		if (args.length < 1) {
			for (I = 1; (new File(getName(I) + ".t")).exists(); I++)
				;
		} else {
			if (args[0].equals("stress")) {
				STRESS_MODE = true;
				if (args.length >= 2) {
					FNAME = args[1];
				} else {
					FNAME = "01";
				}
			} else {
				I = Integer.parseInt(args[0]);
			}
		}
		new Thread(new gen_space()).start();
	}

	PrintWriter out;

	Random rand = new Random(6439586L);

	static int I;

	static boolean STRESS_MODE;
	static String FNAME;

	static String getName(int i) {
		return ((i < 10) ? "0" : "") + i;
	}

	void open() {
		try {
			if (STRESS_MODE) {
				out = new PrintWriter(FNAME);
			} else {
				System.out.println("Generating test " + I);
				out = new PrintWriter(getName(I));
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	void close() {
		out.close();
		I++;
	}

	final String ALPHA = "abcdefghijklmnopqrstuvwxyz";

	String randString(int len, String alpha) {
		StringBuilder ans = new StringBuilder();
		int k = alpha.length();
		for (int i = 0; i < len; i++) {
			ans.append(alpha.charAt(rand.nextInt(k)));
		}
		return ans.toString();
	}

	long rand(long l, long r) {
		return l + (rand.nextLong() >>> 1) % (r - l + 1);
	}

	int rand(int l, int r) {
		return l + rand.nextInt(r - l + 1);
	}

	final int MAXC = 50;
	final int MAXK = 5;
	final int MAXN = 1000;

	class Point implements Comparable<Point> {
		int x, y;

		public Point(int x, int y) {
			this.x = x;
			this.y = y;
		}

		@Override
		public int compareTo(Point o) {
			return x < o.x ? -1 : x > o.x ? 1 : y < o.x ? -1 : y > o.y ? 1 : 0;
		}

		@Override
		public boolean equals(Object o) {
			if (!(o instanceof Point))
				return false;
			Point p = (Point) o;
			return x == p.x && y == p.y;
		}
	}

	void writeTest(int n, int k, List<Point> al) {
		open();
		out.println(n + " " + k);
		Collections.shuffle(al);
		for (Point p : al) {
			out.println(p.x + " " + p.y);
		}
		close();
	}

	void genTest(int LN, int RN, int LK, int RK, int XC, int YC, int mask) {
		System.out.println(Integer.toBinaryString(mask));
		int n = rand(LN, RN);
		int k = rand(LK, RK);
		ArrayList<Point> all = new ArrayList<Point>();
		for (int i = 0; i < XC; ++i) {
			for (int j = 0; j < YC; ++j) {
				if (((1 << j) & mask) > 0)
					continue;
				all.add(new Point(i + 1, j + 1));
			}
		}
		Collections.shuffle(all);
		writeTest(n, k, all.subList(0, n));
	}

	void genMaxAns(int k, int C) {
		ArrayList<Point> al = new ArrayList<Point>();
		for (int i = 0; i < C; ++i) {
			al.add(new Point(1, i + 1));
			al.add(new Point(C, i + 1));
		}
		writeTest(al.size(), k, al);
	}

	public void solve() throws IOException {
		// some magic
		{
			for (int i = 0; i < 1000; ++i) {
				rand.nextInt();
			}
		}

		// Stress mode
		if (STRESS_MODE) {
			rand = new Random(System.nanoTime());
			genTest(30, 35, 1, 1, 10, 10, 0);
			return;
		}

		// k = 1
		for (int i = 0; i < 13; ++i) {
			genTest(30, MAXN, 1, 1, MAXC, MAXC, rand(0, 1));
		}
		genMaxAns(1, MAXC);
		genTest(MAXN, MAXN, 1, 1, MAXC, MAXC, rand(0, 1));

		// n <= 15
		for (int i = 0; i < 15; ++i) {
			genTest(1, 15, 2, MAXK, MAXC, MAXC, rand(0, 255));
		}

		// other
		genMaxAns(2, MAXC);
		genMaxAns(4, MAXC);
		for (int i = 0; i < 6; ++i) {
			genMaxAns((i % 4) + 2, rand(MAXC / 2, MAXC));
		}
		
		genTest(30, 100, 5, 5, MAXC, 5, 7);		
		genTest(30, 100, 5, 5, MAXC, 5, 19);
		genTest(30, 30, 4, 4, MAXC, 4, 9);
		genTest(30, 30, 5, 5, MAXC, 5, 9);
		genTest(50, 50, 5, 5, MAXC, 5, 23);

		for (int i = 0; i < 5; ++i) {
			genTest(30, MAXN, 2, MAXK, MAXC, MAXC, rand(0, 255));
		}
		genTest(31 * 31, 31 * 31, MAXK, MAXK, 31, 31, 0);
		genTest(MAXN, MAXN, MAXK, MAXK, MAXC, MAXC, rand(0, 255));
	}

	void myAssert(boolean e) {
		if (!e) {
			throw new Error("Assertion failed");
		}
	}

	public void run() {
		try {
			solve();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}
}