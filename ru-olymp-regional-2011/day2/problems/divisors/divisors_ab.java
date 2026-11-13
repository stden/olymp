import java.io.*;
import java.util.*;
import java.math.*;

public class divisors_ab implements Runnable {

	final int MAXN = 100000000;
	final int MAXK = 10;
	
	
	private void solve() throws IOException {
		int n = in.nextInt();
		assert 2 <= n && n <= MAXN;
		int k = in.nextInt();
		assert 2 <= k && k <= MAXK;
		
		TreeSet<Integer> d = new TreeSet<Integer>();
		for (int i = 1; i * i <= n; ++i) {
			if (n % i == 0) {
				d.add(i);
				d.add(n / i);
			}
		}
		
		int m = d.size();
		int[] dv = new int[d.size()];
		int cnt = 0;
		for (int i : d) {
			dv[cnt++] = i;
		}
		System.out.println(Arrays.toString(dv));
		int[][] D = new int[m][k];
		int ans = 0;
		for (int i = 0; i < m; ++i) {
			D[i][0] = 1;
			ans += D[i][k - 1];
			for (int j = i + 1; j < m; ++j) {
				if (gcd(dv[i], dv[j]) == 1) {
					for (int l = 1; l < k; ++l) {
						D[j][l] += D[i][l - 1];
					}
				}
			}
		}
		out.println(ans);
	}

	private int gcd(int i, int j) {
		if (i == 0) return j;
		return gcd(j % i, i);
	}

	final String FILE_NAME = "divisors";

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
		new Thread(new divisors_ab()).start();
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