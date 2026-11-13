import java.io.*;
import java.util.*;

public class TestGen {
	public static void main(String[] args) {
		new TestGen().run();
	}

	BufferedReader br;
	StringTokenizer in;
	PrintWriter out;

	public String nextToken() throws IOException {
		while (in == null || !in.hasMoreTokens()) {
			in = new StringTokenizer(br.readLine());
		}
		return in.nextToken();
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

	int tNumber;

	Random rnd;

	void print(int n, int m) throws IOException {
		if (tNumber < 10) {
			out = new PrintWriter("../tests/0" + tNumber);
		} else {
			out = new PrintWriter("../tests/" + tNumber);
		}
		out.println(n + " " + m);
		out.close();
		tNumber++;
	}

	public void solve() throws IOException {
		tNumber = 1;
		rnd = new Random(23);
		print(2, 2);
		for (int i = 1; i <= 3; i++) {
			for (int j = 1; j <= 3; j++) {
				if (i != 2 || j != 2) {
					print(i, j);
				}
			}
		}
		for (int i = 0; i < 19; i++) {
			print(rnd.nextInt(12) + 4, rnd.nextInt(12) + 4);
		}
		print(70, 70);
		print(70, 1);
		print(1, 70);
		for (int i = 0; i < 10; i++) {
			print(70, rnd.nextInt(69) + 1);
			print(rnd.nextInt(69) + 1, 70);
		}
		for (int i = 0; i < 19; i++) {
			print(rnd.nextInt(55) + 16, rnd.nextInt(55) + 16);
		}
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}