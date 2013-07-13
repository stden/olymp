import java.io.*;
import java.util.StringTokenizer;

public class init_vd_ok2 {
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
		long[][][] dp = new long[n + 3][m + 1][m + 1];
		for (int i = 1; i <= m; i++) {
			dp[1][i][i] = 1;
		}
		for (int i = 1; i <= n; i++) {
			if (i != 1) {
				long[][] newdp = new long[m + 1][m + 1];
				for (int j = 1; j <= m; j++) {
					for (int k = 0; k <= j; k++) {
						for (int t = 0; t + j <= m; t++) {
							newdp[j + t][k + t] += dp[i][j][k] * c[j + t][t];
							newdp[j + t][k + t] %= mod;
						}
					}
				}
				dp[i] = newdp;
			}
			for (int j = 1; j <= m; j++) {
				for (int k = 1; k <= j; k++) {
					if (k != 0) {
						for (int t = 0; t <= k; t++) {
							dp[i + 1][j][t] += (dp[i][j][k] * c[k][t])
									% mod;
							dp[i + 1][j][t] %= mod;
						}
					}
				}
			}
		}
		long res = 0;
		for (int i = 1; i <= m; i++) {
			res = (res + dp[n][m][i]) % mod;
		}
		out.println(res);
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("init.in"));
		out = new PrintWriter("init.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new init_vd_ok2().run();
	}

}