import java.io.*;
import java.util.*;
import java.math.*;

public class chess_aa_group1_check {
	public static void main(String[] args) {
		new chess_aa_group1_check().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("chess.in"));
			out = new PrintWriter("chess.out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (Exception e) {
				eof = true;
				return "0";
			}
		}
		return st.nextToken();
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	void myAssert(boolean u, String message) {
		if (!u) {
			throw new Error("Assertion failed!!! " + message);
		}
	}

	int inBounds(int x, int l, int r, String name) {
		myAssert(l <= x && x <= r, name + " = " + x + " is not in [" + l + ".."
				+ r + "]");
		return x;
	}

	private void solve() throws IOException {
		int m = inBounds(nextInt(), 1, 100, "m");
		int n = inBounds(nextInt(), 1, 100, "n");
		int i = inBounds(nextInt(), 1, m, "i");
		int j = inBounds(nextInt(), 1, n, "j");
		int c = inBounds(nextInt(), 0, 1, "c");
		a = new int[m][n];
		for (int k = 0; k < a.length; k++) {
			Arrays.fill(a[k], -1);
		}
		dfs(i - 1, j - 1, c);
		int[] cnt = new int[2];
		for (int k = 0; k < a.length; k++) {
			for (int l = 0; l < a[k].length; l++) {
				cnt[a[k][l]]++;
			}
		}
		if (cnt[0] > cnt[1]) {
			out.println("black");
		} else if (cnt[0] == cnt[1]) {
			out.println("equal");
		} else {
			out.println("white");
		}
	}

	private void dfs(int i, int j, int c) {
		a[i][j] = c;
		for (int dx = -1; dx < 2; dx++) {
			for (int dy = -1 * (1 - Math.abs(dx)); dy < 1 + (1 - Math.abs(dx)); dy++) {
				int nx = i + dx;
				int ny = j + dy;
				if (0 <= nx && nx < a.length && 0 <= ny && ny < a[nx].length
						&& a[nx][ny] < 0) {
					dfs(nx, ny, c ^ 1);
				}
			}
		}
	}

	int[][] a;

}
