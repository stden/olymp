import java.io.*;
import java.util.StringTokenizer;

public class init_vd_wa {
	BufferedReader in;
	StringTokenizer str;
	PrintWriter out;
	String SK;

	String next() throws IOException {
		while ((str == null) || (!str.hasMoreTokens())) {
			SK = in.readLine();
			if (SK == null)
				return null;
			str = new StringTokenizer(SK);
		}
		return str.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(next());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(next());
	}

	long nextLong() throws IOException {
		return Long.parseLong(next());
	}

	void solve() throws IOException {
		int n = nextInt();
		int m = nextInt();

		long mod = (long) (1e+9 + 7);

		long[][] c = new long[101][101];
		for (int i = 0; i <= 100; i++) {
			c[i][0] = 1;
			for (int j = 1; j <= i; j++) {
				c[i][j] = (c[i - 1][j] + c[i - 1][j - 1]) % mod;
			}
		}

		long[][] any = new long[n + 1][m + 1];
		for (int i = 0; i <= n; i++) {
			any[i][0] = 1;
		}
		for (int i = 0; i <= n; i++) {
			for (int j = 1; j <= m; j++) {
				any[i][j] = any[i][j - 1] * ((i + 1L) * i / 2) % mod;
			}
		}

		long[][] fill = new long[n + 1][m + 1];
		fill[0][0] = 1;
		for (int i = 1; i <= n; i++) {
			for (int j = 1; j <= m; j++) {
				fill[i][j] = any[i][j];
				for (int first = 0; first < i; first++) {
					for (int k = 0; k <= j; k++) {
						fill[i][j] = (fill[i][j] + mod - ((fill[first][k] * any[i
								- first - 1][j - k]) * c[j][k])
								% mod)
								% mod;
					}
				}
			}
		}
		out.println(fill[n][m]);
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("init.in"));
		out = new PrintWriter("init.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new init_vd_wa().run();
	}

}