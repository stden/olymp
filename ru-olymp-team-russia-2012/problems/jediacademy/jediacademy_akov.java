import java.util.*;
import java.io.*;

public class jediacademy_akov {
	FastScanner in;
	PrintWriter out;

	int n, a, b;
	int[] color, degIn;
	ArrayList<Integer>[] g;
	
	int tryFrom(int cur, int[] argDegIn) {
		int[] degIn = Arrays.copyOf(argDegIn, argDegIn.length);
		int ans = 0;
		TreeSet<Integer>[] ready = new TreeSet[2];
		ready[0] = new TreeSet<Integer>();
		ready[1] = new TreeSet<Integer>();
		for (int i = 0; i < n; i++) {
			if (degIn[i] == 0) {
				ready[color[i]].add(i);
			}
		}
		int done = 0;
		while (done < n) {
			ans += a;
			while (ready[cur].size() > 0) {
				int x = ready[cur].first();
				ans += b;
				for (int y : g[x]) {
					degIn[y]--;
					if (degIn[y] == 0) {
						ready[color[y]].add(y);
					}
				}
				ready[cur].remove(x);
				done++;
			}
			cur = cur ^ 1;
		}
		return ans;
	}
	
	public void solve() throws IOException {
		n = in.nextInt();
		g = new ArrayList[n];
		color = new int[n];
		degIn = new int[n];
		for (int i = 0; i < n; i++) {
			g[i] = new ArrayList<Integer>();
		}
		for (int i = 0; i < n; i++) {
			color[i] = in.nextInt() - 1;
			degIn[i] = in.nextInt();
			for (int j = 0; j < degIn[i]; j++) {
				g[in.nextInt() - 1].add(i);
			}
		}
		a = in.nextInt();
		b = in.nextInt();
		int res = Math.min(tryFrom(0, degIn), tryFrom(1, degIn));
		out.println(res);
	}

	public void run() {
		try {
			in = new FastScanner(new File("jediacademy.in"));
			out = new PrintWriter(new File("jediacademy.out"));

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
		new jediacademy_akov().run();
	}
}