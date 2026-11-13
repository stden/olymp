import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;
import java.util.StringTokenizer;

public class tiv_vd {
	BufferedReader in;
	StringTokenizer str;
	PrintWriter out;
	String SK;

	String next() throws IOException {
		while ((str == null) || (!str.hasMoreTokens())) {
			SK = in.readLine();
			if (SK == null)
				return null;
			str = new StringTokenizer(SK);
		}
		return str.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(next());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(next());
	}

	long nextLong() throws IOException {
		return Long.parseLong(next());
	}

	void solve() throws IOException {
		int n = nextInt();
		String[] s = new String[n];
		for (int i = 0; i < n; i++) {
			s[i] = next();
		}
		int[][] a = new int[10][10];
		for (int i = 0; i < n - 1; i++) {
			if (s[i].equals(s[i + 1])) {
				out.println("NO");
				return;
			}
			if (s[i].length() == s[i + 1].length()) {
				int t = 0;
				while (s[i].charAt(t) == s[i + 1].charAt(t)) {
					t++;
				}
				a[s[i].charAt(t) - 'a'][s[i + 1].charAt(t) - 'a']++;
			}
			if (s[i].length() > s[i + 1].length()) {
				out.println("NO");
				return;
			}
		}
		ArrayList<Integer> arr = new ArrayList<Integer>();
		boolean[] was = new boolean[10];
		while (true) {
			boolean fl = false;
			for (int i = 0; i < 10; i++) {
				int sum = 0;
				if (was[i]) {
					continue;
				}
				for (int j = 0; j < 10; j++) {
					sum += a[j][i];
				}
				if (sum == 0) {
					fl = true;
					for (int j = 0; j < n; j++) {
						if (s[j].charAt(0) - 'a' == i && s[j].length() > 1
								&& arr.size() == 0) {
							fl = false;
						}
					}
					if (fl) {
						was[i] = true;
						arr.add(i);
						for (int j = 0; j < 10; j++) {
							a[i][j] = 0;
						}
						break;
					}
				}
				if (fl) {
					break;
				}
			}
			if (!fl) {
				break;
			}
		}
		if (arr.size() < 10) {
			out.println("NO");
			return;
		}
		int[] res = new int[10];
		for (int j = 0; j < 10; j++) {
			res[arr.get(j)] = j;
		}
		out.println("YES");
		for (int i = 0; i < 10; i++) {
			out.print(res[i] + " ");
		}
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("tiv.in"));
		out = new PrintWriter("tiv.out");
		solve();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new tiv_vd().run();
	}

}