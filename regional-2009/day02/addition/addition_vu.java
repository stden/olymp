// Задача "Неправильное сложение"
// Региональный этап Всероссийской олимпиады по информатике
// Авторы задачи: Владимир Ульянцев, Федор Царев
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

// В моем понимании условия, именно это решение имеет место быть.

import java.io.*;
import java.util.*;

public class addition_vu {
	static long sum(long a, long b) {
		String ans = "";
		while (a > 0 || b > 0) {
			ans = a % 10 + b % 10 + ans;
			//System.out.println(ans);
			a /= 10;
			b /= 10;
		}
		return Long.parseLong(ans);
	}

	static TreeSet<Long> num;
	static int n;
	static long[] a;
	static boolean[] was;

	static void dfs(int len, long s) {
		if (len == n) {
			num.add(s);
		} else {
			for (int i = 0; i < n; i++) {
				if (!was[i]) {
					was[i] = true;
					dfs(len + 1, sum(s, a[i]));
					was[i] = false;
				}
			}
		}
	}

	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new File("addition.in"));
		PrintWriter out = new PrintWriter(new File("addition.out"));
		n = 3;
		a = new long[n];
		was = new boolean[n];
		num = new TreeSet();
		
		for (int i = 0; i < n; i++)
			a[i] = in.nextInt();
		dfs(0, 0);

		out.println(num.size() == 1 ? "NO" : "YES");
		for (long i : num) {
			out.println(i);
		}

		in.close();
		out.close();
	}
}