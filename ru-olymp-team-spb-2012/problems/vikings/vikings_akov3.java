import java.util.*;
import java.io.*;
//can 1e-12
public class vikings_akov3 {
	FastScanner in;
	PrintWriter out;

	double R, d;
	
	public double dist(double ang) {
		double dx = R * Math.cos(ang) + R;
		double dy = R * Math.sin(ang);
		return Math.sqrt(dx * dx + dy * dy);
	}


	public void solve() throws IOException {
		R = in.nextDouble();
		d = in.nextDouble();
		double l = Math.PI;
		double r = 0;
		for (int iter = 0; iter < 1000000; iter++) {
			double m = (r + l) / 2;
			if (dist(m) > d) {
				r = m;
			} else {
				l = m;
			}
		}
		out.println(-R + " " + 0);
		out.println(R * Math.cos(l) + " " + R * Math.sin(l));
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
		new vikings_akov3().run();
	}
}