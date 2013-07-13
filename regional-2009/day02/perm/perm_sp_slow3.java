// Задача "Перестановки"
// Региональный этап Всероссийской олимпиады школьников по информатике
// Автор задачи: Сергей Мельников, melnikov@rain.ifmo.ru
// Автор решения: Сергей Поромов, poromov@rain.ifmo.ru
// 50 баллов

import java.io.*;
import java.util.*;

public class perm_sp_slow3 implements Runnable {

	public static void main(String[] args) {
		new Thread(new perm_sp_slow3()).run();
	}

	public void run() {
		try {
			Locale.setDefault(Locale.US);
			br = new BufferedReader(new FileReader(FILENAME + ".in"));
			out = new PrintWriter(FILENAME + ".out");
			solve();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	BufferedReader br;

	PrintWriter out;

	StringTokenizer st;

	String nextToken() throws IOException {
		while (st == null || !st.hasMoreTokens()) {
			st = new StringTokenizer(br.readLine());
		}
		return st.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	void myAssert(boolean e, String s) {
		if (!e) {
			throw new Error("Assertion failure " + s);
		}
	}

	private static final String FILENAME = "perm";

	public void solve() throws IOException {
		int n = nextInt();
		int m = nextInt();
		int k = nextInt();
		myAssert(1 <= n && n <= 16, "Wrong n");
		myAssert(1 <= m && m <= 1e9, "Wrong m");
		myAssert(1 <= k && k <= 1e9, "Wrong k");
		int[] a = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = nextInt();
			myAssert(1 <= a[i] && a[i] <= 1e9, "Wrong element of set");
		}
		Arrays.sort(a);
		for (int i = 0; i < n - 1; i++) {
			myAssert(a[i] != a[i + 1], "Not a set");
		}
		int[][] gcd = new int[n][n];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				gcd[i][j] = gcd(a[i], a[j]);
			}
		}
		int[] p = new int[n];
		for (int i = 0; i < n; i++) {
			p[i] = i;
		}
		int c = 0;
		do {
			if (good(gcd, p, k)) {
				c++;
			}
			if (c == m) {
				for (int i = 0; i < n; i++) {
					out.print(a[p[i]] + " ");
				}
				return;
			}
		} while (nextPerm(p));
		out.println(-1);
	}
	
	boolean good(int[][] gcd, int[] a, int k) {
		for (int i = 0; i < a.length - 1; i++) {
			if (gcd[a[i]][a[i + 1]] < k) {
				return false;
			}
		}
		return true;
	}
	
	boolean nextPerm(int[] p) {
		int i = p.length - 1;
		while (i > 0 && p[i] < p[i - 1]) {
			i--;
		}
		if (i == 0) {
			return false;
		}
		int imin = i;
		for (int j = i + 1; j < p.length; j++) {
			if (p[j] > p[i - 1] && p[j] < p[imin]) {
				imin = j;
			}
		}
		int t = p[imin];
		p[imin] = p[i - 1];
		p[i - 1] = t;
		for (int j = i; p.length - (j - i) - 1 > j; j++) {
			t = p[j];
			p[j] = p[p.length - (j - i) - 1];
			p[p.length - (j - i) - 1] = t;
		}
		return true;
	}

	private int gcd(int i, int j) {
		while (i != 0) {
			int t = i;
			i = j % i;
			j = t;
		}
		return j;
	}
}
