import java.util.*;
import java.io.*;

public class forest_akov_slow {
	FastScanner in;
	PrintWriter out;

	int[] di = { 1, 0, -1, 0 }, dj = { 0, 1, 0, -1 };

	public void solve() throws IOException {
		int n = in.nextInt(), m = in.nextInt();
		int[][] a = new int[n][m];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				a[i][j] = in.nextInt();
			}
		}
		for (int year = 0;; year++) {
			boolean wasDiffer = false;
			int[][] next = new int[n][m];
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					next[i][j] = a[i][j];
					for (int ii = 0; ii < di.length; ii++) {
						int si = i + di[ii], sj = j + dj[ii];
						if (si >= 0 && si < n && sj >= 0 && sj < m && a[si][sj] == a[i][j] + 1) {
							next[i][j]++;
							wasDiffer = true;
							break;
						}
					}
				}
			}
			a = next;
			if (!wasDiffer) {
				out.println(year);
				for (int i = 0; i < n; i++) {
					for (int j = 0; j < m; j++) {
						out.print(a[i][j] + " ");
					}
					out.println();
				}
				break;
			}
		}
	}

	public void run() {
		try {
			in = new FastScanner(new File("forest.in"));
			out = new PrintWriter(new File("forest.out"));

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
		new forest_akov_slow().run();
	}
}