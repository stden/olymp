import java.io.*;
import java.util.*;
import java.math.*;

public class chess_ab implements Runnable {

	final int MAXV = 1000000000;
	
	private void solve() throws IOException {
		int m = in.nextInt();
		int n = in.nextInt();
		int i = in.nextInt();
		assert 1 <= i && i <= m && m <= MAXV;  
		int j = in.nextInt();
		assert 1 <= j && j <= n && n <= MAXV;
		int c = in.nextInt();
		assert c == 0 || c == 1;
		if (m % 2 == 0 || n % 2 == 0) {
			out.println("equal");
		} else {
			out.println(new String[]{"black", "white"}[c ^ ((i + j) % 2)]);
		}
	}

	final String FILE_NAME = "chess";

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
		new Thread(new chess_ab()).start();
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