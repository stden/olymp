import java.io.*;
import java.util.*;
import java.math.*;

public class game_ab_wa3 implements Runnable {

	final int MAXN = 10000;
	final int MAXM = 100000;
	final int MAXK = 100000;
	
	private void solve() throws IOException {
		long n = in.nextInt();
		long m = in.nextInt();
		long k = in.nextInt();
		assert 1 <= n && n <= MAXN;
		assert 1 <= m && m <= MAXM;
		assert 1 <= k && k <= MAXK;
		
		if (m < k) {
			out.println(n * m);
		} else {
			out.println(n * (k - 1) + n * m / k);
		}
	}

	final String FILE_NAME = "game";

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
		new Thread(new game_ab_wa3()).start();
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