import java.util.*;
import java.io.*;

public class half_akov {
	FastScanner in;
	PrintWriter out;

	public void solve() throws IOException {
		int n = in.nextInt() * 2, k = in.nextInt();
		boolean[] can = new boolean[n + 1];
		can[n] = true;
		for (int i = 0; i < k; i++) {
			boolean[] next = new boolean[n + 1];
			for (int j = 0; j <= n; j++) {
				if (can[j]) {
					if (j % 2 == 0) {
						next[j / 2] = true;
					}
					if (j > 0) {
						next[j - 1] = true;
					}
				}
			}
			can = next;
		}
		int count = 0;
		for (int i = 0; i <= n; i++) {
			if (can[i]) {
				count++;
			}
		}
		out.println(count);
		for (int i = 0; i <= n; i++) {
			if (can[i]) {
				out.print(i * 0.5 + " ");
			}
		}
	}

	public void run() {
		try {
			in = new FastScanner(new File("half.in"));
			out = new PrintWriter(new File("half.out"));

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
		new half_akov().run();
	}
}