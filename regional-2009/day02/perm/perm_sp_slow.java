// Задача "Перестановки"
// Региональный этап Всероссийской олимпиады школьников по информатике
// Автор задачи: Сергей Мельников, melnikov@rain.ifmo.ru
// Автор решения: Сергей Поромов, poromov@rain.ifmo.ru
// 86 баллов

import java.io.*;
import java.util.*;

public class perm_sp_slow implements Runnable {

	public static void main(String[] args) {
		new Thread(new perm_sp_slow()).run();
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
		int l = (1 << n);
		int[][] c = new int[l][n];
		for (int i = 0; i < n; i++) {
			c[1 << i][i] = 1;
		}
		for (int i = 0; i < l; i++) {
			for (int j = 0; j < n; j++) {
				if ((i & (1 << j)) != 0) {
					for (int jj = 0; jj < n; jj++) {
						if (jj != j && ((i & (1 << jj)) != 0)) {
							if (gcd(a[j], a[jj]) >= k) {
								c[i][j] += c[i ^ (1 << j)][jj];
							}
						}
					}
				}
			}
		}
		int[] ans = new int[n];
		int mask = l - 1;
		{
			int i = 0;
			while (i < n && m > c[l - 1][i]) {
				m -= c[l - 1][i++];
			}
			if (i == n) {
				out.println(-1);
				return;
			}
			ans[0] = a[i];
			mask ^= (1 << i);
		}
		for (int j = 1; j < n; j++) {
			int i = 0;
			while (true) {
				if (((mask & (1 << i)) != 0) && gcd(ans[j - 1], a[i]) >= k) {
					if (c[mask][i] >= m) {
						break;
					} else {
						m -= c[mask][i];
					}
				}
				i++;
			}
			ans[j] = a[i];
			mask ^= (1 << i);
		}
		for (int i = 0; i < n; i++) {
			out.print(ans[i] + " ");
		}
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
