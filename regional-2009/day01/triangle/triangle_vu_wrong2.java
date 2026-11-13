// Задача "Треугольники"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

// Непонятное решение, ответ почти правильный.

import java.io.*;
import java.util.*;

public class triangle_vu_wrong2 {
	static double eps = 1e-9;

	static class Pair implements Comparable<Pair> {
		double dist;
		double fi;
		Pair(double d, double f) {
			dist = d;
			fi = (f < 0) ? f + Math.PI : f;
		}

		public int compareTo(Pair p) {
			if (dist > p.dist || Math.abs(dist - p.dist) < eps && fi > p.fi)
				return 1;
			return -1;
		}
	}

	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new File("triangle.in"));
		PrintWriter out = new PrintWriter(new File("triangle.out"));

		int n = in.nextInt();
		long[] x = new long[n];
		long[] y = new long[n];

		for (int i = 0; i < n; i++) {
			x[i] = in.nextLong();
			y[i] = in.nextLong();
		}

		long ans = 0;
		for (int i = 0; i < n; i++) {
			Pair[] a = new Pair[n];
			for (int j = 0; j < n; j++) {
				a[j] = new Pair(Math.hypot(x[i] - x[j], y[i] - y[j]), 
								Math.atan2(y[j] - y[i], x[j] - x[i]));
			}
			Arrays.sort(a);
			int k = 1;
			for (int j = 1; j <= n; j++) {
				if (j != n && Math.abs(a[j].dist - a[j - 1].dist) < eps) {
					k++;
					if (Math.abs(a[j].fi - a[j - 1].fi) < eps) {
						ans--;
					}
				} else {
				    ans += k * (k - 1) / 2;
				    k = 1;
				}
			}
		}

		out.println(ans);

		in.close();
		out.close();
	}
}