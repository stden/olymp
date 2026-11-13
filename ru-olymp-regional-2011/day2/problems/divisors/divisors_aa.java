import java.io.*;
import java.util.*;

public class divisors_aa {
	public static void main(String[] args) {
		new divisors_aa().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("divisors.in"));
			out = new PrintWriter("divisors.out");
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
		int n = inBounds(nextInt(), 2, 100000000, "n");
		int k = inBounds(nextInt(), 2, 10, "k");
		TreeSet<Integer> ts = new TreeSet<Integer>();
		for (int i = 1; i * i <= n; i++) {
			if (n % i == 0) {
				ts.add(i);
				ts.add(n / i);
			}
		}
		int[] d = new int[ts.size()];
		{
			int q = 0;
			for (int x : ts) {
				d[q++] = x;
			}
		}
		@SuppressWarnings("unchecked")
		ArrayList<Integer>[] good = new ArrayList[d.length];
		for (int i = 0; i < good.length; i++) {
			good[i] = new ArrayList<Integer>();
			for (int j = i + 1; j < good.length; j++) {
				if (gcd(d[i], d[j]) == 1) {
					good[i].add(j);
				}
			}
		}
		long[][] pow = new long[d.length][k + 1];
		for (int i = 0; i < pow.length; i++) {
			pow[i][0] = 1;
			for (int j = 1; j < pow[i].length; j++) {
				pow[i][j] = pow[i][j - 1] * d[i];
				if (pow[i][j] > n) {
					pow[i][j] = n + 1;
				}
			}
		}
		@SuppressWarnings("unchecked")
		Map<Integer, Integer>[][] a = new Map[d.length + 1][k + 1];
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < a[i].length; j++) {
				a[i][j] = new HashMap<Integer, Integer>();
			}
		}
		a[0][0].put(1, 1);
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j + 1 < a[i].length; j++) {
				for (int x : a[i][j].keySet()) {
					int z = a[i][j].get(x);
					if (i > 0) {
						for (int qq : good[i - 1]) {
							int q = qq + 1;
							long ff = 1L * x * d[q - 1];
							if (ff > n || x * pow[q - 1][k - j] > n) {
								break;
							}
							int y = (int) ff;
							if (!a[q][j + 1].containsKey(y)) {
								a[q][j + 1].put(y, 0);
							}
							a[q][j + 1].put(y, a[q][j + 1].get(y) + z);
						}
					} else {
						for (int q = 1; q < a.length; q++) {
							int y = d[q - 1];
							if (!a[q][j + 1].containsKey(y)) {
								a[q][j + 1].put(y, 0);
							}
							a[q][j + 1].put(y, a[q][j + 1].get(y) + z);
						}
					}
				}
			}
		}
		int ans = 0;
		for (int i = 0; i < a.length; i++) {
			for (int x : a[i][k].values()) {
				ans += x;
			}
		}
		out.println(ans);
	}

	private int gcd(int a, int b) {
		while (b != 0) {
			int tmp = a % b;
			a = b;
			b = tmp;
		}
		return a;
	}

}
