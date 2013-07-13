import java.io.*;
import java.util.*;
import java.math.*;

public class format_aa {
	public static void main(String[] args) {
		new format_aa().run();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;

	private void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader("format.in"));
			out = new PrintWriter("format.out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (Exception e) {
				eof = true;
				return "0";
			}
		}
		return st.nextToken();
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	void myAssert(boolean u, String message) {
		if (!u) {
			throw new Error("Assertion failed!!! " + message);
		}
	}

	int inBounds(int x, int l, int r, String name) {
		myAssert(l <= x && x <= r, name + " = " + x + " is not in [" + l + ".."
				+ r + "]");
		return x;
	}

	private void solve() throws IOException {
		int w = inBounds(nextInt(), 5, 100, "w");
		int b = inBounds(nextInt(), 1, Math.min(w - 1, 8), "b");
		String word = "";
		for (int i = 0; i < 10; i++) {
			word += i;
		}
		for (char c = 'a'; c <= 'z'; c++) {
			word += c;
		}
		for (char c = 'A'; c <= 'Z'; c++) {
			word += c;
		}
		ArrayList<String> al = new ArrayList<String>();
		StringBuilder sb = new StringBuilder();
		while (true) {
			String str = br.readLine();
			if (str == null) {
				break;
			}
			if (str.trim().equals("")) {
				al.add(sb.toString());
				sb = new StringBuilder();
				continue;
			}
			StringTokenizer st = new StringTokenizer(str);
			while (st.hasMoreTokens()) {
				String s = st.nextToken();
				if (sb.length() > 0) {
					sb.append(" ");
				}
				sb.append(s);
			}
		}
		al.add(sb.toString());
		for (String str : al) {
			if (str.length() == 0) {
				continue;
			}
			char[] s = str.toCharArray();
			for (int i = 0; i < b; i++) {
				out.print(" ");
			}
			int h = b;
			boolean first = true;
			for (int i = 0; i < s.length;) {
				int j = i;
				while (j < s.length && word.indexOf(s[j]) >= 0) {
					j++;
				}
				while (j < s.length && word.indexOf(s[j]) < 0) {
					j++;
				}
				StringBuilder next = new StringBuilder();
				while (i < j) {
					if (s[i] != ' ') {
						next.append(s[i]);
					}
					i++;
				}
				if (h + next.length() + (first ? 0 : 1) <= w) {
					h += next.length();
				} else {
					out.println();
					first = true;
					h = next.length();
				}
				if (!first) {
					h++;
					out.print(" ");
				}
				out.print(next);
				first = false;
			}
			out.println();
		}
	}

}
