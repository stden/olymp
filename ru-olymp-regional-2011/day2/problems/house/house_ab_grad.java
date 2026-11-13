import java.io.*;
import java.util.*;
import java.math.*;

public class house_ab_grad implements Runnable {
		
	final int MAXN = 100000;
	final int MAXC = 10000;
	final double STEP_INF = 10 * MAXC * MAXC;
	
	
	void solve() {
		n = in.nextInt();
		assert 1 <= n && n <= MAXN;
		
		a = new double[n];
		b = new double[n];
		c = new double[n];
		
		for (int i = 0; i < n; ++i) {
			int x1 = in.nextInt();
			assert -MAXC <= x1 && x1 <= MAXC;
			int y1 = in.nextInt();
			assert -MAXC <= y1 && y1 <= MAXC;
			int x2 = in.nextInt();
			assert -MAXC <= x2 && x2 <= MAXC;
			int y2 = in.nextInt();
			assert -MAXC <= y2 && y2 <= MAXC;
			a[i] = y2 - y1;
			b[i] = x1 - x2;
			double d = Math.sqrt(a[i] * a[i] + b[i] * b[i]);
			a[i] /= d;
			b[i] /= d;
			c[i] = - a[i] * x1 - b[i] * y1;
		}
		
		double step = MAXC;
		double x = rand.nextDouble() * 1000;
		double y = rand.nextDouble() * 1000;
		for (int i = 0; i < 7000; ++i) {
			maxDist(x, y);
			int j = ai;
			double td = ad;			
			double sgn = Math.signum(a[j] * x + b[j] * y + c[j]);
			double tx, ty;
			while (true) {
				tx = x - a[j] * step * sgn;
				ty = y - b[j] * step * sgn;
				maxDist(tx, ty);
				if (ad > td) {
					step /= 2;
				} else {
					break;
				}				
			}
			step *= 2;
			if (step > STEP_INF) {
				step = STEP_INF;
			}
			x = tx;
			y = ty;
		}
		out.println(x + " " + y);
	}
	
	int n;
	double[] a, b, c;
	int ai;
	double ad;
	
	void maxDist(double x, double y) {
		ai = -1;
		ad = Double.NEGATIVE_INFINITY;
		for (int i = 0; i < n; ++i) {
			double td = Math.abs(a[i] * x + b[i] * y + c[i]);
			if (td > ad) {
				ai = i;
				ad = td;
			}
		}		
	}
	
	Random rand = new Random(45743);


	final String FILE_NAME = "house";

	SimpleScanner in;
	PrintWriter out;

	@Override
	public void run() {
		try {
			in = new SimpleScanner(new FileReader(FILE_NAME + ".in"));
			out = new PrintWriter(FILE_NAME + ".out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	public static void main(String[] args) {
		new Thread(new house_ab_grad()).start();
	}

	class SimpleScanner extends BufferedReader {

		private StringTokenizer st;
		private boolean eof;

		public SimpleScanner(Reader a) {
			super(a);
		}

		String next() {
			while (st == null || !st.hasMoreElements()) {
				try {
					st = new StringTokenizer(readLine());
				} catch (Exception e) {
					eof = true;
					return "";
				}
			}
			return st.nextToken();
		}

		boolean seekEof() {
			String s = next();
			if ("".equals(s) && eof)
				return true;
			st = new StringTokenizer(s + " " + st.toString());
			return false;
		}

		private String cnv(String s) {
			if (s.length() == 0)
				return "0";
			return s;
		}

		int nextInt() {
			return Integer.parseInt(cnv(next()));
		}

		double nextDouble() {
			return Double.parseDouble(cnv(next()));
		}

		long nextLong() {
			return Long.parseLong(cnv(next()));
		}
	}
}