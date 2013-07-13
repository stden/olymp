import java.io.*;
import java.util.*;

public class shooting_sm {

	void solve() throws IOException {
		int n = nextInt();
		assert 3 <= n && n <= 1e5;

		int[] a = new int[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = nextInt();
			assert 1 <= a[i] && a[i] <= 1000;
		}
		int win = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] > a[win]) {
				win = i;
			}
		}
		int max = 0;
		for (int i = win + 1; i < a.length - 1; i++) {
			if (a[i] % 10 == 5 && a[i] > a[i + 1]) {
				max = Math.max(max, a[i]);
			}
		}
		if (max == 0) {
			out.println(0);
			return;
		}
		int pos = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] > max) {
				pos++;
			}
		}
		out.println(pos + 1);
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;

	final String filename = "shooting";

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
		new shooting_sm().run();
	}
}
