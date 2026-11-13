import java.io.*;
import java.util.*;

public class frog_pk {

	PrintWriter out;
	BufferedReader br;
	StringTokenizer st;

	String nextToken() throws IOException {
		while ((st == null) || (!st.hasMoreTokens()))
			st = new StringTokenizer(br.readLine());
		return st.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	public void solve() throws IOException {
		int n = nextInt();
		int[] a = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = nextInt();
		}
		int cnt = 0;
		int curShift = 0;
		long res = 0;
		for (int i = n - 1; i >= 0; i--) {
			if ((i < n - 1) && (a[i] != a[i + 1])) {
				curShift += cnt;
				cnt = 0;
			}
			if (a[i] - curShift <= 0)
				continue;
			res = res + a[i] - curShift;
			cnt++;
		}
		out.println(res);
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("frog.in"));
			out = new PrintWriter("frog.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new frog_pk().run();
	}
}
