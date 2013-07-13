import java.util.*;
import java.io.*;
//can 1e-9
public class vikings_akov2 {
	FastScanner in;
	PrintWriter out;

	public void solve() throws IOException {
		double r = in.nextDouble(), l = in.nextDouble();
		l = Math.min(l, 2 * r);
		double h = Math.sqrt(r * r - l * l / 4);
		double sina = h / r;
		double y = r * sina;
		double x = Math.sqrt(r * r - y * y);
		out.println(-x + " " + y);
		out.println(x + " " + y);
	}

	public void run() {
		try {
			in = new FastScanner(new File("vikings.in"));
			out = new PrintWriter(new File("vikings.out"));

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
		new vikings_akov2().run();
	}
}