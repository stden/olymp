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

public class divisors_sm {
	void rec(int prev, int last, int product, int count) {
		if (count == k) {
			ans++;
			return;
		}
		for (int i = last + 1; i < ndivisors.length; i++) {
			long pr = (long) product * ndivisors[i];
			if (pr > n)
				return;
			if (product * pow(ndivisors[i], k - count) > n)
				return;
			if (gcd(prev, ndivisors[i]) == 1) {
				rec(ndivisors[i], i, (int) pr, count + 1);
			}
		}
	}

	int[] ndivisors;
	int ans;
	int n, k;

	private int gcd(int a, int b) {
		if (b == 0)
			return a;
		return gcd(b, a % b);
	}

	private int[] divisors(int n) {
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

	private double pow(int a, int pow) {
		return Math.pow(a, pow);
	}

	void solve() {
		int n = nextInt();
		assert 2 <= n && n <= 1e8;
		int k = nextInt();
		assert 2 <= k && k <= 10;
		ndivisors = divisors(n);
		this.n = n;
		this.k = k;
		ans = 0;
		rec(1, -1, 1, 0);
		out.println(ans);
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
		new divisors_sm().run();
	}
}
