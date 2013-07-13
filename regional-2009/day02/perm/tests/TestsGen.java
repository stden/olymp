import java.io.*;
import java.util.*;

public class TestsGen {
	static int testcount = 0;

	static Random random = new Random(36498732);

	static final int MAXN = (int) 1e9;

	static void write() throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);

		out.close();
	}

	static void writeMaxK(int n) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		int k = MAXN / n;
		int[] a = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = (i + 1) * k;
		}
		for (int i = 0; i < n; i++) {
			int j = random.nextInt(n - i) + i;
			int t = a[i];
			a[i] = a[j];
			a[j] = t;
		}
		long m = Math.min(count(a, k), MAXN);
		out.println(n + " " + m + " " + k);
		for (int i = 0; i < n; i++) {
			if (i != 0) {
				out.print(" ");
			}
			out.print(a[i]);
		}
		out.println();
		out.close();
	}

	static void writeRand(int n, boolean fl) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		int[] a = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = random.nextInt(MAXN) + 1;
		}
		int k = random.nextInt(MAXN) + 1;
		int m = random.nextInt(MAXN) + 1;
		if (fl) {
			while (count(a, k) == 0) {
				k = random.nextInt(k) + 1;
			}
			m = random.nextInt((int) Math.min(MAXN, count(a, k))) + 1;
		}
		out.println(n + " " + m + " " + k);
		for (int i = 0; i < n; i++) {
			if (i != 0) {
				out.print(" ");
			}
			out.print(a[i]);
		}
		out.println();
		out.close();
	}
	
	static ArrayList<Integer> getDivisors(int a) {
		ArrayList<Integer> ret = new ArrayList<Integer>();
		for (int i = 1; i * i <= a; i++) {
			if (a % i == 0) {
				ret.add(a / i);
				ret.add(i);
			}
		}
		return ret;
	}
	
	static int[] genGood(int n) {
		int[] ret = new int[n];
		ret[0] = random.nextInt(MAXN) + 1;
		for (int i = 1; i < n; i++) {
			ArrayList<Integer> al = getDivisors(ret[i - 1]);
			boolean fl;
			do {
				fl = false;
				int t = al.get(random.nextInt(al.size()));
				ret[i] = (random.nextInt(MAXN / t) + 1) * t;
				for (int j = 0; j < i; j++) {
					if (ret[i] == ret[j]) {
						fl = true;
					}
				}
			} while (fl);
		}
		return ret;
	}

	static void writeLast(int n) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		while (true) {
			int[] a = genGood(n);
			int l = 0;
			int r = MAXN;
			int k = random.nextInt(MAXN) + 1;
			while (r - l > 1) {
				long ff = count(a, k);
				if (ff == 0) {
					r = k;
				} else if (ff > MAXN) {
					l = k;
				} else {
					break;
				}
				k = (r + l) / 2;
			}
			long m = count(a, k);
			if (m > MAXN) continue;
			out.println(n + " " + m + " " + k);
			for (int i = 0; i < n; i++) {
				if (i != 0) {
					out.print(" ");
				}
				out.print(a[i]);
			}
			out.println();
			break;
		}
		out.close();
	}

	static void writeGood(int n) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		while (true) {
			int[] a = genGood(n);
			int l = 1;
			int r = MAXN;
			int k = random.nextInt(MAXN) + 1;
			while (r - l > 1) {
				long ff = count(a, k);
				if (ff == 0) {
					r = k;
				} else if (ff > MAXN) {
					l = k;
				} else {
					break;
				}
				k = (r + l) / 2;
			}
			long m = count(a, k);
			if (m > MAXN || m == 0) continue;
			m = random.nextInt((int) m) + 1;
			out.println(n + " " + m + " " + k);
			for (int i = 0; i < n; i++) {
				if (i != 0) {
					out.print(" ");
				}
				out.print(a[i]);
			}
			out.println();
			break;
		}
		out.close();
	}

	public static void main(String[] args) throws IOException {
		while (new File(String.format("%02d.t", testcount + 1)).exists()) {
			testcount++;
		}
		//4
		for (int i = 0; i < 3; i++) {
			writeRand(9, false);
			writeRand(3, false);
			writeRand(16, false);
			testcount--;
			writeRand(9, true);
			writeRand(3, true);
			writeRand(16, true);
		}
		//22
		writeMaxK(9);
		writeMaxK(16);
		writeMaxK(2);
		writeRand(1, false);
		writeRand(1, true);
		writeLast(4);
		writeLast(9);
		writeLast(16);
		//30
		for (int i = 0; i < 3; i++) {
			writeGood(10);
		}
		//33
		for (int i = 0; i < 5; i++) {
			writeRand(15, false);
			testcount--;
			writeLast(15);
			writeGood(15);
		}
		//48
		for (int i = 0; i < 2; i++) {
			writeGood(16);
		}
	}

	static long count(int[] a, int k) {
		Arrays.sort(a);
		int n = a.length;
		int[][] gcd = new int[n][n];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				gcd[i][j] = gcd(a[i], a[j]);
			}
		}
		int l = (1 << n);
		long[][] c = new long[l][n];
		for (int i = 0; i < n; i++) {
			c[1 << i][i] = 1;
		}
		for (int i = 0; i < l; i++) {
			for (int j = 0; j < n; j++) {
				if ((i & (1 << j)) != 0) {
					for (int jj = 0; jj < n; jj++) {
						if (jj != j && ((i & (1 << jj)) != 0)) {
							if (gcd[j][jj] >= k) {
								c[i][j] += c[i ^ (1 << j)][jj];
							}
						}
					}
				}
			}
		}
		long ret = 0;
		for (int i = 0; i < n; i++) {
			ret += c[l - 1][i];
		}
		return ret;
	}

	private static int gcd(int i, int j) {
		while (i != 0) {
			int t = i;
			i = j % i;
			j = t;
		}
		return j;
	}
}
