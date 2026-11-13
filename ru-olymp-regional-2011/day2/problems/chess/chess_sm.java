import java.io.*;
import java.util.*;

public class chess_sm {

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
		if (m % 2 == 0 || n % 2 == 0) {
			out.println("equal");
		}else
		if ((i + j + c) % 2 == 1) {
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
		new chess_sm().run();
	}
}
