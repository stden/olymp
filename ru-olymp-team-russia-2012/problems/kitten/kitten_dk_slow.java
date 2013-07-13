import java.util.*;
import java.io.*;

public class kitten_dk_slow {
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

	int n, m, ai, aj, bi, bj, ci, cj;
	int[][] a, c;

	final int mod = 1000 * 1000 * 1000 + 7;
	void init() {
		c = new int[2001][2001];
		for (int i = 0; i < 2001; i++) {
			c[i][0] = 1;
		}
		for (int i = 1; i < 2001; i++) {
			for (int j = 1; j < 2001; j++) {
				c[i][j] = (c[i-1][j] + c[i-1][j-1]) % mod;
			}
		}
	}
	
	int ans, len;
	int[] dx = {0, 1, 0, -1};
	int[] dy = {1, 0, -1, 0};
	boolean[][] f;
	public void dfs(int x, int y, int nowlen) {
		if (nowlen == len) {
			if (x == ci && y == cj && f[bi][bj]) {
				for (int i = 1; i <= n; i++) {
					for (int j = 1; j <= n; j++) {
						if (f[i][j])
						System.err.print(i + " " + j + ", ");
					}
				}
				System.err.println();
				ans++;
				f[x][y] = false;
				return;
			}
		}
		if (x == ci && y == cj) {
			f[x][y] = false;
			return;
		}
		for (int v = 0; v < 4; v++) {
			int x2 = x + dx[v];
			int y2 = y + dy[v];
			try {
			if (x2 > 0 && x2 <= n && y2 > 0 && y2 <= m && !f[x2][y2]) {
				f[x2][y2] = true;
				dfs(x2, y2, nowlen+1);
			} }
			catch (Exception e) {
				System.err.println(x2 + " " + y2 + " " + n + " " + m);
			}
		}
		f[x][y] = false;
	}

	void solve() throws IOException {
		init();
		ans = 0;
		n = nextInt();
		m = nextInt();
		a = new int[n + 2][m + 2];
		ai = nextInt();
		aj = nextInt();
		bi = nextInt();
		bj = nextInt();
		ci = nextInt();
		cj = nextInt();
		f = new boolean[n + 2][m + 2];
		
		len = Math.abs(bi - ai) + Math.abs(bj - aj) + Math.abs(ci - bi) + Math.abs(cj - bj);
		f[ai][aj] = true;
		if (len > 15) return;
		dfs(ai, aj, 0);
	/*	for (int i = 1; i <= n; i++) {
			for (int j = m; j >= 1; j--) {
				ci = i;
				cj = j;
				ans = 0;
				len = Math.abs(bi - ai) + Math.abs(bj - aj) + Math.abs(ci - bi) + Math.abs(cj - bj); 
				for (int i1 = 0; i1 <= n; i1++) {
					for (int j1 = 0; j1 <= m; j1++) {
						f[i1][j1] = false;
					}
				}
				f[ai][aj] = true;
				
				dfs(ai, aj, 0);
				out.print(ans + " ");
			}
			out.println();
		} */
		out.println(ans);
	}

	void run() throws IOException {
		br = new BufferedReader(new FileReader("kitten.in"));
		out = new PrintWriter("kitten.out");
		// br = new BufferedReader(new InputStreamReader(System.in));
		// out = new PrintWriter(System.out);
		solve();
		br.close();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		// Localea.setDefault(Locale.US);
		new kitten_dk_slow().run();
	}
}