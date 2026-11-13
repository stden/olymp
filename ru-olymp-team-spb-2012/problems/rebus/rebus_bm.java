import java.io.*;
import java.util.*;

public class rebus_bm {
	FastScanner in;
	PrintWriter out;

	String sol(String s) {
		int needDelete = 0;
		ArrayList<Character> ans = new ArrayList<Character>();
		boolean wasWord = false;
		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) != ' ') {
				if (s.charAt(i) == '\'')
					if (wasWord) {
						ans.remove(ans.size() - 1); 
					} else {
						needDelete++;
					} else {
						wasWord = true;
						if (needDelete > 0) {
							needDelete--; 
						} else {
							ans.add(s.charAt(i));
						}
					}
			} else {
				wasWord = false;
			}
		}
		char[] answer = new char[ans.size()];
		for (int i = 0; i < ans.size(); i++)
			answer[i] = ans.get(i);
		return new String(answer);
	}
	
	void solve() {
		out.println(sol(in.nextLine()));
	}

	void run() {
		try {
			in = new FastScanner(new File("rebus.in"));
			out = new PrintWriter(new File("rebus.out"));

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
		
		String nextLine() {
			try {
				return br.readLine();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	}

	public static void main(String[] args) {
		new rebus_bm().run();
	}
}