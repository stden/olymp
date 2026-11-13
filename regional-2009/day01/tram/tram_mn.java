// Задача "Трамвай"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Маским Носенко, nosenkomax@gamil.com
// Автор решения: Маским Носенко, nosenkomax@gmail.com


import java.util.*;
import java.io.*;

public class tram_mn implements Runnable {

	public static void main(String args[]) {
		new Thread(new tram_mn()).start();
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
		long k;
		boolean isComeIn;
		Pass p;

		public Event(long i, int nn, boolean s, Pass ps) {
			k = i;
			isComeIn = s;
			p = ps;
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
			return "[ " + isComeIn + " " + k + " ]";
		}
	}

	class Pass implements Comparable<Pass> {
		long a, b;
		long c, d;
		int n;

		public Pass(long aa, long bb, long cc, long dd, int nn) {
			a = aa;
			b = bb;
			c = cc;
			d = dd;
			n = nn;
		}
		
		@Override
		public int compareTo(Pass o) {
			if (a - b != o.a - o.b)
				return a - b > o.a - o.b ? 1 : -1;
			if (n != o.n)
				return n > o.n ? 1 : -1;
			return 0;
		}

		public boolean needSit() {
			return a > b;
		}
	}
	
	TreeSet<Pass> sit, stand;

	private void solve() {
		int n, m, p;
		n = nextInt();
		m = nextInt();
		p = nextInt();

		My_Assert(1 <= n && n <= 100000, "n out of range: " + n);
		My_Assert(1 <= m && m <= 100000, "m out of range: " + m);
		My_Assert(2 <= p && p <= 100000, "p out of range: " + p);

		Event e[] = new Event[2 * n];
		long a[] = new long[n], b[] = new long[n];
		
		for (int i = 0; i < n; i++) {
			long  c, d;
			a[i] = nextLong();
			b[i] = nextLong();
			c = nextLong();
			d = nextLong();

			My_Assert(-1000000 <= a[i] && a[i] <= 1000000, "a[" + (i + 1)	+ "] out of range: " + a[i]);
			My_Assert(-1000000 <= b[i] && b[i] <= 1000000, "b[" + (i + 1)	+ "] out of range: " + b[i]);
			My_Assert(1 <= c && c <= p, "c[" + (i + 1) + "] out of range: " + c);
			My_Assert(1 <= d && d <= p, "d[" + (i + 1) + "] out of range: " + d);
			My_Assert(c < d, "c[" + (i + 1) + "] >=  d[" + (i + 1) + "]: " + c
					+ " " + d);
			
			Pass ps = new Pass(a[i], b[i], c, d, i);
			e[2 * i] = new Event(c, i, true, ps);
			e[2 * i + 1] = new Event(d, i, false, ps);
		}
		
		long sum = 0;
		Arrays.sort(e);
		
		sit = new TreeSet<Pass>();
		stand = new TreeSet<Pass>();
		
		long time[] = new long[n];
		
		for (Event ev : e) {
			long t = ev.k;
			Pass ps = ev.p;
			if (ev.isComeIn) {
				time[ps.n] = ps.c;
				if (ps.needSit()) {
					if (sit.size() < m) {
						sit.add(ps);
					} else {
						if (sit.first().compareTo(ps) < 0) {
							Pass pt = sit.pollFirst();
							sit.add(ps);
							stand.add(pt);
							sum += (t - time[pt.n]) * pt.a;
							time[pt.n] = t;
						} else {
							stand.add(ps);
						}
					}
				} else {
					stand.add(ps);
				}
			} else {
				if (stand.contains(ps)) {
					sum += (t - time[ps.n]) * ps.b;
					stand.remove(ps);
				} else {
					sum += (t - time[ps.n]) * ps.a;
					My_Assert(sit.contains(ps), "WTF? Not exist");
					sit.remove(ps);
					if (stand.size() > 0 && stand.last().needSit()) {
						Pass pt = stand.pollLast();
						sit.add(pt);
						sum += (t - time[pt.n]) * pt.b;
						time[pt.n] = t;
					}
				}
			}
		}
		
		out.println(sum);

	}
}