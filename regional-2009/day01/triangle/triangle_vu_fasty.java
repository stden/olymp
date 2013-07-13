// Задача "Треугольники"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

// Решение, основанное на некоторых математических теоремах
// В худшем случае работает за O(n^2*logn + n^{2.137})

import java.io.*;
import java.util.*;

public class triangle_vu_fasty {
	static double eps = 1e-9;

	static class Pair implements Comparable<Pair> {
		long x, y;
		long dist;
		Pair(long x, long y) {
			this.x = x;
			this.y = y;
			dist = x * x + y * y;
		}

		public int compareTo(Pair p) {
			return dist == p.dist ? 0 : dist > p.dist ? 1 : -1;
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
					for (int v = j - 1; v >= 0 && a[v].dist == a[j].dist; v--) {
						if (a[j].x * a[v].y - a[v].x * a[j].y == 0) {
							ans--;
							break;
						}
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