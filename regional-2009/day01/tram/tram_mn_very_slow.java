// Задача "Трамвай"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Маским Носенко, nosenkomax@gamil.com
// Автор решения: Маским Носенко, nosenkomax@gmail.com
// Очень медленное решение - O(p * (n*n + m))


import java.util.*;
import java.io.*;

public class tram_mn_very_slow implements Runnable {

	public static void main(String args[]) {
		new Thread(new tram_mn_very_slow()).start();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	private String FNAME = "tram";
	boolean eof = false;

	@Override
	public void run() {
		try {
			Locale.setDefault(Locale.US);
			br = new BufferedReader(new FileReader(FNAME + ".in"));
			out = new PrintWriter(FNAME + ".out");
			solve();
			br.close();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (IOException e) {
				eof = true;
				return "0";
			}
		}
		return st.nextToken();
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	long nextLong() {
		return Long.parseLong(nextToken());
	}

	double nextDouble() {
		return Double.parseDouble(nextToken());
	}

	void My_Assert(boolean b, String s) {
		if (!b)
			throw new Error("Assertion " + s);
	}
	
	class Event implements Comparable<Event> {
		int k;
		int n;
		boolean isComeIn;

		public Event(int i, int nn, boolean b) {
			k = i;
			n = nn;
			isComeIn = b;
		}
		
		@Override
		public int compareTo(Event o) {
			if (k != o.k)
				return k > o.k ? 1 : -1;
			if (isComeIn != o.isComeIn)
				return isComeIn ? -1 : 1;
			return 0;
		}

		@Override
		public String toString() {
			return "[ " + n + " " + isComeIn + " " + " " + k + " ]";
		}
	}

	private void solve() {
		int n, m, p;
		n = nextInt();
		m = nextInt();
		p = nextInt();

		My_Assert(1 <= n && n <= 100000, "n out of range: " + n);
		My_Assert(1 <= m && m <= 100000, "m out of range: " + m);
		My_Assert(2 <= p && p <= 100000, "p out of range: " + p);

		Event e[] = new Event[2 * n];
		long h[] = new long[n];
		long sum = 0;
		for (int i = 0; i < n; i++) {
			int a, b, c, d;
			a = nextInt();
			b = nextInt();
			c = nextInt();
			d = nextInt();

			My_Assert(-1000000 <= a && a <= 1000000, "a[" + (i + 1) + "] out of range: " + a);
			My_Assert(-1000000 <= b && b <= 1000000, "b[" + (i + 1) + "] out of range: " + b);
			My_Assert(1 <= c && c <= p, "c[" + (i + 1) + "] out of range: " + c);
			My_Assert(1 <= d && d <= p, "d[" + (i + 1) + "] out of range: " + d);
			My_Assert(c < d, "c[" + (i + 1) + "] >=  d[" + (i + 1) + "]: " + c
					+ " " + d);

			sum += b * (d - c);
			h[i] = a - b;
			e[2 * i] = new Event(c, i, true);
			e[2 * i + 1] = new Event(d, i, false);
		}

		bsort(e);
		
		for (int i = 0; i < e.length; i++) {
//			System.err.println(e[i]);
		}
		
		System.err.println();
		
		ArrayList<Integer> within = new ArrayList<Integer>();
		int ev = 0;
		for (int i = 1; i <= p; i++) {
			while (ev < 2 * n && e[ev].k == i) {
//				System.err.println(e[ev]);
				if (e[ev].isComeIn) {
					within.add((int) h[e[ev].n]);
//					System.err.println("added " + h[e[ev].n]);
				} else {
					int q = (int)h[e[ev].n];
					int t = within.indexOf(q);
					
					within.remove(t);
				}
				ev++;
			}
			bsort(within);
			int k = within.size();
			for (int j = 0; j < Math.min(m, k); j++)
				if (within.get(k - j - 1) > 0)
					sum += within.get(k - j - 1);
		}
		
		out.println(sum);
	}

	private void bsort(ArrayList<Integer> a) {
		int n = a.size();
		for (int j = 0; j < n; j++)
			for (int i = 0; i < n - 1; i++)
				if (a.get(i) > a.get(i + 1)) {
					int t = a.get(i);
					int q = a.get(i + 1); 
					a.set(i, q);
					a.set(i + 1, t);
				}	
			
	}

	private void bsort(Event[] a) {
		int n = a.length;
		for (int j = 0; j < n;j++)
			for (int i = 0; i < n - 1; i++)
				if (a[i].compareTo(a[i + 1]) > 0) {
					Event t = new Event(a[i].k, a[i].n, a[i].isComeIn);
					a[i] = a[i+1];
					a[i+1] = t;
				}
					
	}

	

	
}