// Задача "Треугольники"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Федор Царев, tsarev@rain.ifmo.ru

import java.io.*;
import java.util.*;

public class triangle_ft_wrong2 implements Runnable {

	private Scanner in;
	private PrintWriter out;
	String fname = "triangle";

	private void myAssert(boolean e, String message) {
		if (!e) {
			throw new Error("Assertion failure!!! " + message);
		}
	}

    class Pair {
    	int a;
    	int b;
    	public Pair(int a, int b) {
    		this.a = a;
    		this.b = b;
    	}
    	
    	public int hashCode() {
    		return 17 * a + 239 * b;
    	}

    	public boolean equals(Object o) {
    		Pair p = (Pair) o;
    		return a == p.a && b == p.b;
    	}

    }                   

	public void solve() {
		int n = in.nextInt();
		int[] x = new int[n];
		int[] y = new int[n];
		for (int i = 0; i < n; i++) {
			x[i] = in.nextInt();
			y[i] = in.nextInt();
		}

		HashSet<Pair> set = new HashSet<Pair>();
		for (int i = 0; i < n; i++) {
			set.add(new Pair(x[i], y[i]));
		}

		long res = 0;

		for (int i = 0; i < n; i++) {
			HashMap<Long, Integer> dist = new HashMap<Long, Integer>();
			for (int j = 0; j < n; j++) {
				if (i == j) {
					continue;
				}
				long xx = ((long) (x[i] - x[j])) * (x[i] - x[j]) + ((long) (y[i] - y[j])) * (y[i] - y[j]);
				Integer cnt = dist.get(xx);
				if (cnt == null) {
					cnt = 0;
				}
				dist.put(xx, cnt + 1);
			}
			for (Long xx : dist.keySet()) {
				res += dist.get(xx) * (dist.get(xx) - 1) / 2;	
			}
		}

		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				if (i == j) {
					continue;
				}
				int dx = x[i] - x[j];
				int dy = y[i] - y[j];
				int xx = x[i] + dx;
				int yy = y[i] + dy;
				if (set.contains(new Pair(xx, yy))) {
					res--;
				}
			}
		}
		out.println(res);
	}

	public void run() {
		try {
			solve();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		} finally {
			out.close();
		}		
	}

	public triangle_ft_wrong2() {
		try {
			in = new Scanner(new File(fname + ".in"));
			out = new PrintWriter(new File(fname + ".out"));
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}


	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Thread(new triangle_ft_wrong2()).start();
	}

}                       