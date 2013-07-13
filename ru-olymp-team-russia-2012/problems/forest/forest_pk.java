import java.io.*;
import java.util.*;

public class forest_pk {

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
		int n = nextInt();
		int m = nextInt();
		assert ((1 <= n) && (n <= 100));
		assert ((1 <= m) && (m <= 100));
		int[][] a = new int[n][m];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				a[i][j] = nextInt();
				assert ((1 <= a[i][j]) && (a[i][j] <= 100));
			}
		}

		HashSet<Integer> interesting = new HashSet<Integer>();
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				interesting.add(m * i + j);
			}
		}

		int ans = 0;
		while ((!interesting.isEmpty())) {
			ans++;
			HashSet<Integer> changes = new HashSet<Integer>();
			for (int z : interesting) {
				int x = z / m;
				int y = z % m;
				for (int dx = -1; dx < 2; dx++) {
					for (int dy = -1; dy < 2; dy++) {
						if (check(a, x, y, dx, dy, n, m)) {
							changes.add(x * m + y);
						}
					}
				}

			}
			interesting = new HashSet<Integer>();
			for (int z : changes) {
				int x = z / m;
				int y = z % m;
				a[x][y]++;
				for (int dx = -1; dx < 2; dx++) {
					for (int dy = -1; dy < 2; dy++) {
						add(interesting, x, y, dx, dy, n, m);
					}
				}
				
			}
		}
		out.println(ans - 1);
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				out.print(a[i][j]);
				if (j < m - 1)
					out.print(' ');
			}
			out.println();
		}
	}

	private boolean check(int[][] a, int x, int y, int dx, int dy, int n, int m) {
		if (!correct(x, y, dx, dy, n, m)) {
			return false;
		}
		return (a[x + dx][y + dy] == a[x][y] + 1);
	}

	private boolean correct(int x, int y, int dx, int dy, int n, int m) {
		if (Math.max(Math.abs(dx), Math.abs(dy)) > 1)
			return false;
		if (Math.abs(dx) + Math.abs(dy) > 1)
			return false;
		if (x + dx < 0)
			return false;
		if (x + dx >= n)
			return false;
		if (y + dy < 0)
			return false;
		if (y + dy >= m)
			return false;
		return true;
	}

	private void add(HashSet<Integer> interesting, int x, int y, int dx,
			int dy, int n, int m) {
		if (!correct(x, y, dx, dy, n, m))
			return;
		interesting.add((x + dx) * m + y + dy);
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("forest.in"));
			out = new PrintWriter("forest.out");

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new forest_pk().run();
	}
}
