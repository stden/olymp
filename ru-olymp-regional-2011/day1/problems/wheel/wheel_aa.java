import java.io.*;
import java.util.*;
import java.math.*;

public class wheel_aa {
	public static void main(String[] args) {
		new wheel_aa().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("wheel.in"));
			out = new PrintWriter("wheel.out");
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
		int n = inBounds(nextInt(), 3, 100, "n");
		int[] p = new int[n];
		for (int i = 0; i < p.length; i++) {
			p[i] = inBounds(nextInt(), 1, 1000, "v_" + (i + 1));
		}
		int a = inBounds(nextInt(), 1, 1000000000, "a");
		int b = inBounds(nextInt(), 1, 1000000000, "b");
		int k = inBounds(nextInt(), 1, 1000000000, "k");
		a = (a - 1) / k;
		b = (b - 1) / k;
		int aa = a;
		int bb = b;
		a %= n;
		b %= n;
		if (b < a) {
			b += n;
		}
		if (bb - aa >= n) {
			b += 2 * n;
		}
		int max = 0;
		int v = 0;
		for (int st = 0; st < p.length; st++) {
			v++;
			if (v > a) {
				for (int i = 0; i < p.length; i++) {
					max = Math.max(max, p[(i + st) % n]);
					if (v > b) {
						break;
					}
					v++;
				}
				break;
			}
		}
		for (int i = 1, j = p.length - 1; i < j; i++, j--) {
			int tmp = p[i];
			p[i] = p[j];
			p[j] = tmp;
		}
		v = 0;
		for (int st = 0; st < p.length; st++) {
			v++;
			if (v > a) {
				for (int i = 0; i < p.length; i++) {
					max = Math.max(max, p[(i + st) % n]);
					if (v > b) {
						break;
					}
					v++;
				}
				break;
			}
		}
		out.println(max);
	}
}
