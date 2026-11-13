import static java.lang.Math.*;
import java.io.*;
import java.math.*;
import java.util.*;

public class vampire_ni_java {
	MyScanner in;
	PrintWriter out;

	final int MAXFANG = 1000;

	class VampireNumber {
		int fang1;
		int fang2;

		public VampireNumber(int fang1, int fang2) {
			this.fang1 = fang1;
			this.fang2 = fang2;
		}
	}

	void solve() throws Exception {
		int k = in.nextInt();
		int n = in.nextInt();

		ArrayList<VampireNumber> numbers = new ArrayList<vampire_ni_java.VampireNumber>();
		HashSet<Integer> used = new HashSet<Integer>();
		for (int i = 1; numbers.size() < k && i <= MAXFANG; i++) {
			for (int j = i + 1; numbers.size() < k && j <= MAXFANG; j++) {
				if (!isVampire(String.valueOf(i * j), String.valueOf(i),
						String.valueOf(j), n))
					continue;
				int ii = i;
				int jj = j;
				while (ii % 10 == 0 && jj % 10 == 0) {
					ii /= 10;
					jj /= 10;
				}
				if (!used.contains(ii * jj)) {
					used.add(ii * jj);
					numbers.add(new VampireNumber(ii, jj));
				}
			}
		}

		for (int i = 0; i < k; i++) {
			VampireNumber cur = numbers.get(i);
			String vampire = String.valueOf(cur.fang1 * cur.fang2);
			String fang1 = String.valueOf(cur.fang1);
			String fang2 = String.valueOf(cur.fang2);
			assert ((n - vampire.length()) % 2 == 0);
			while (vampire.length() < n) {
				vampire += "00";
				fang1 += "0";
				fang2 += "0";
			}
			out.println(vampire + "=" + fang1 + "x" + fang2);
		}
	}

	private boolean isVampire(String vampire, String fang1, String fang2, int n) {

		if (vampire.length() > n || vampire.length() % 2 != 0) {
			return false;
		}
		if (fang1.length() != vampire.length() / 2) {
			return false;
		}
		if (fang2.length() != vampire.length() / 2) {
			return false;
		}

		int cnt1[] = digitize(vampire.toString());
		int cnt2[] = digitize(fang1.toString());
		int cnt3[] = digitize(fang2.toString());
		for (int i = 0; i < 10; i++) {
			if (cnt1[i] != cnt2[i] + cnt3[i]) {
				return false;
			}
		}
		return true;
	}

	private int[] digitize(String string) {
		int result[] = new int[10];
		for (int i = 0; i < string.length(); i++) {
			result[string.charAt(i) - '0']++;
		}
		return result;
	}

	final String TASK = "vampire";

	public void run() {
		try {
			in = new MyScanner(TASK + ".in");
			out = new PrintWriter(TASK + ".out");
			solve();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(42);
		}
	}

	public static void main(String[] args) {
		new vampire_ni_java().run();
	}

	class MyScanner {
		BufferedReader br;
		StringTokenizer st;

		MyScanner(String file) {
			try {
				br = new BufferedReader(new FileReader(new File(file)));
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.exit(42);
			}
		}

		MyScanner() {
			try {
				br = new BufferedReader(new InputStreamReader(System.in));
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(42);
			}
		}

		String nextToken() throws Exception {
			while (st == null || (!st.hasMoreTokens())) {
				st = new StringTokenizer(br.readLine());
			}
			return st.nextToken();
		}

		int nextInt() throws Exception {
			return Integer.parseInt(nextToken());
		}

		double nextDouble() throws Exception {
			return Double.parseDouble(nextToken());
		}

		long nextLong() throws Exception {
			return Long.parseLong(nextToken());
		}

		BigInteger nextBigInteger(int radix) throws Exception {
			return new BigInteger(nextToken(), radix);
		}
	}

}
