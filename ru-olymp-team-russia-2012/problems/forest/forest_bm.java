import java.io.*;
import java.util.*;

public class forest_bm {
	FastScanner in;
	PrintWriter out;

	class Point {
		int x, y;

		public Point(int x, int y) {
			super();
			this.x = x;
			this.y = y;
		}

	}

	int[] dx = { -1, 0, 0, 1, 0 };
	int[] dy = { 0, -1, 1, 0, 0 };
	int[][] a;

	int n, m;

	boolean inside(int x, int y) {
		if (x < 0 || x >= n)
			return false;
		if (y < 0 || y >= m)
			return false;
		return true;
	}

	boolean willGrow(int x, int y) {
		for (int i = 0; i < 4; i++) {
			int x1 = x + dx[i];
			int y1 = y + dy[i];
			if (inside(x1, y1))
				if (a[x1][y1] == a[x][y] + 1)
					return true;
		}
		return false;
	}

	void solve() {
		n = in.nextInt();
		m = in.nextInt();
		a = new int[n][m];
		for (int i = 0; i < n; i++)
			for (int j = 0; j < m; j++)
				a[i][j] = in.nextInt();
		ArrayList<Point> needCheck = new ArrayList<forest_bm.Point>();
		for (int i = 0; i < n; i++)
			for (int j = 0; j < m; j++)
				if (willGrow(i, j))
					needCheck.add(new Point(i, j));
		int year = 0;
		int[][] lastUpdate = new int[n][m];
		while (needCheck.size() != 0) {
			year++;
			for (int i = 0; i < needCheck.size(); i++) {
				a[needCheck.get(i).x][needCheck.get(i).y]++;
			}
			ArrayList<Point> willGrow = new ArrayList<forest_bm.Point>();
			for (int i = 0; i < needCheck.size(); i++) {
				for (int j = 0; j < 5; j++) {
					int x1 = needCheck.get(i).x + dx[j];
					int y1 = needCheck.get(i).y + dy[j];
					if (inside(x1, y1) && willGrow(x1, y1)
							&& lastUpdate[x1][y1] < year) {
						lastUpdate[x1][y1] = year;
						willGrow.add(new Point(x1, y1));
					}
				}
			}
			needCheck = willGrow;
		}
		out.println(year);
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++)
				out.print(a[i][j] + " ");
			out.println();
		}
	}

	void run() {
		try {
			in = new FastScanner(new File("forest.in"));
			out = new PrintWriter(new File("forest.out"));

			solve();

			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	void runIO() {

		in = new FastScanner(System.in);
		out = new PrintWriter(System.out);

		solve();

		out.close();
	}

	class FastScanner {
		BufferedReader br;
		StringTokenizer st;

		public FastScanner(File f) {
			try {
				br = new BufferedReader(new FileReader(f));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		public FastScanner(InputStream f) {
			br = new BufferedReader(new InputStreamReader(f));
		}

		String next() {
			while (st == null || !st.hasMoreTokens()) {
				String s = null;
				try {
					s = br.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (s == null)
					return null;
				st = new StringTokenizer(s);
			}
			return st.nextToken();
		}

		boolean hasMoreTokens() {
			while (st == null || !st.hasMoreTokens()) {
				String s = null;
				try {
					s = br.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (s == null)
					return false;
				st = new StringTokenizer(s);
			}
			return true;
		}

		int nextInt() {
			return Integer.parseInt(next());
		}

		long nextLong() {
			return Long.parseLong(next());
		}
	}

	public static void main(String[] args) {
		new forest_bm().run();
	}
}