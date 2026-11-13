import java.util.*;
import java.io.*;

public class rebus_akov {
	FastScanner in;
	PrintWriter out;

	public void solve() throws IOException {
		StringBuilder ans = new StringBuilder();
		String s;
		while ((s = in.next()) != null) {
			int l = 0, r = 0;
			for (int i = 0; i < s.length(); i++) {
				if (s.charAt(i) != '\'') {
					l = i;
					break;
				}
			}
			for (int i = s.length() - 1; i >= 0; i--) {
				if (s.charAt(i) != '\'') {
					r = s.length() - 1 - i;
					break;
				}
			}
			ans.append(s.substring(2 * l, s.length() - 2 * r));
		}
		out.println(ans.toString());
	}

	public void run() {
		try {
			in = new FastScanner(new File("rebus.in"));
			out = new PrintWriter(new File("rebus.out"));

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class FastScanner {
		BufferedReader br;
		StringTokenizer st;

		FastScanner(File f) {
			try {
				br = new BufferedReader(new FileReader(f));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		String next() {
			if (st == null)
				try {
					st = new StringTokenizer(br.readLine());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (!st.hasMoreTokens()) return null;
			return st.nextToken();
		}

		int nextInt() {
			return Integer.parseInt(next());
		}

		long nextLong() {
			return Long.parseLong(next());
		}

		double nextDouble() {
			return Double.parseDouble(next());
		}

	}

	public static void main(String[] arg) {
		new rebus_akov().run();
	}
}