import java.io.*;
import java.util.*;

public class forest_pk_slow {

	PrintWriter out;
	BufferedReader br;
	StringTokenizer st;

	String nextToken() throws IOException {
		while ((st == null) || (!st.hasMoreTokens()))
			st = new StringTokenizer(br.readLine());
		return st.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	public void solve() throws IOException {
		int n = nextInt();
		int m = nextInt();
		int[][] a = new int[n][m];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				a[i][j] = nextInt();
			}
		}
		
		boolean fl = true;
		int ans = 0;
		while (fl) {
			fl = false;
			int[][] newA = new int[n][m];
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					newA[i][j] = a[i][j];
					if ((i - 1 >= 0) && (a[i - 1][j] == a[i][j] + 1)) {
						newA[i][j] = a[i][j] + 1;
					}
					if (i + 1 < n && (a[i + 1][j] == a[i][j] + 1)) {
						newA[i][j] = a[i][j] + 1;
					}
					if (j - 1 >= 0 && a[i][j - 1] == a[i][j] + 1) {
						newA[i][j] = a[i][j] + 1;
					}
					if (j + 1 < m && a[i][j + 1] == a[i][j] + 1) {
						newA[i][j] = a[i][j] + 1;
					}
					if (newA[i][j] == a[i][j] + 1)
						fl = true;
				}
			}
			a = newA;
			ans++;
		}
		System.err.println(ans - 1);
		out.println(ans - 1);
		for (int i = 0; i < n; i++) {
			for (int j = 0; j< m; j++) {
				out.print(a[i][j]);
				if (j < m - 1) {
					out.print(' ');
				}
			}
			out.println();
		}
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("forest.in"));
			out = new PrintWriter("forest.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new forest_pk_slow().run();
	}
}
