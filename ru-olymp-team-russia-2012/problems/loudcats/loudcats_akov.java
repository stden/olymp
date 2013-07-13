import java.util.*;
import java.io.*;

public class loudcats_akov {
	FastScanner in;
	PrintWriter out;

	public void solve() throws IOException {
		int n = in.nextInt(), m = in.nextInt(), a = in.nextInt();
		int[] b = new int[n * m];
		int ans = 0;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				b[i * m + j] = in.nextInt();
				if (i != 0 && 2 * b[(i - 1) * m + j] < b[i * m + j]) {
					ans += a;
				}
			}
		}
		out.println(ans);
	}

	public void run() {
		try {
			in = new FastScanner(new File("loudcats.in"));
			out = new PrintWriter(new File("loudcats.out"));

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
			while (st == null || !st.hasMoreTokens()) {
				try {
					st = new StringTokenizer(br.readLine());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
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
		new loudcats_akov().run();
	}
}