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

public class divisors_sm_dp2_wrong {
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
		HashMap<Integer, HashMap<Pair, Integer>> hm = new HashMap<Integer, HashMap<Pair, Integer>>();
		hm.put(1, new HashMap<Pair, Integer>());
		hm.get(1).put(new Pair(0, 0), 1);
		TreeSet<Integer> cur = new TreeSet<Integer>();
		cur.add(1);
		int ans = 0;
		int i = 0;
		while (true) {
			Integer next = cur.higher(i);
			if (next == null)
				break;
			i = next;
			HashMap<Pair, Integer> ai = hm.get(i);
			for (Map.Entry<Pair, Integer> p : ai.entrySet()) {
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

	void solve() {
		int n = nextInt();
		assert 2 <= n && n <= 1e8;
		int k = nextInt();
		assert 2 <= k && k <= 10;
		out.println(solve3(n, k));
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
		new divisors_sm_dp2_wrong().run();
	}
}
