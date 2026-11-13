import java.io.*;
import java.util.*;

public class billboard_bm {
	FastScanner in;
	PrintWriter out;

	int type(char c) {
		return c == '.' ? 1 : 2;
	}
	
	void solve() {
		int k = in.nextInt();
		int n = in.nextInt();
		int m = in.nextInt();
		int[][] a = new int[n][m];
		int cnt = 1;
		for (int tt = 0; tt < k; tt++) {
			String[] s = new String[n];
			for (int i = 0; i < n; i++)
				s[i] = in.next();
			int[] types = new int[cnt];
			int[] nextType = new int[cnt];
			for (int i = 0; i < n; i++)
				for (int j = 0; j < m; j++)
					types[a[i][j]] |= type(s[i].charAt(j));
			for (int i = 0; i < n; i++)
				for (int j = 0; j < m; j++)
					if (types[a[i][j]] > 2) {
						if (nextType[a[i][j]] == 0)
							nextType[a[i][j]] = cnt++;
						if (type(s[i].charAt(j)) == 2)
							a[i][j] = nextType[a[i][j]]; 
					}
		}
		out.println(cnt);
	}

	void run() {
		try {
			in = new FastScanner(new File("billboard.in"));
			out = new PrintWriter(new File("billboard.out"));

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
		new billboard_bm().run();
	}
}