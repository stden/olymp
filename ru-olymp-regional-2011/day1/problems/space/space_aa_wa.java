import java.io.*;
import java.util.*;
import java.math.*;

public class space_aa_wa {
	public static void main(String[] args) {
		new space_aa_wa().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("space.in"));
			out = new PrintWriter("space.out");
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
		int n = inBounds(nextInt(), 1, 1000, "n");
		int k = inBounds(nextInt(), 1, 5, "k");
		int[] x = new int[n];
		int[] y = new int[n];
		int MEGA = 51;
		int[] left = new int[MEGA];
		Arrays.fill(left, 51);
		int[] right = new int[MEGA];
		for (int i = 0; i < x.length; i++) {
			x[i] = inBounds(nextInt(), 1, 50, "x_" + (i + 1));
			y[i] = inBounds(nextInt(), 1, 50, "y_" + (i + 1));
			left[y[i]] = Math.min(left[y[i]], x[i]);
			right[y[i]] = Math.max(right[y[i]], x[i]);
		}
		int[][][] a = new int[MEGA][51][1 << (2 * k)];
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < a[i].length; j++) {
				Arrays.fill(a[i][j], Integer.MAX_VALUE / 2);
			}
		}
		int start = 0;
		for (int i = 1; i <= k; i++) {
			if (left[i] > right[i]) {
				start |= 3 << (2 * (i - 1));
			}
			if (1 <= left[i] && left[i] <= k) {
				start |= 1 << (2 * (i - 1));
			}
			if (1 <= right[i] && right[i] <= k) {
				start |= 2 << (2 * (i - 1));
			}
		}
		// System.out.println(Integer.toBinaryString(start));
		a[k][1][start] = 0;
		for (int i = 0; i < a.length; i++) {
			for (int j = a[i].length - 1; j >= 0; j--) {
				for (int prof = 0; prof < a[i][j].length; prof++) {
					if (a[i][j][prof] >= Integer.MAX_VALUE / 2) {
						continue;
					}
					if (j > 0) {
						int np = prof;
						for (int q = 0; q < k; q++) {
							if (left[i - q] > right[i - q]) {
								np |= 3 << (2 * (k - 1 - q));
							}
							if (j - 1 <= left[i - q]
									&& left[i - q] <= j + k - 2) {
								np |= 1 << (2 * (k - 1 - q));
							}
							if (j - 1 <= right[i - q]
									&& right[i - q] <= j + k - 2) {
								np |= 2 << (2 * (k - 1 - q));
							}
						}
						a[i][j - 1][np] = Math.min(a[i][j - 1][np],
								a[i][j][prof] + 1);
					}
				}
			}
			for (int j = 0; j < a[i].length; j++) {
				for (int prof = 0; prof < a[i][j].length; prof++) {
					if (a[i][j][prof] >= Integer.MAX_VALUE / 2) {
						continue;
					}
					if (j + 1 < a[i].length) {
						int np = prof;
						for (int q = 0; q < k; q++) {
							if (left[i - q] > right[i - q]) {
								np |= 3 << (2 * (k - 1 - q));
							}
							if (j + 1 <= left[i - q] && left[i - q] <= j + k) {
								np |= 1 << (2 * (k - 1 - q));
							}
							if (j + 1 <= right[i - q] && right[i - q] <= j + k) {
								np |= 2 << (2 * (k - 1 - q));
							}
						}
						// if (i == 3 && j == 8 && prof == 12) {
						// System.err.println(np);
						// }
						a[i][j + 1][np] = Math.min(a[i][j + 1][np],
								a[i][j][prof] + 1);
					}
				}
			}
			for (int j = 0; j < a[i].length; j++) {
				for (int prof = 0; prof < a[i][j].length; prof++) {
					if (a[i][j][prof] >= Integer.MAX_VALUE / 2) {
						continue;
					}
					if ((prof & 3) == 3 && i + 1 < a.length) {
						int np = prof >> 2;
						if (left[i + 1] > right[i + 1]) {
							np |= 3 << (2 * (k - 1));
						}
						if (j <= left[i + 1] && left[i + 1] <= j + k - 1) {
							np |= 1 << (2 * (k - 1));
						}
						if (j <= right[i + 1] && right[i + 1] <= j + k - 1) {
							np |= 2 << (2 * (k - 1));
						}
						// System.out.println(i + " " + j + " " + prof + " "
						// + a[i][j][prof] + " " + np);
						a[i + 1][j][np] = Math.min(a[i + 1][j][np],
								a[i][j][prof] + 1);
					}
				}
			}
		}
		int maxy = k;
		for (int i = 0; i < y.length; i++) {
			maxy = Math.max(maxy, y[i]);
		}
		int ans = Integer.MAX_VALUE / 2;
		int prof = (1 << (2 * k)) - 1;
		for (int i = 0; i < a[maxy].length; i++) {
			ans = Math.min(ans, a[maxy][i][prof]);
		}
		out.println(ans);
	}
}
