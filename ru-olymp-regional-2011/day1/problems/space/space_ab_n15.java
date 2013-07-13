import java.io.*;
import java.util.*;
import java.math.*;

//Assert n <= 15

public class space_ab_n15 implements Runnable {

	final int MAXN = 1000;
	final int MAXK = 5;
	final int MAXF = 50;
	final int m = 50;
	
	
	private void solve() throws IOException {
		int n = in.nextInt();
		int k = in.nextInt();
		assert 1 <= n && n <= 15;
		assert 1 <= k && k <= MAXK;
		
		int[] l = new int[m];
		int[] r = new int[m];
		Arrays.fill(l, m);
		Arrays.fill(r, -1);
		boolean[] u = new boolean[m];
		
		int maxy = 0;
		for (int i = 0; i < n; ++i) {
			int x = in.nextInt() - 1;
			int y = in.nextInt() - 1;
			assert 0 <= x && x < m;
			assert 0 <= y && y < m;
			
			u[y] = true;
			l[y] = Math.min(x, l[y]);
			r[y] = Math.max(x, r[y]);
			maxy = Math.max(y, maxy);
		}
		
		int[][] tm = new int[m - k + 1][m - k + 1];
		for (int i = 0; i < tm.length; ++i) {
			for (int j = 0; j < tm[i].length; ++j) {
				tm[i][j] = (1 << (2 * k)) - 1;
				for (int d = 0; d < k; ++d) {
					int y = j + d;
					if (!u[y] || i <= l[y] && l[y] < i + k) {
						tm[i][j] ^= 1 << (2 * d);
					}
					if (!u[y] || i <= r[y] && r[y] < i + k) {
						tm[i][j] ^= 1 << (2 * d + 1);
					}
				}
			}
		}
		
		int[][][] D = new int[m - k + 1][m - k + 1][1 << (2 * k)];
		for (int i = 0; i < D.length; ++i) {
			for (int j = 0; j < D[i].length; ++j) {
				Arrays.fill(D[i][j], INF);
			}
		}
		D[0][0][tm[0][0]] = 0;
		Queue<Integer> qx = new ArrayDeque<Integer>();
		Queue<Integer> qy = new ArrayDeque<Integer>();
		Queue<Integer> qm = new ArrayDeque<Integer>();
		qx.add(0);
		qy.add(0);
		qm.add(tm[0][0]);
		
		int shm = 3 << (2 * k - 2);
		
		while (!qx.isEmpty()) {
			int x = qx.poll();
			int y = qy.poll();
			int mask = qm.poll();
//			System.out.println(String.format("%2d %2d %6s", x, y, Integer.toBinaryString(mask)));
			if (y + k > maxy && mask == 0) {
				out.println(D[x][y][mask]);
				return;
			}
			for (int t = 0; t < 3; ++t) {
				int tx = x + dx[t];
				int ty = y + dy[t];
				if (tx < 0 || tx + k > m || ty + k > m) continue;
				int tmask = mask & tm[tx][ty];
				if (ty > y) {
					if ((mask & 3) != 0) continue;
					tmask = ((mask >> 2) | shm) & tm[tx][ty];
				}
				
				if (D[tx][ty][tmask] > D[x][y][mask] + 1) {
					D[tx][ty][tmask] = D[x][y][mask] + 1;
					qx.add(tx);
					qy.add(ty);
					qm.add(tmask);
				}
			}
		}
	}
	
	final int INF = Integer.MAX_VALUE / 2;

	final int[] dx = {-1, 0, 1};
	final int[] dy = {0, 1, 0};
	
	final String FILE_NAME = "space";

	SimpleScanner in;
	PrintWriter out;

	@Override
	public void run() {
		try {
			in = new SimpleScanner(new FileReader(FILE_NAME + ".in"));
			out = new PrintWriter(FILE_NAME + ".out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	public static void main(String[] args) {
		new Thread(new space_ab_n15()).start();
	}

	class SimpleScanner extends BufferedReader {

		private StringTokenizer st;
		private boolean eof;

		public SimpleScanner(Reader a) {
			super(a);
		}

		String next() {
			while (st == null || !st.hasMoreElements()) {
				try {
					st = new StringTokenizer(readLine());
				} catch (Exception e) {
					eof = true;
					return "";
				}
			}
			return st.nextToken();
		}

		boolean seekEof() {
			String s = next();
			if ("".equals(s) && eof)
				return true;
			st = new StringTokenizer(s + " " + st.toString());
			return false;
		}

		private String cnv(String s) {
			if (s.length() == 0)
				return "0";
			return s;
		}

		int nextInt() {
			return Integer.parseInt(cnv(next()));
		}

		double nextDouble() {
			return Double.parseDouble(cnv(next()));
		}

		long nextLong() {
			return Long.parseLong(cnv(next()));
		}
	}
}