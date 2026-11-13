// Задача "Треугольники"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

import java.io.*;
import java.util.*;

public class triangle_vu {
	static double eps = 1e-9;

	static class Pair implements Comparable<Pair> {
		long x, y;
		long dist;
		Pair(long xx, long yy) {
			x = xx;
			y = yy;
			dist = x * x + y * y;
		}

		public int compareTo(Pair p) {
			if (dist != p.dist) {
				return dist > p.dist ? 1 : -1;
			}
			boolean up = y > 0 || y == 0 && x > 0;
			boolean pUp = p.y > 0 || p.y == 0 && p.x > 0;

			long xx = up ? x : -x;
			long yy = up ? y : -y;
			long px = pUp ? p.x : -p.x;
			long py = pUp ? p.y : -p.y;

			long vmul = xx * py - yy * px;
			return vmul == 0 ? 0 : vmul > 0 ? -1 : 1;
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