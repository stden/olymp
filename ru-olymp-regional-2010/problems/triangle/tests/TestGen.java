//by Sergey Melnikov
/*
 * ab		- 20
 * sm 		- 20
 * sm_2 	- 20
 * sp		- 20
 * sm_int	 - 8 
 * sm_wrong_forgot_last_iter - ?? 
 * sm_wrong2 - 14 
 * sm_wrongL - 16 
 * sm_wrongR - 16
 * sm_byte 	 - 5
 * sm_int_wrongL - 6
 * sm_int_wrongR - 7
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;

public class TestGen extends Thread {
	class Test {
		ArrayList<String> x;
		ArrayList<Boolean> cl;

		public Test(ArrayList<String> x, ArrayList<Boolean> cl) {
			this.x = x;
			this.cl = cl;
		}

		public void out(PrintWriter out) {
			out.println(x.size());
			String prev = null;
			for (int i = 0; i < x.size(); i++) {
				if (prev != null
						&& Math.abs(Double.parseDouble(prev)
								- Double.parseDouble(x.get(i))) < EPS) {
					out.print(prev);
				} else {
					out.print(x.get(i));
					prev = x.get(i);
				}
				if (i == 0) {
					out.println();
				} else {
					out.println(" " + (cl.get(i) ? "closer" : "further"));
				}
			}
		}

	}

	private int testCount = 0;

	private void write(Test t) {
		try {
			++testCount;
			String filename = testCount / 10 + "" + testCount % 10;
			PrintWriter out = new PrintWriter(filename);
			System.err.println(testCount);
			t.out(out);
			out.close();
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	static Random rand = new Random(1);
	final int MAXN = 2000;

	@Override
	public void run() {
		// Integer tests

		// 1 - Simplest possible test
		rand = new Random(1);
		write(make0(2));
		// 2 - more hard test
		rand = new Random(0xB);
		write(make0(3));
		// 3 - And more
		rand = new Random(0xC);
		write(make1(5));
		// 4 - Large(250), but don't update left
		rand = new Random(4);
		write(makeL(250));
		// 5 - Large(250), but don't update right
		rand = new Random(0xD);
		write(makeR(250));
		// 6 - Large(500), have two equals number one, after other
		rand = new Random(6);
		write(make1eq(500));
		// 7 - Big(1000) test, all iteration meanfull
		rand = new Random(0x243);
		write(make0LastMean(1000));
		// 8 - Big(998) random test
		rand = new Random(8);
		write(make0eq(500));

		// double

		// 9 - Small general test
		rand = new Random(9);
		write(makeD(5));
		// 10 - Small test, don't update left
		rand = new Random(10);
		write(makeDL(3));
		// 11 - Small test, don't update right
		rand = new Random(11);
		write(makeDR(9));
		// 12 - Small test, has equals number one after another
		rand = new Random(12);
		write(makeDeq(15));

		// 13 - Medium general test
		rand = new Random(9);
		write(makeD(500));

		// 14 - Medium test, don't update right //TODO Maybe another?
		rand = new Random(10);
		write(makeDR(400));

		// 15 - Medium test, last number mean
		rand = new Random(12);
		write(makeDLastMean(374));

		// 16 - Large test, last number mean
		rand = new Random(12);
		write(makeDLastMean(1000));
		// 17 - Large general test
		rand = new Random(9);
		write(makeD(1000));
		// 18 - Large test, don't update left
		rand = new Random(10);
		write(makeDL(999));
		// 19 - Large test, don't update right
		rand = new Random(11);
		write(makeDR(850));
		// 20 - Large test, has equals number one after another
		rand = new Random(12);
		write(makeDeq(15));
	}

	double rand() {
		return rand.nextDouble() * (4000 - 30) + 30;
	}

	int randOdd() {
		return rand.nextInt(((4000 - 30) / 2) + 1) * 2 + 30;
	}

	int randEven() {
		return rand.nextInt(((4000 - 31) / 2) + 1) * 2 + 31;
	}

	final double EPS = 1e-3;

	boolean eq(double a, double b) {
		return Math.abs(a - b) < EPS;
	}

	Test make0(int k) {
		int l = 30;
		int r = 4000;
		int ans = randOdd();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randOdd();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randOdd();
				if (eq(c, prev))
					continue;
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
		}
		return new Test(x, cl);
	}

	Test make0LastMean(int k) {
		boolean ok = false;
		while (true) {
			int l = 30;
			int r = 4000;
			int ans = randOdd();
			ArrayList<String> x = new ArrayList<String>();
			ArrayList<Boolean> cl = new ArrayList<Boolean>();
			int prev = randOdd();
			x.add("" + prev);
			cl.add(true);
			for (int i = 1; i < k; i++) {
				for (int iter = 0; iter < 100; iter++) {
					// while (true) {
					// for (int c = 30; c <= 4000; c += 2) {
					// System.err.println(i + " " + l + " " + r);
					int c = randOdd();
					// System.err.println(" c = " + c);
					if (eq(c, prev))
						continue;
					boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
					int nl = l;
					int nr = r;
					// System.err.println(b + " " + (c > prev));
					if (b == (c > prev)) {
						nl = Math.max(l, (c + prev) / 2);
					} else {
						nr = Math.min(r, (c + prev) / 2);
					}
					// System.err.println(" prev = " + prev + " c = " + c
					// + " ans = " + ans + " b = " + b);
					// System.err.println(nl + " " + l + "   " + nr + " " + r);
					if (nl == l && nr == r
							&& (rand.nextInt(k / 3) == 0 || i == k - 1)) {
						continue;
					}
					if (nr - nl < 10 / i + 10) {
						continue;
					}

					l = nl;
					r = nr;
					x.add("" + c);
					cl.add(b);
					prev = c;
					if (i == k - 1) {
						// System.err.println(l + " " + r);
						ok = true;
					}
					break;
				}
			}
			if (ok)
				return new Test(x, cl);
		}
	}

	Test makeDLastMean(int k) {
		boolean ok = false;
		while (true) {
			double l = 30;
			double r = 4000;
			double ans = rand();
			ArrayList<String> x = new ArrayList<String>();
			ArrayList<Boolean> cl = new ArrayList<Boolean>();
			double prev = rand();
			x.add("" + prev);
			cl.add(true);
			for (int i = 1; i < k; i++) {
				for (int iter = 0; iter < 100; iter++) {
					// while (true) {
					// for (int c = 30; c <= 4000; c += 2) {
					// System.err.println(i + " " + l + " " + r);
					double c = rand();
					// System.err.println(" c = " + c);
					if (eq(c, prev))
						continue;
					boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
					double nl = l;
					double nr = r;
					// System.err.println(b + " " + (c > prev));
					if (b == (c > prev)) {
						nl = Math.max(l, (c + prev) / 2);
					} else {
						nr = Math.min(r, (c + prev) / 2);
					}
					// System.err.println(" prev = " + prev + " c = " + c
					// + " ans = " + ans + " b = " + b);
					// System.err.println(nl + " " + l + "   " + nr + " " + r);
					if (eq(nl, l) && eq(nr, r)
							&& (rand.nextInt(k / 3) == 0 || i == k - 1)) {
						continue;
					}
					if (nr - nl < 10 / i + 10) {
						continue;
					}

					l = nl;
					r = nr;
					x.add("" + c);
					cl.add(b);
					prev = c;
					if (i == k - 1) {
						// System.err.println(l + " " + r);
						ok = true;
					}
					break;
				}
			}
			if (ok)
				return new Test(x, cl);
		}
	}

	Test make0eq(int k) {
		int l = 30;
		int r = 4000;
		int ans = randOdd();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randEven();
		x.add("" + prev);
		cl.add(true);
		int itEq = rand.nextInt(k - 1) + 1;
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randOdd();
				if (i == itEq) {
					c = prev;
				}
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
		}
		return new Test(x, cl);
	}

	Test make1(int k) {
		int l = 30;
		int r = 4000;
		int ans = randEven();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randEven();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randEven();
				if (eq(c, prev))
					continue;
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
			// System.err.println(l + " " + r);
		}
		return new Test(x, cl);
	}

	Test make1eq(int k) {
		int l = 30;
		int r = 4000;
		int ans = randEven();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randEven();
		x.add("" + prev);
		cl.add(true);
		int itEq = rand.nextInt(k - 1) + 1;
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randEven();
				if (i == itEq) {
					c = prev;
				}
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
		}
		return new Test(x, cl);
	}

	Test makeL(int k) {
		int l = 30;
		int r = 4000;
		int ans = randEven();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randEven();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randEven();
				if (eq(c, prev))
					continue;
				if ((Math.abs(c - ans) < Math.abs(prev - ans)) == (c < prev)) {
					x.add("" + c);
					boolean b = c < prev;
					cl.add(b);
					if (b == (c > prev)) {
						l = Math.max(l, (c + prev) / 2);
					} else {
						r = Math.min(r, (c + prev) / 2);
					}
					prev = c;
					break;
				}
			}
		}
		return new Test(x, cl);
	}

	Test makeDL(int k) {
		wh: while (true) {
			double l = 30;
			double r = 4000;
			double ans = rand();
			ArrayList<String> x = new ArrayList<String>();
			ArrayList<Boolean> cl = new ArrayList<Boolean>();
			double prev = rand();
			x.add("" + prev);
			cl.add(true);
			fori: for (int i = 1; i < k; i++) {
				for (int it = 0; it < 100; it++) {
					double c = rand();
					if (eq(c, prev))
						continue;
					if ((Math.abs(c - ans) < Math.abs(prev - ans)) == (c < prev)) {
						x.add("" + c);
						boolean b = c < prev;
						cl.add(b);
						if (b == (c > prev)) {
							l = Math.max(l, (c + prev) / 2);
						} else {
							r = Math.min(r, (c + prev) / 2);
						}
						prev = c;
						continue fori;
					}
				}
				continue wh;
			}
			return new Test(x, cl);
		}
	}

	Test makeR(int k) {
		int l = 30;
		int r = 4000;
		int ans = randEven();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		int prev = randOdd();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				int c = randOdd();
				if (eq(c, prev))
					continue;
				if ((Math.abs(c - ans) < Math.abs(prev - ans)) == (c > prev)) {
					x.add("" + c);
					boolean b = c > prev;
					cl.add(b);
					if (b == (c > prev)) {
						l = Math.max(l, (c + prev) / 2);
					} else {
						r = Math.min(r, (c + prev) / 2);
					}
					prev = c;
					break;
				}
			}
		}
		return new Test(x, cl);
	}

	Test makeDR(int k) {
		wh: while (true) {
			double l = 30;
			double r = 4000;
			double ans = rand();
			ArrayList<String> x = new ArrayList<String>();
			ArrayList<Boolean> cl = new ArrayList<Boolean>();
			double prev = rand();
			x.add("" + prev);
			cl.add(true);
			fori: for (int i = 1; i < k; i++) {
				for (int it = 0; it < 100; it++) {
					double c = rand();
					if (eq(c, prev))
						continue;
					if ((Math.abs(c - ans) < Math.abs(prev - ans)) == (c > prev)) {
						x.add("" + c);
						boolean b = c > prev;
						cl.add(b);
						if (b == (c > prev)) {
							l = Math.max(l, (c + prev) / 2);
						} else {
							r = Math.min(r, (c + prev) / 2);
						}
						prev = c;
						continue fori;
					}
				}
				continue wh;
			}
			return new Test(x, cl);
		}
	}

	Test makeD(int k) {
		double l = 30;
		double r = 4000;
		double ans = rand();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		double prev = rand();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				double c = rand();
				if (eq(c, prev))
					continue;
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
		}
		return new Test(x, cl);
	}

	Test makeDeq(int k) {
		double l = 30;
		double r = 4000;
		double ans = rand();
		ArrayList<String> x = new ArrayList<String>();
		ArrayList<Boolean> cl = new ArrayList<Boolean>();
		double prev = rand();
		x.add("" + prev);
		cl.add(true);
		for (int i = 1; i < k; i++) {
			while (true) {
				double c = rand();
				if (rand.nextInt(k / 2) == 0) {
					c = prev;
				}
				x.add("" + c);
				boolean b = Math.abs(c - ans) < Math.abs(prev - ans);
				cl.add(b);
				if (b == (c > prev)) {
					l = Math.max(l, (c + prev) / 2);
				} else {
					r = Math.min(r, (c + prev) / 2);
				}
				prev = c;
				break;
			}
		}
		return new Test(x, cl);
	}

	public static void main(String[] args) {
		new TestGen().start();
	}
}
