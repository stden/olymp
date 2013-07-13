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

public class divisors_sm_dp_wrong {
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
		HashMap<Integer, int[][]> hm = new HashMap<Integer, int[][]>();
		hm.put(1, new int[k + 1][div.length]);
		hm.get(1)[0][0] = 1;
		TreeSet<Integer> cur = new TreeSet<Integer>();
		cur.add(1);
		int ans = 0;
		int i = 0;
		while (true) {
			Integer next = cur.higher(i);
			if (next == null)
				break;
			i = next;
			int[][] ai = hm.get(i);
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
		return ans;
	}



	void solve() {
		int n = nextInt();
		assert 2 <= n && n <= 1e8;
		int k = nextInt();
		assert 2 <= k && k <= 10;
		out.println(solve2(n, k));
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
		new divisors_sm_dp_wrong().run();
	}
}
