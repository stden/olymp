import java.io.*;
import java.util.*;

public class StressGen {

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
		Random rnd = new Random();
		int n = rnd.nextInt(5) + 1;
		int m = rnd.nextInt(5) + 1;
		out.println(n + " " + m);
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				out.print(rnd.nextInt(10) + 1);
				if (j < m - 1) {
					out.print(' ');
				}
			}
			out.println();
		}
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			// br = new BufferedReader(new FileReader("StressGen.in"));
			out = new PrintWriter("forest.in");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new StressGen().run();
	}
}
