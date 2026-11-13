import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

public class triangle_sm_wrong2 {

	void solve() {
		int n = nextInt();
		assert 2 <= n && n <= 1000;
		double l = 30;
		double r = 4000;
		double prev = nextDouble();
		for (int it = 0; it < n - 1; it++) {
			double cur = nextDouble();
			assert 30 <= cur && cur <= 4000;
			String outcome = nextToken();
			assert outcome.equals("closer") || outcome.equals("further");
			// важный случай
			//if (Math.abs(prev - cur) < 1e-6)
			//	continue;
			if (outcome.equals("closer")) {
				if (cur > prev) {
					l = Math.max(l, (cur + prev) / 2);
				} else {
					r = Math.min(r, (cur + prev) / 2);
				}
			} else {
				if (cur < prev) {
					l = Math.max(l, (cur + prev) / 2);
				} else {
					r = Math.min(r, (cur + prev) / 2);
				}
			}
			prev = cur;
		}
		out.println(l + " " + r);
	}

	BufferedReader br;
	PrintWriter out;
	StringTokenizer st;

	void run() {
		try {
			br = new BufferedReader(new FileReader("triangle.in"));
			out = new PrintWriter(new FileWriter("triangle.out"));
			solve();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	String nextToken() {
		try {
			while (st == null || !st.hasMoreTokens()) {
				st = new StringTokenizer(br.readLine());
			}
			return st.nextToken();
		} catch (Exception e) {
			return "0";
		}
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	double nextDouble() {
		return Double.parseDouble(nextToken());
	}

	public static void main(String[] args) {
		new triangle_sm_wrong2().run();
	}
}
