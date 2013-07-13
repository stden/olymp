import java.io.*;
import java.util.*;
import java.math.*;

//O(n) expected time
//Named because of state of mind after realising that it will actually work.
public class house_ab_dark_magic implements Runnable {
		
	final int MAXN = 100000;
	final int MAXC = 10000;
	
	void solve() {
		int n = in.nextInt();
		assert 1 <= n && n <= MAXN;
		
		LinearSolver ls = new LinearSolver(3, 2 * n);
		ls.A[0][3] = -1;
		
		for (int i = 0; i < n; ++i) {
			int x1 = in.nextInt();
			assert -MAXC <= x1 && x1 <= MAXC;
			int y1 = in.nextInt();
			assert -MAXC <= y1 && y1 <= MAXC;
			int x2 = in.nextInt();
			assert -MAXC <= x2 && x2 <= MAXC;
			int y2 = in.nextInt();
			assert -MAXC <= y2 && y2 <= MAXC;
			assert x1 != y1 || x2 != y2;			
			double a = y2 - y1;
			double b = x1 - x2;
			double d = Math.sqrt(a * a + b * b);
			a /= d;
			b /= d;
			double c = - a * x1 - b * y1;
			
			ls.A[2 * i + 1][0] = c;
			ls.A[2 * i + 1][1] = a;
			ls.A[2 * i + 1][2] = b;
			ls.A[2 * i + 1][3] = 1;
			
			ls.A[2 * i + 2][0] = -c;
			ls.A[2 * i + 2][1] = -a;
			ls.A[2 * i + 2][2] = -b;
			ls.A[2 * i + 2][3] = 1;
		}
		
		for (int i = 0; i < 2 * n; ++i) {		
			int j = rand.nextInt(i + 1);
			double[] tmp = ls.A[i + 1];
			ls.A[i + 1] = ls.A[j + 1];
			ls.A[j + 1] = tmp;
		}
		
		ls.solve(3, 2 * n);
		
		out.println(ls.x[0] + " " + ls.x[1]);
	}
	
	double eps = 1e-10;
	double INF = 1e9;

	class LinearSolver {
		
		double[][][] buf;
		double[][] A;
		int n;
		
		public LinearSolver(int n, int m) {
			this.n = n;
			buf = new double[n + 1][m + 1][n + 1];
			A = buf[n];
			x = new double[n];
			u = new boolean[n];
		}		
		
		double[] x;
		boolean[] u;
		
		/*
		 *Solves this system in O(n) expected time 
		 *Read the following aloud before trying to understand why ;-) 
		 * 
		 *Darkness from twilight, crimson from blood that flows;  
		 *buried in the flow of time; in Thy great name, I pledge myself to darkness! 
		 *Those who oppose us shall be destroyed by the power you and I possess! 
		 */		
		void solve(int l, int m) {
			double[][] A = buf[l];
			if (l == 0) return;

			for (int i = 0; i < n; ++i) {
				if (!u[i]) {
					x[i] = Math.signum(A[0][i + 1]) * INF; 
				}
			}
			
			for (int j = 1; j <= m; ++j) {
				double tv = A[j][0];
				for (int i = 0; i < n; ++i) {
					if (!u[i]) {
						tv += A[j][i + 1] * x[i];
					}
				}
				if (tv < -eps) {
					int mi = -1;
					for (int i = 0; i < n; ++i) {
						if (!u[i] && (mi == -1 || Math.abs(A[j][mi + 1]) < Math.abs(A[j][i + 1]))) {
							mi = i;
						}
					}
					
					double[][] B = buf[l - 1];
					for (int i = 0; i < B[j].length; ++i) {
						B[j][i] = -A[j][i] / A[j][mi + 1];
					}
					
					
					for (int k = 0; k < j; ++k) {
						for (int i = 0; i < B[k].length; ++i) {
							B[k][i] = A[k][i] + A[k][mi + 1] * B[j][i];
						}
					}
					
					u[mi] = true;
					solve(l - 1, j - 1);
					x[mi] = B[j][0];
					for (int i = 0; i < n; ++i) {
						if (!u[i]) {
							x[mi] += x[i] * B[j][i + 1];
						}
					}
					u[mi] = false;					
				}
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
		new Thread(new house_ab_dark_magic()).start();
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