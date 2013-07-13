// Задача "Треугольники"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

import java.io.*;
import java.util.*;

public class triangle_vu_wrong3 {
	static double eps = 1e-9;

	static class Pair implements Comparable<Pair> {
		long x, y;
		long dist;
		double fi;
		Pair(long xx, long yy) {
			x = xx;
			y = yy;
			dist = x * x + y * y;
			double f = Math.atan2(y, x);
			fi = (f < 0) ? f + Math.PI : f;
		}

		public int compareTo(Pair p) {
			if (dist > p.dist || dist == p.dist && fi > p.fi)
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
				a[j] = new Pair(x[j] - x[i], y[j] - y[i]);
			}
			Arrays.sort(a);
			int k = 1;
			for (int j = 1; j <= n; j++) {
				if (j != n && a[j].dist == a[j - 1].dist) {
					k++;
					if (a[j].x * a[j - 1].y - a[j - 1].x * a[j].y == 0) {
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