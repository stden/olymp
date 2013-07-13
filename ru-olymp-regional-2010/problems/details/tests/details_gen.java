import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.TreeSet;

public class details_gen {
	public static void main(String[] args) throws IOException {
		Random rand = new Random(2109347856092378465L);
		for (int test = 1; test <= 25; test++) {
			PrintWriter out = new PrintWriter((test < 10 ? "0" : "") + test);
			switch (test) {
			case 1:
				out.println("1");
				out.println("1");
				out.println("0");
				break;
			case 2:
				out.println("1");
				out.println("1000000000");
				out.println("0");
				break;
			case 3:
				out.println("10");
				out
						.println("1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000");
				out.println("1 2");
				out.println("1 3");
				out.println("1 4");
				out.println("1 5");
				out.println("1 6");
				out.println("1 7");
				out.println("1 8");
				out.println("1 9");
				out.println("1 10");
				out.println("0");
				break;
			case 4:
				out.println("10");
				out.println("1 1 1 1 1 1 1 1 1 1");
				out.println("2 5 7");
				out.println("2 5 7");
				out.println("2 4 6");
				out.println("1 6");
				out.println("1 7");
				out.println("0");
				out.println("0");
				out.println("2 4 6");
				out.println("1 1");
				out.println("1 1");
				break;
			case 5:
				out.println("10");
				out.println("1 1 1 1 1 1 1 1 1 1");
				out.println("0");
				out.println("2 5 7");
				out.println("2 4 6");
				out.println("1 6");
				out.println("1 7");
				out.println("0");
				out.println("0");
				out.println("2 4 6");
				out.println("1 1");
				out.println("1 1");
				break;
			case 6:
				out.println("10");
				out.println("25 25 25 25 25 25 25 25 25 30");
				out.println("9 2 3 9 10 4 5 6 7 8");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				out.println("0");
				break;
			case 7:
				out.println("10");
				out.println("25 25 25 25 25 25 25 25 25 30");
				out.println("9 2 3 9 10 4 5 6 7 8");
				out.println("7 3 5 4 9 8 7 6");
				out.println("4 7 4 9 5");
				out.println("3 5 9 7");
				out.println("1 9");
				out.println("5 7 9 4 5 3");
				out.println("2 5 9");
				out.println("6 3 4 5 6 7 9");
				out.println("0");
				out.println("8 9 8 7 6 5 2 3 4");
				break;
			case 11:
				out.println("100");
				for (int i = 0; i < 100; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print("1000000000");
				}
				out.println();
				for (int i = 0; i < 100; i++) {
					out.print(100 - i - 1);
					for (int j = i + 1; j < 100; j++) {
						out.print(" " + (j + 1));
					}
					out.println();
				}
				break;
			case 16: {
				out.println("1000");
				for (int i = 0; i < 1000; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print("1000000000");
				}
				out.println();
				int m = 200000;
				for (int i = 0; i < 1000; i++) {
					int x = Math.min(1000 - i - 1, m);
					out.print(x);
					for (int j = i + 1; j < 1000 && m > 0; j++) {
						out.print(" " + (j + 1));
						m--;
					}
					out.println();
				}
			}
				break;
			case 21: {
				out.println("100000");
				for (int i = 0; i < 100000; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print("1000000000");
				}
				out.println();
				int m = 200000;
				for (int i = 0; i < 100000; i++) {
					int x = Math.min(100000 - i - 1, m);
					out.print(x);
					for (int j = i + 1; j < 100000 && m > 0; j++) {
						out.print(" " + (j + 1));
						m--;
					}
					out.println();
				}
			}
				break;
			default:
				int n = 50000 + rand.nextInt(50001);
				if (test <= 20) {
					n = 700 + rand.nextInt(301);
				}
				if (test <= 15) {
					n = 50 + rand.nextInt(51);
				}
				if (test <= 10) {
					n = 1 + rand.nextInt(10);
				}
				int[][] g = new int[n][];
				int m = rand.nextInt(Math.min(200000, n < 1000 ? n * (n - 1)
						/ 2 : 200000) + 1);
				if (test > 15) {
					while (m < 50000) {
						m = rand.nextInt(Math.min(200000, n < 1000 ? n
								* (n - 1) / 2 : 200000) + 1);
					}
				}
				ArrayList<Integer> al = new ArrayList<Integer>();
				for (int i = 0; i < g.length; i++) {
					int k = rand.nextInt(Math.min(Math.min(i + 1, m),
							test >= 23 ? Math.max(2 * m / n, 10)
									: Integer.MAX_VALUE));
					if (k > 0) {
						al.add(i);
					}
					g[i] = new int[k];
					m -= k;
					TreeSet<Integer> ts = new TreeSet<Integer>();
					int j = 0;
					while (ts.size() < k) {
						int x = rand.nextInt(i);
						if (!ts.contains(x)) {
							ts.add(x);
							g[i][j++] = x;
						}
					}
				}
				int[] a = new int[n];
				for (int i = 0; i < a.length; i++) {
					a[i] = i;
				}
				for (int i = 0; i < a.length; i++) {
					int j = rand.nextInt(i + 1);
					int tmp = a[i];
					a[i] = a[j];
					a[j] = tmp;
				}
				if (test > 15) {
					int one = al.get(rand.nextInt(al.size()));
					for (int i = 0; i < a.length; i++) {
						if (a[i] == one) {
							int tmp = a[0];
							a[0] = a[i];
							a[i] = tmp;
						}
					}
				}
				int[] b = new int[n];
				for (int i = 0; i < a.length; i++) {
					b[a[i]] = i;
				}
				int[] p = new int[n];
				for (int i = 0; i < p.length; i++) {
					p[i] = 1 + rand.nextInt(1000000000);
				}
				out.println(n);
				for (int i = 0; i < p.length; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print(p[i]);
				}
				out.println();
				for (int i = 0; i < a.length; i++) {
					out.print(g[a[i]].length);
					for (int j : g[a[i]]) {
						out.print(" " + (b[j] + 1));
					}
					out.println();
				}
				break;
			}
			out.close();
		}
	}
}
