import java.io.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;
import java.util.StringTokenizer;

public class fortification_vd {
	BufferedReader in;
	StringTokenizer str;
	PrintWriter out;
	String SK;

	String next() throws IOException {
		while ((str == null) || (!str.hasMoreTokens())) {
			SK = in.readLine();
			if (SK == null)
				return null;
			str = new StringTokenizer(SK);
		}
		return str.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(next());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(next());
	}

	long nextLong() throws IOException {
		return Long.parseLong(next());
	}

	int get(int v) {
		return par[v] = (v == par[v]) ? v : get(par[v]);
	}

	Random rnd = new Random(239);

	void union(int st, int en) {
		if (rnd.nextBoolean()) {
			par[en] = st;
		} else {
			par[st] = en;
		}
	}

	int[] par;

	void solve() throws IOException {
		int n = nextInt();
		int m = nextInt();
		par = new int[n];
		for (int i = 0; i < n; i++) {
			par[i] = i;
		}
		int[] count = new int[n];
		int[] min = new int[n];
		int[] pow = new int[n];
		Arrays.fill(min, Integer.MAX_VALUE);
		for (int i = 0; i < m; i++) {
			int st = nextInt() - 1;
			int en = nextInt() - 1;
			pow[st]++;
			pow[en]++;
			union(get(st), get(en));
		}
		for (int i = 0; i < n; i++) {
			int x = get(i);
			count[x]++;
			min[x] = Math.min(min[x], pow[i]);
		}
		long res = 1;
		long mod = (long) (1e+9 + 7);
		for (int i = 0; i < n; i++) {
			if (count[i] != 0 && min[i] > 1) {
				res = (res * (long) (count[i])) % mod;
			}
		}
		out.println(res);
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("fortification.in"));
		out = new PrintWriter("fortification.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new fortification_vd().run();
	}

}