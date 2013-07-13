import java.util.*;
import java.io.*;

public class python_akov {
	FastScanner in;
	PrintWriter out;

	public void solve() throws IOException {
		int n = in.nextInt(), m = in.nextInt();
		out.print(n / (m + 1) + " ");
		if ((n + 1) % m == 0) {
			out.println((n + 1) / m - 1);
		} else {
			out.println((n + 1) / m);
		}
		}

	public void run() {
		try {
			in = new FastScanner(new File("python.in"));
			out = new PrintWriter(new File("python.out"));

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class FastScanner {
		BufferedReader br;
		StringTokenizer st;

		FastScanner(File f) {
			try {
				br = new BufferedReader(new FileReader(f));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		String next() {
			while (st == null || !st.hasMoreTokens()) {
				try {
					st = new StringTokenizer(br.readLine());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return st.nextToken();
		}

		int nextInt() {
			return Integer.parseInt(next());
		}

		long nextLong() {
			return Long.parseLong(next());
		}

		double nextDouble() {
			return Double.parseDouble(next());
		}

	}

	public static void main(String[] arg) {
		new python_akov().run();
	}
}