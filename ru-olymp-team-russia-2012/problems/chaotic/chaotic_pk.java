import java.io.*;
import java.util.*;

public class chaotic_pk {

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
		ArrayList<Integer> ans = new ArrayList<Integer>();
		for (int i = 1; i < n - 1; i++) {
			if ((a[i - 1] < a[i]) == (a[i] < a[i + 1])) {
				ans.add(i + 1);
				int t = a[i + 1];
				a[i + 1] = a[i];
				a[i] = t;
			}
		}
		out.println(ans.size());
		for (int i : ans) {
			out.print(i);
			if (i != ans.get(ans.size() - 1))
				out.print(' ');
		}
		out.println();
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("chaotic.in"));
			out = new PrintWriter("chaotic.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new chaotic_pk().run();
	}
}
