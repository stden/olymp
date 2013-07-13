import java.io.*;
import java.util.*;
import java.math.*;

public class shooting_ab implements Runnable {

	final int MAXN = 100000;
	final int MAXV = 1000;
	
	
	private void solve() throws IOException {
		int n = in.nextInt();
		assert 3 <= n && n <= MAXN;
		
		int[] v = new int[n];
		for (int i = 0; i < n; ++i) {
			v[i] = in.nextInt();
			assert 1 <= v[i] && v[i] <= MAXV;
		}

		int mi = 0;
		for (int i = 1; i < v.length; ++i) {
			if (v[i] > v[mi]) {
				mi = i;
			}
		}
		
		int mv = -1;
		
		for (int j = mi + 1; j < v.length - 1; ++j) {
			if (v[j] % 10 == 5 && v[j] > v[j + 1]) {
				mv = Math.max(mv, v[j]);
			}
		}
		
		if (mv == -1) {
			out.println(0);
			return;
		}
		
		Arrays.sort(v);
		
		for (int i = 0; ; ++i) {  
			if (v[i] == mv) {
				out.println(i + 1);
				return;
			}
		}
	}

	final String FILE_NAME = "shooting";

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
		new Thread(new shooting_ab()).start();
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