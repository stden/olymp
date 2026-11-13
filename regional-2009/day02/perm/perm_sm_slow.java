// Задача "Перестановки"
// Автор решения: Сергей Мельников, melnikov@rain.ifmo.ru
// Неверное решение - медленное, O(n!*n)

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class perm_sm_slow extends Thread {

	int n, k, m;
	int a[];
	ArrayList<Integer> v;
	int p[];
	boolean u[];

	void gen(int step) {
		if (step == n) {
			m--;
			if (m == 0) {
				for (int i = 0; i < p.length; i++) {
					v.add(a[p[i]]);
				}
				throw new OutOfMemoryError();
			}
			return;
		} else {
			for (int i = 0; i < n; i++) {
				if (!u[i]) {
					u[i] = true;
					p[step] = i;
					gen(step + 1);
					u[i] = false;
				}
			}
		}
	}

	void solve() {
		n = in.nextInt();
		myAssert(1 <= n && n <= 16);
		m = in.nextInt();
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
		v = new ArrayList<Integer>();
		p = new int[n];
		u = new boolean[n];
		try {
			gen(0);
		} catch (OutOfMemoryError e) {
		}
		if (v.isEmpty()) {
			out.println(-1);
		} else {
			for (int i = 0; i < v.size(); i++) {
				if (i != 0)
					out.print(" ");
				out.print(v.get(i));
				System.out.print(v.get(i) + " ");
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
		new perm_sm_slow().start();
	}

}
