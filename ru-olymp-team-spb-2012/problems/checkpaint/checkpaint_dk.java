import java.util.*;
import java.io.*;

public class checkpaint_dk {
	BufferedReader br;
	PrintWriter out;
	StringTokenizer stok;

	String nextToken() throws IOException {
		while (stok == null || !stok.hasMoreTokens()) {
			String s = br.readLine();
			if (s == null) {
				return null;
			}
			stok = new StringTokenizer(s);
		}
		return stok.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	char nextChar() throws IOException {
		return (char) (br.read());
	}

	String nextLine() throws IOException {
		return br.readLine();
	}
	
	void solve() throws IOException {
		int size = nextInt(), n = nextInt();
		boolean[] f = new boolean[size + 1];
		for (int i = 0; i < n; i++) {
			int l = nextInt();
			int r = nextInt();
			for (int j = l; j <= r; j++) {
				f[j] = true;
			}
		}
		boolean ans = true;
		for (int i = 1; i <= size; i++) {
			if (f[i] == false) {
				ans = false;
				break;
			}
		}
		if (ans) {
			out.println("YES");
		} else {
			out.println("NO");
		}
	}

	void run() throws IOException {
		br = new BufferedReader(new FileReader("checkpaint.in"));
		out = new PrintWriter("checkpaint.out");
		 //br = new BufferedReader(new FileReader("input.txt"));
		 //out = new PrintWriter("output.txt");
		// br = new BufferedReader(new InputStreamReader(System.in));
		// out = new PrintWriter(System.out);
		solve();
		br.close();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		// Localea.setDefault(Locale.US);
		new checkpaint_dk().run();
	}
}