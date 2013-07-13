// Задача "Перестановки"
// Автор решения: Сергей Мельников, melnikov@rain.ifmo.ru

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class perm_sm extends Thread {

	int n, k;
	int a[];
	int gcd[][];

	int gcd(int i, int j) {
		return gcd[i][j];
	}

	long d[][];
	long cnt = 0;

	long count(int mask, int first) {
		if (d[mask][first] != -1) {
			return d[mask][first];
		}
		if (mask == (1 << first)) {
			return d[mask][first] = 1;
		}
		long res = 0;
		myAssert(mask > (mask ^ (1 << first)));
		mask ^= (1 << first);
		for (int i = 0; i < n; i++) {
			if (((1 << i) & mask) == 0) {
				continue;
			}
			if (gcd(i, first) >= k) {
				res += count(mask, i);
			}
		}
		return d[mask ^ (1 << first)][first] = res;
	}

	ArrayList<Integer> v;

	void get(int mask, long m, int first) {
		if (mask == (1 << first)) {
			if (m == 1) {
				v.add(a[first]);
			} else {
				throw new Error();
			}
			return;
		}
		mask ^= (1 << first);
		for (int i = 0; i < a.length; i++) {
			if (((1 << i) & mask) == 0) {
				continue;
			}
			if (gcd(i, first) >= k) {
				if (count(mask, i) >= m) {
					v.add(a[first]);
					get(mask, m, i);
					return;
				} else {
					m -= count(mask, i);
				}
			}
		}
	}

	void solve() {
		n = in.nextInt();
		myAssert(1 <= n && n <= 16);
		int m = in.nextInt();
		myAssert(1 <= m && m <= 1000000000);
		k = in.nextInt();
		myAssert(1 <= k && k <= 1000000000);
		a = new int[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = in.nextInt();
			myAssert(1 <= a[i] && a[i] <= 1000000000);
			for (int j = 0; j < i; j++) {
				myAssert(a[i] != a[j]);
			}
		}
		Arrays.sort(a);
		gcd = new int[n][n];
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < a.length; j++) {
				gcd[i][j] = BigInteger.valueOf(a[i]).gcd(
						BigInteger.valueOf(a[j])).intValue();
			}
		}
		d = new long[1 << n][n];
		for (int i = 0; i < d.length; i++) {
			Arrays.fill(d[i], -1);
		}
		v = new ArrayList<Integer>();
		int all = (1 << n) - 1;
		for (int i = 0; i < a.length; i++) {
			if (count(all, i) >= m) {
				get(all, m, i);
				break;
			} else {
				m -= count(all, i);
			}
		}
		if (v.isEmpty()) {
			out.println(-1);
		} else {
			for (int i = 0; i < v.size(); i++) {
				if (i != 0)
					out.print(" ");
				out.print(v.get(i));
			}
		}
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	Scanner in;
	PrintWriter out;

	public void run() {
		try {
			in = new Scanner(new File("perm.in"));
			out = new PrintWriter(new File("perm.out"));
			solve();
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public static void main(String[] args) {
		new perm_sm().start();
	}

}
