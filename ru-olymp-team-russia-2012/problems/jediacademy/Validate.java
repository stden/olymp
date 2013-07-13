import java.io.*;
import java.util.*;

public class Validate {
	ArrayList<Integer>[] e;
	boolean[] u;
	int[] ord;
	int cnt;

	void dfs(int x) {
		u[x] = true;
		for (int y : e[x]) {
			if (!u[y]) {
				dfs(y);
			}
		}
		ord[x] = cnt++;
	}

	public void run() {
		StrictScanner inf = new StrictScanner(System.in);
		int n = inf.nextInt();
		inf.nextLine();
		ensureLimits(n, 1, 100000, "n");

		e = new ArrayList[n];
		for (int i = 0; i < n; i++) {
			e[i] = new ArrayList<Integer>();
		}

		int sumk = 0;
		for (int i = 0; i < n; i++) {
			int a = inf.nextInt();
			ensure(a == 1 || a == 2, "type of " + (i + 1) + " must be 1 or 2");
			int k = inf.nextInt();
			ensureLimits(k, 0, n - 1, "k[" + (i + 1) + "]");
			sumk += k;
			for (int j = 0; j < k; j++) {
				int b = inf.nextInt();
				ensureLimits(b, 1, n, "dependency " + (j + 1) + " of " + (i + 1));
				e[i].add(b - 1);
			}
			inf.nextLine();
		}

		u = new boolean[n];
		ord = new int[n];
		cnt = 0;
		for (int i = 0; i < n; i++) {
			if (!u[i]) {
				dfs(i);
			}
		}
		for (int i = 0; i < n; i++) {
			for (int j : e[i]) {
				ensure(ord[j] < ord[i], "not acyclic");
			}
		}

		int a = inf.nextInt();
		int b = inf.nextInt();
		inf.nextLine();
		ensureLimits(a, 1, 10000, "a");
		ensureLimits(b, 1, 10000, "b");
		inf.close();
	}

	public static void main(String[] args) {
		new Validate().run();
	}

	public class StrictScanner {
		private final BufferedReader in;
		private String line = "";
		private int pos;
		private int lineNo;

		public StrictScanner(InputStream source) {
			in = new BufferedReader(new InputStreamReader(source));
			nextLine();
		}

		public void close() {
			ensure(line == null, "Extra data at the end of file");
			try {
				in.close();
			} catch (IOException e) {
				throw new AssertionError("Failed to close with " + e);
			}
		}

		public void nextLine() {
			ensure(line != null, "EOF");
			ensure(pos == line.length(), "Extra characters on line " + lineNo);
			try {
				line = in.readLine();
			} catch (IOException e) {
				throw new AssertionError("Failed to read line with " + e);
			}
			pos = 0;
			lineNo++;
		}

		public String next() {
			ensure(line != null, "EOF");
			ensure(line.length() > 0, "Empty line " + lineNo);
			if (pos == 0)
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " starts with whitespace");
			else {
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(pos) == ' ', "Wrong whitespace on line "
						+ lineNo);
				pos++;
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " has double whitespace");
			}
			StringBuilder sb = new StringBuilder();
			while (pos < line.length() && line.charAt(pos) > ' ')
				sb.append(line.charAt(pos++));
			return sb.toString();
		}

		public int nextInt() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Integer.parseInt(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}

		public long nextLong() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Long.parseLong(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}


		public double nextDouble() {
			String s = next();
			ensure(s.length() == 1 || s.startsWith("0.") || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Double.parseDouble(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}
	}

	void ensure(boolean b, String message) {
		if (!b) {
			throw new AssertionError(message);
		}
	}
	void ensureLimits(long n, long from, long to, String name) {
		ensure(from <= n && n <= to, name + " must be from " + from + " to "
				+ to);
	}


	void ensureLimits(int n, int from, int to, String name) {
		ensure(from <= n && n <= to, name + " must be from " + from + " to "
				+ to);
	}

}