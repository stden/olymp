import java.io.*;
import java.util.*;

public class chess_sm_slow {

	void solve() throws IOException {
		int m = nextInt();
		assert 1 <= m && m <= 1e9;
		int n = nextInt();
		assert 1 <= n && n <= 1e9;
		int i = nextInt();
		assert 1 <= i && i <= m;
		int j = nextInt();
		assert 1 <= j && j <= n;
		int c = nextInt();
		assert c == 0 || c == 1;
		int[][] color = new int[m][n];
		for (int x = 0; x < m; x++) {
			for (int y = 0; y < n; y++) {
				color[x][y] = (Math.abs(x - i) + Math.abs(y - j) + c) % 2;
			}
		}
		int w = 0;
		int b = 0;
		for (int x = 0; x < m; x++) {
			for (int y = 0; y < n; y++) {
				if (color[x][y] == 1) {
					w++;
				} else {
					b++;
				}
			}
		}
		if (w == b) {
			out.println("equal");
		} else if (w > b) {
			out.println("white");
		} else {
			out.println("black");
		}
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;

	final String filename = "chess";

	public void run() {
		try {
			br = new BufferedReader(new FileReader(filename + ".in"));
			out = new PrintWriter(filename + ".out");
			solve();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	String nextToken() {
		try {
			while (st == null || !st.hasMoreTokens()) {
				String s = br.readLine();
				if (s == null) {
					return null;
				}
				st = new StringTokenizer(s);
			}
			return st.nextToken();
		} catch (IOException e) {
			throw new RuntimeException();
		}
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	long nextLong() {
		return Long.parseLong(nextToken());
	}

	public static void main(String[] args) {
		new chess_sm_slow().run();
	}
}
