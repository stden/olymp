import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeSet;

public class divisors_sm_comparing {
	void rec(int last, int product, int count) {
		if (count == k) {
			ans++;
			return;
		}
		int prev = ndivisors[last];
		for (int i = last + 1; i < ndivisors.length; i++) {
			long pr = (long) product * ndivisors[i];
			if (pr > n)
				return;
			// if (product * pow(ndivisors[i], k - count) > n)
			// return;
			if (gcd(prev, ndivisors[i]) == 1) {
				rec(i, (int) pr, count + 1);
			}
		}
	}

	int[] ndivisors;
	int ans;
	int n, k;

	int solve1(int n, int k) {
		ndivisors = divisors(n);
		this.n = n;
		this.k = k;
		ans = 0;
		rec(0, 1, 0);
		return ans;
	}

	int gcd(int a, int b) {
		if (b == 0)
			return a;
		return gcd(b, a % b);
	}

	int[] divisors(int n) {
		ArrayList<Integer> al = new ArrayList<Integer>();
		for (int i = 1; i * i <= n; i++) {
			if (n % i == 0) {
				al.add(i);
				if (n / i != i) {
					al.add(n / i);
				}
			}
		}
		int[] ret = new int[al.size()];
		for (int i = 0; i < ret.length; i++) {
			ret[i] = al.get(i);
		}
		Arrays.sort(ret);
		return ret;
	}

	int solve2(int n, int k) {
		int[] div = divisors(n);
		// int[][][] a = new int[n + 1][][];
		HashMap<Integer, int[][]> hm = new HashMap<Integer, int[][]>();
		// a[1] = new int[k + 1][div.length];
		hm.put(1, new int[k + 1][div.length]);
		hm.get(1)[0][0] = 1;
		TreeSet<Integer> cur = new TreeSet<Integer>();
		cur.add(1);
		// a[1][0][0] = 1;
		int ans = 0;
		int i = 0;
		while (true) {
			Integer next = cur.higher(i);
			if (next == null)
				break;
			i = next;
			int[][] ai = hm.get(i);
			// if (a[i] == null) {
			// fail++;
			// continue;
			// }
			for (int j = 0; j < k; j++) {
				for (int q = 0; q < div.length; q++) {
					if (ai[j][q] > 0) {
						int prev = div[q];
						for (int t = q + 1; t < div.length; t++) {
							int mul = div[t];
							if (i * (long) mul > n)
								break;
							if (gcd(mul, prev) == 1) {

								if (hm.get(i * mul) == null) {
									hm.put(i * mul, new int[k + 1][div.length]);
									cur.add(i * mul);
								}
								hm.get(i * mul)[j + 1][t] += ai[j][q];
							}
						}
					}
				}
			}
			for (int j = 0; j < div.length; j++) {
				ans += ai[k][j];
			}
		}
		// System.err.println(cur.size() + " " + k + " " + div.length + " = " + cur.size() * k * div.length);
		return ans;
	}

	static class Pair {
		int x, y;

		public Pair(int x, int y) {
			super();
			this.x = x;
			this.y = y;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + x;
			result = prime * result + y;
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Pair other = (Pair) obj;
			if (x != other.x)
				return false;
			if (y != other.y)
				return false;
			return true;
		}

	}

	int solve3(int n, int k) {
		int[] div = divisors(n);
		// int[][][] a = new int[n + 1][][];
		HashMap<Integer, HashMap<Pair, Integer>> hm = new HashMap<Integer, HashMap<Pair, Integer>>();
		// a[1] = new int[k + 1][div.length];
		hm.put(1, new HashMap<Pair, Integer>());
		hm.get(1).put(new Pair(0, 0), 1);
		TreeSet<Integer> cur = new TreeSet<Integer>();
		cur.add(1);
		// a[1][0][0] = 1;
		int ans = 0;
		int i = 0;
		while (true) {
			Integer next = cur.higher(i);
			if (next == null)
				break;
			i = next;
			HashMap<Pair, Integer> ai = hm.get(i);
			// if (a[i] == null) {
			// fail++;
			// continue;
			// }
			for (Map.Entry<Pair, Integer> p : ai.entrySet()) {
				// for (int j = 0; j < k; j++) {
				// for (int q = 0; q < div.length; q++) {
				int j = p.getKey().x;
				int q = p.getKey().y;
				int aijq = p.getValue();
				if (j == k) {
					ans += aijq;
					continue;
				}
				int prev = div[q];
				for (int t = q + 1; t < div.length; t++) {
					int mul = div[t];
					if (i * (long) mul > n)
						break;
					if (i * pow(mul, k - j) > n)
						break;
					if (gcd(mul, prev) == 1) {

						if (hm.get(i * mul) == null) {
							hm.put(i * mul, new HashMap<Pair, Integer>());
							cur.add(i * mul);
						}
						HashMap<Pair, Integer> to = hm.get(i * mul);
						Pair pr = new Pair(j + 1, t);
						if (to.containsKey(pr)) {
							to.put(pr, to.get(pr) + aijq);
						} else {
							to.put(pr, aijq);
						}

					}
				}

			}
		}
		return ans;
	}

	private double pow(int a, int pow) {
		return Math.pow(a, pow);
	}

	final int[] INTERESTING_N = { 1, 2, 4, 6, 12, 24, 36, 48, 60, 120, 180, 240, 360, 720, 840, 1260, 1680, 2520, 5040,
			7560, 10080, 15120, 20160, 25200, 27720, 45360, 50400, 55440, 83160, 110880, 166320, 221760, 277200,
			332640, 498960, 554400, 665280, 720720, 1081080, 1441440, 2162160, 2882880, 3603600, 4324320, 6486480,
			7207200, 8648640, 10810800, 14414400, 17297280, 21621600, 32432400, 36756720, 43243200, 61261200, 73513440,
			110270160, 122522400, 147026880, 183783600, 245044800, 294053760, 367567200, 551350800, 698377680,
			735134400, 1102701600, 1396755360 };

	void solve() {
		int n = nextInt();
		System.err.println("n = " + n + " number of divisors = " + divisors(n).length);
		for (int k = 1; k <= 13; k++) {
			System.gc();
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
			long time = System.nanoTime();
			int res1 = solve1(n, k);
			double time1 = (System.nanoTime() - time) / 1e9;
			// time = System.nanoTime();
			// int res2 = solve2(n, k);
			int res2 = res1;
			// double time2 = (System.nanoTime() - time) / 1e9;
			time = System.nanoTime();
			int res3 = solve3(n, k);
			double time3 = (System.nanoTime() - time) / 1e9;
			if (res1 != res2 || res1 != res3) {
				throw new AssertionError("k = " + k + " res1 = " + res1 + " res2 = " + res2 + " res3 = " + res3);
			}
			System.err.printf(k + " -> " + res1 + " (recursive: %.1f secons, dinamic2: %.1f sec)\n", time1, time3);
			// System.err.printf(k + " -> " + res1 +
			// " (recursive: %.1f secons, dinamic: %.1f sec, dinamic2: %.1f sec)\n",
			// time1, time2, time3);
		}
		// int k = nextInt();
		// out.println(solve(n, k));
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;

	public void run() {
		try {
			String filename = "divisors";
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


	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new divisors_sm_comparing().run();
	}
}
