import java.io.*;
import java.util.*;

public class checkpaint_bm {
	FastScanner in;
	PrintWriter out;

	void solve() {
		int m = in.nextInt();
		int n = in.nextInt();
		int[] sum = new int[m + 1];
		for (int i = 0; i < n; i++) {
			int l = in.nextInt() - 1;
			int r = in.nextInt();
			sum[l]++;
			sum[r]--;
		}
		boolean ans = true;
		int curSum = 0;
		for (int i = 0; i < m; i++) {
			curSum += sum[i];
			if (curSum <= 0) ans = false;
		}
		if (ans) {
			out.println("YES");
		} else {
			out.println("NO");
		}
	}

	void run() {
		try {
			in = new FastScanner(new File("checkpaint.in"));
			out = new PrintWriter(new File("checkpaint.out"));

			solve();

			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	void runIO() {

		in = new FastScanner(System.in);
		out = new PrintWriter(System.out);

		solve();

		out.close();
	}

	class FastScanner {
		BufferedReader br;
		StringTokenizer st;

		public FastScanner(File f) {
			try {
				br = new BufferedReader(new FileReader(f));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		public FastScanner(InputStream f) {
			br = new BufferedReader(new InputStreamReader(f));
		}

		String next() {
			while (st == null || !st.hasMoreTokens()) {
				String s = null;
				try {
					s = br.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (s == null)
					return null;
				st = new StringTokenizer(s);
			}
			return st.nextToken();
		}

		boolean hasMoreTokens() {
			while (st == null || !st.hasMoreTokens()) {
				String s = null;
				try {
					s = br.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (s == null)
					return false;
				st = new StringTokenizer(s);
			}
			return true;
		}

		int nextInt() {
			return Integer.parseInt(next());
		}

		long nextLong() {
			return Long.parseLong(next());
		}
	}

	public static void main(String[] args) {
		new checkpaint_bm().run();
	}
}