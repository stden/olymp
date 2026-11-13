import java.io.*;
import java.util.*;
import java.math.*;

//O(n log U) expected time
//Named because of state of mind after realising that it will actually work.

public class house_ab_magic implements Runnable {
		
	final int MAXN = 100000;
	final int MAXC = 10000;
	
	void solve() {
		int n = in.nextInt();
		assert 1 <= n && n <= MAXN;
		
		double[] a = new double[n];
		double[] b = new double[n];
		double[] c = new double[n];
		
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
			a[i] = y2 - y1;
			b[i] = x1 - x2;
			double d = Math.sqrt(a[i] * a[i] + b[i] * b[i]);
			a[i] /= d;
			b[i] /= d;
			c[i] = - a[i] * x1 - b[i] * y1;			
		}
		
		double l = 0;
		double r = 2 * MAXC; 
		
		int m = 2 * n;
		ha = new double[m];
		hb = new double[m];
		hc = new double[m];
		
		double xa = 0;
		double ya = 0;
		
		for (int i = 0; i < 50; ++i) {
			double d = (l + r) / 2;
			
			for (int j = 0; j < n; ++j) {
				ha[2 * j] = a[j];
				hb[2 * j] = b[j];
				hc[2 * j] = c[j] + d;
				
				ha[2 * j + 1] = -a[j];
				hb[2 * j + 1] = -b[j];
				hc[2 * j + 1] = -c[j] + d;
			}
			
			//Start reading the spell
			for (int j = 0; j < m; ++j) {
				swap(rand.nextInt(j + 1), j);
			}
			//Cast it!

			boolean isEmpty = false;
			
			double sa = -ha[0];
			double sb = -hb[0];

			double x = - ha[0] * hc[0];
			double y = - hb[0] * hc[0];
			loop:
			for (int j = 1; j < m; ++j) {
				if (ha[j] * x + hb[j] * y + hc[j] <= -eps) {
					double L = -INF;
					double R = INF;
					
					double xj = - ha[j] * hc[j];
					double yj = - hb[j] * hc[j];
					double sx = -hb[j];
					double sy = ha[j];
					
					for (int k = 0; k < j; ++k) {
						double numer = hc[k] + ha[k] * xj + hb[k] * yj;
						double denom = ha[k] * sx + hb[k] * sy;
//						System.out.println(denom);
						if (Math.abs(denom) <= eps) {
							if (numer <= -eps) {
								isEmpty = true;
								break loop;
							}
						} else {
							double tk = - numer / denom;
							if (Math.signum(denom) > 0) {
								L = Math.max(L, tk);
							} else {
								R = Math.min(R, tk);
							}
							if (L >= R + eps) {
								isEmpty = true;
								break loop;
							}
						}						
					}
					
					System.out.println(L + " " + R);
					if (sa * sx + sb * sy <= 0) {
						x = xj + sx * L;
						y = yj + sy * L;
					} else {
						x = xj + sx * R;
						y = yj + sy * R;
					}
				}
			}
//			System.out.printf("%.15f", d);
//			System.out.println(" " + isEmpty);
			
			if (isEmpty) {
				l = d;
			} else {
				r = d;
				xa = x;
				ya = y;
			}				
		}
		
		out.println(xa + " " + ya);
		
	}
	
	double eps = 1e-10;
	double INF = 9e8;
	
	int n;
	double[] ha, hb, hc;
	
	void swap(double[] a, int i, int j) {
		double tmp = a[i];
		a[i] = a[j];
		a[j] = tmp;
	}
	
	void swap(int i, int j) {
		swap(ha, i, j);
		swap(hb, i, j);
		swap(hc, i, j);
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
		new Thread(new house_ab_magic()).start();
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