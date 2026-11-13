import java.io.*;
import java.util.*;

public class checkpaint_pk {

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
		int m = nextInt();
		int n = nextInt();
		int[] a = new int[m + 1];
		for (int i = 0; i < n; i++) {
			int x = nextInt() - 1;
			int y = nextInt();
			a[x]++;
			a[y]--;
		}
		int t = 0;
		for (int i = 0; i< m; i++) {
			t += a[i];
			if (t <= 0) {
				out.println("NO");
				return;
			}
		}
		out.println("YES");
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("checkpaint.in"));
			out = new PrintWriter("checkpaint.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new checkpaint_pk().run();
	}
}
