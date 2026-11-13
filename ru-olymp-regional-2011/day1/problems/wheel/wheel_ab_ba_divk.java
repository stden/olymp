import java.io.*;
import java.util.*;
import java.math.*;


//O((b - a) / k)
public class wheel_ab_ba_divk implements Runnable {

	final int MAXV = 1000000000;
	
	private void solve() throws IOException {
		n = in.nextInt();
		assert 3 <= n && n <= 100;
		int[] v = new int[n];
		for (int i = 0; i < n; ++i) {
			v[i] = in.nextInt();
			assert 1 <= v[i] && v[i] <= 1000;
		}
		
		a = in.nextInt();
		b = in.nextInt();
		assert 1 <= a && a <= b && b <= MAXV;
		k = in.nextInt();
		assert 1 <= k && k <= MAXV;
		
		int ans = -1;
		for (int p = a / k; p <= b / k; ++p) {
			ans = Math.max(ans, v[p % n]);
			ans = Math.max(ans, v[(n - p % n) % n]);
		}
		out.println(ans);
	}

	
	int a, b, k, n;

	
	final String FILE_NAME = "wheel";

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
		new Thread(new wheel_ab_ba_divk()).start();
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