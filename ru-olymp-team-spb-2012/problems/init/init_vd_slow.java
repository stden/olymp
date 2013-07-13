import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.StringTokenizer;

public class init_vd_slow {
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

		int[] pow = new int[n + 1];
		pow[0] = 1;
		for (int i = 1; i <= n; i++) {
			pow[i] = pow[i - 1] * 2;
		}
		int[][] dp = new int[pow[n]][m+1];
		dp[0][0] = 1;
		int k = pow[n] - 1;
		ArrayList<Integer> fine = new ArrayList<Integer>();
		for (int len = 1; len <= n; len++) {
			int cur = pow[len] - 1;
			while (cur <= k) {
				fine.add(cur);
				cur *= 2;
			}
		}
		int mod = (int) (1e+9 + 7);
		for (int i = 0; i < m; i++) {
			for (int mask = 0; mask <= k; mask++) {
				for (int t : fine) {
					dp[t | mask][i + 1] += dp[mask][i];
					dp[t | mask][i + 1] %= mod;
				}
			}
		}
		out.println(dp[k][m]);

	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("init.in"));
		out = new PrintWriter("init.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new init_vd_slow().run();
	}

}