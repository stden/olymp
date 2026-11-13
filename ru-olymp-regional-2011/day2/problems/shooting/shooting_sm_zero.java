import java.io.*;
import java.util.*;

public class shooting_sm_zero {

	void solve() throws IOException {
		out.println(0);
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;

	final String filename = "shooting";

	public void run() {
		try {
			br = new BufferedReader(new FileReader(filename + ".in"));
			out = new PrintWriter(filename + ".out");
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
				String s = br.readLine();
				if (s == null) {
					return null;
				}
				st = new StringTokenizer(s);
			}
			return st.nextToken();
		} catch (IOException e) {
			throw new RuntimeException();
		}
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	long nextLong() {
		return Long.parseLong(nextToken());
	}

	public static void main(String[] args) {
		new shooting_sm_zero().run();
	}
}
