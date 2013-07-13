import java.util.*;
import java.io.*;

public class forest_akov {
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
		int[][] dataQ = new int[2][n * m];
		int[] q = dataQ[0];
		int[] nextQ = dataQ[1];
		int en = 0;
		int nextEn = 0;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				nextQ[nextEn++] = i * m + j;
			}
		}
		boolean[][] u = new boolean[n][m];
		for (int year = 0;; year++) {
			int[] tmp = q;
			q = nextQ;
			nextQ = tmp;
			en = nextEn;
			nextEn = 0;
			boolean wasDiffer = false;
			for (int iter = 0; iter < en; iter++) {
				u[q[iter] / m][q[iter] % m] = false;
			}
			for (int iter = 0; iter < en; iter++) {
				int x = q[iter];
				int i = x / m, j = x % m;
				for (int ii = 0; ii < di.length; ii++) {
					int si = i + di[ii], sj = j + dj[ii];
					if (si >= 0 && si < n && sj >= 0 && sj < m) {
						if (a[si][sj] == a[i][j] - 1 && !u[si][sj]) {
							u[si][sj] = true;
							nextQ[nextEn++] = si * m + sj;
							wasDiffer = true;
						}
						if (a[si][sj] == a[i][j] + 1 && !u[i][j]) {
							u[i][j] = true;
							nextQ[nextEn++] = i * m + j;
							wasDiffer = true;
						}
					}
				}

			}
			for (int iter = 0; iter < nextEn; iter++) {
				a[nextQ[iter] / m][nextQ[iter] % m]++;
			}
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
		new forest_akov().run();
	}
}