import java.io.*;
import java.util.*;

public class vikings_pk {

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
		double rad = nextDouble();
		double d = nextDouble();
		out.println(rad + " " +  0);
		double l = -rad;
		double r = rad;
		for (int i = 0; i < 10000; i++) {
			double c = (l + r) / 2;
			double y = Math.sqrt(rad * rad - c * c);
			if (Math.sqrt(y * y + (rad - c) * (rad - c)) > d) {
				l = c;
			} else {
				r = c;
			}
		}
		out.println(l + " " + Math.sqrt(rad * rad - l * l));
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("vikings.in"));
			out = new PrintWriter("vikings.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new vikings_pk().run();
	}
}
