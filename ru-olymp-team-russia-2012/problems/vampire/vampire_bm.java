import java.io.*;
import java.util.*;

public class vampire_bm {
	FastScanner in;
	PrintWriter out;

	boolean isVampire(int x, int y) {
		int m = x * y;
		String res = Integer.toString(m);
		String x1 = Integer.toString(x);
		String x2 = Integer.toString(y);
		if (x1.length() != x2.length())
			return false;
		if (x1.length() + x2.length() != res.length())
			return false;
		int[] c = new int[10];
		for (int i = 0; i < res.length(); i++)
			c[res.charAt(i) - '0']++;

		for (int i = 0; i < x1.length(); i++)
			c[x1.charAt(i) - '0']--;

		for (int i = 0; i < x2.length(); i++)
			c[x2.charAt(i) - '0']--;

		for (int i = 0; i < 10; i++)
			if (c[i] != 0)
				return false;

		return true;
	}

	class Answer {
		int x, y;

		public Answer(int x, int y) {
			super();
			this.x = x;
			this.y = y;
		}

	}

	void solve() {
		int k = in.nextInt();
		int n = in.nextInt();
		TreeSet<Integer> ans = new TreeSet<Integer>();
		ArrayList<Answer> a = new ArrayList<Answer>();
		if (n == 4) {
			for (int i = 10; i < 100; i++) {
				for (int j = 10; j < 100; j++)
					if (isVampire(i, j) && !ans.contains(i * j)) {
						a.add(new Answer(i, j));
						ans.add(i * j);
					}
			}
		} else {
			for (int i = 100; i < 900; i++) {
				for (int j = 100; j < 700; j++)
					if (!ans.contains(i * j) && isVampire(i, j)) {
						a.add(new Answer(i, j));
						ans.add(i * j);
					}
			}
		}
		String add = "";
		for (int i = 3; i < n / 2; i++)
			add = add + "0";
		for (int i = 0; i < k; i++) {
			out.println(a.get(i).x * a.get(i).y + add + add + "=" + a.get(i).x
					+ add + "x" + a.get(i).y + add);
		}

	}

	void run() {
		try {
			in = new FastScanner(new File("vampire.in"));
			out = new PrintWriter(new File("vampire.out"));

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
		new vampire_bm().run();
	}
}