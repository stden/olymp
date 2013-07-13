import java.io.*;
import java.util.*;

public class processing_pk_tl2 {

	BufferedReader br;
	PrintWriter out;
	StringTokenizer st;

	public String nextToken() throws IOException {
		while ((st == null) || (!st.hasMoreTokens()))
			st = new StringTokenizer(br.readLine());
		return st.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public void solve() throws IOException {
		String s = nextToken();
		String t = nextToken();
		ArrayList<Integer> res = null;
		if (s.length() < 20000) {
			res = gen(s, t);
		} else {
			long tm = System.currentTimeMillis();
			while (res == null && System.currentTimeMillis() - tm < 1500) {
				res = gen1(s, t);
			}
		}
		if (res == null) {
			out.println("No");
		} else {
			out.println("Yes");
			for (int x : res) {
				out.print(x + " ");
			}
			out.println();
		}
	}

	Random rnd = new Random();

	private ArrayList<Integer> gen1(String s, String t) {
		if (s.length() == 1) {
			if (s.equals(t)) {
				return new ArrayList<Integer>();
			} else {
				return null;
			}
		}
		int[] slc = new int[26];
		int[] src = new int[26];
		int[] tlc = new int[26];
		int[] trc = new int[26];
		for (int i = 0; i < s.length() / 2; i++) {
			slc[s.charAt(i) - 'a']++;
			tlc[t.charAt(i) - 'a']++;
		}
		for (int i = 0; i < s.length() / 2; i++) {
			src[s.charAt(i + s.length() / 2) - 'a']++;
			trc[t.charAt(i + s.length() / 2) - 'a']++;
		}
		if (rnd.nextBoolean()) {
			if ((Arrays.equals(slc, trc)) && (Arrays.equals(src, tlc))) {
				ArrayList<Integer> r1 = gen1(s.substring(0, s.length() / 2),
						t.substring(s.length() / 2));
				ArrayList<Integer> r2 = gen1(s.substring(s.length() / 2),
						t.substring(0, s.length() / 2));
				if ((r1 != null) && (r2 != null)) {
					r1.addAll(r2);
					r1.add(1);
					return r1;
				}
			} else

			if ((Arrays.equals(slc, tlc)) && (Arrays.equals(src, trc))) {
				ArrayList<Integer> r1 = gen1(s.substring(0, s.length() / 2),
						t.substring(0, s.length() / 2));
				ArrayList<Integer> r2 = gen1(s.substring(s.length() / 2),
						t.substring(s.length() / 2));
				if ((r1 != null) && (r2 != null)) {
					r1.addAll(r2);
					r1.add(0);
					return r1;
				}
			}
		} else {
			if ((Arrays.equals(slc, tlc)) && (Arrays.equals(src, trc))) {
				ArrayList<Integer> r1 = gen1(s.substring(0, s.length() / 2),
						t.substring(0, s.length() / 2));
				ArrayList<Integer> r2 = gen1(s.substring(s.length() / 2),
						t.substring(s.length() / 2));
				if ((r1 != null) && (r2 != null)) {
					r1.addAll(r2);
					r1.add(0);
					return r1;
				}
			} else if ((Arrays.equals(slc, trc)) && (Arrays.equals(src, tlc))) {
				ArrayList<Integer> r1 = gen1(s.substring(0, s.length() / 2),
						t.substring(s.length() / 2));
				ArrayList<Integer> r2 = gen1(s.substring(s.length() / 2),
						t.substring(0, s.length() / 2));
				if ((r1 != null) && (r2 != null)) {
					r1.addAll(r2);
					r1.add(1);
					return r1;
				}
			}
		}

		return null;
	}

	private ArrayList<Integer> gen(String s, String t) {
		if (s.length() == 1) {
			if (s.equals(t)) {
				return new ArrayList<Integer>();
			} else {
				return null;
			}
		}
		int[] slc = new int[26];
		int[] src = new int[26];
		int[] tlc = new int[26];
		int[] trc = new int[26];
		for (int i = 0; i < s.length() / 2; i++) {
			slc[s.charAt(i) - 'a']++;
			tlc[t.charAt(i) - 'a']++;
		}
		for (int i = 0; i < s.length() / 2; i++) {
			src[s.charAt(i + s.length() / 2) - 'a']++;
			trc[t.charAt(i + s.length() / 2) - 'a']++;
		}
		if ((Arrays.equals(slc, trc)) && (Arrays.equals(src, tlc))) {
			ArrayList<Integer> r1 = gen(s.substring(0, s.length() / 2),
					t.substring(s.length() / 2));
			ArrayList<Integer> r2 = gen(s.substring(s.length() / 2),
					t.substring(0, s.length() / 2));
			if ((r1 != null) && (r2 != null)) {
				r1.addAll(r2);
				r1.add(1);
				return r1;
			}
		}

		if ((Arrays.equals(slc, tlc)) && (Arrays.equals(src, trc))) {
			ArrayList<Integer> r1 = gen(s.substring(0, s.length() / 2),
					t.substring(0, s.length() / 2));
			ArrayList<Integer> r2 = gen(s.substring(s.length() / 2),
					t.substring(s.length() / 2));
			if ((r1 != null) && (r2 != null)) {
				r1.addAll(r2);
				r1.add(0);
				return r1;
			}
		}

		return null;
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("processing.in"));
			out = new PrintWriter("processing.out");

			int n = nextInt();
			for (int i = 0; i < n; i++) {
				solve();
			}
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new processing_pk_tl2().run();
	}
}