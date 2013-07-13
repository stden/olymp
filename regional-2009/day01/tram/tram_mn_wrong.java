// Задача "Трамвай"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Маским Носенко, nosenkomax@gamil.com
// Автор решения: Маским Носенко, nosenkomax@gmail.com
// Неправльное предположение о том, что все a[i]-b[i] - различны

import java.util.*;
import java.io.*;

public class tram_mn_wrong implements Runnable {

	public static void main(String args[]) {
		new Thread(new tram_mn_wrong()).start();
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

	class Heap {
		final int NMAX = 131072;
		long a[];
		int n;
		boolean isMax;
		HashMap<Long, Integer> hm;
		long sum;

		public Heap(boolean isMax) {
			a = new long[NMAX];
			n = 0;
			sum = 0;
			this.isMax = isMax;
			hm = new HashMap<Long, Integer>();
		}
		
		public int size() {
			return n;
		}

		public void add(long h) {

			sum += h;
			a[n] = h;
			hm.put((long)a[n], n);
			Sift_Up(n);
			n++;
		}

		public void swap(int i, int j) {
			hm.put(a[j], i);
			long t = a[j];
			a[j] = a[i];
			a[i] = t;
		}

		public void Sift_Up(int i) {
			while (i > 0 && (a[i] < a[(i-1) / 2] ^ isMax)) {
				swap(i, (i-1) / 2);
				i = (i-1) / 2;
			}
			hm.put(a[i], i);
		}

		public void Sift_Down(int i) {
			while (i * 2 + 1 < n) {
				int t = i;
				if (a[i * 2 + 1] < a[t] ^ isMax)
					t = i * 2 + 1;
				if (i * 2 + 2 < n && ((a[i * 2 + 2] < a[t]) ^ isMax))
					t = i * 2 + 2;
				if (t != i) {
					swap(i, t);
					i = t;
				} else
					break;
			}
			hm.put(a[i], i);
		}
		
		public void Delete(long h) {
			sum -= h;
			My_Assert(hm.containsKey(h), " " + h);
			int i = hm.get(h);
			swap(i, n - 1);
			n--;
			Sift_Up(i);
			Sift_Down(i);
		}
		
		public long getExtremum() {
			return a[0];
		}
		
		public long extractExtremum() {
			long q = a[0];
			sum -= q;
			if (hm.get(q) == 0) {
				if (n > 1 && a[1] == a[0])
					hm.put(q, 1);
				else if (n > 2 && a[2] == a[0])
					hm.put(q, 2);
				else
					hm.remove(q);
			}
			
			swap(0, n - 1);
			n--;
			Sift_Down(0);
			return q;
		}
		
		
		public long getSum() {
			return sum;
		}

	}

	class Event implements Comparable<Event> {
		int k;
		int n;
		boolean isComeIn;

		public Event(int i,int nn, boolean b) {
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

		Event e[] = new Event[2 * n  + 2];
		long h[] = new long[n + 1];
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
			My_Assert(c < d, "c[" + (i + 1) + "] >=  d[" + (i +1) + "]: " + c + " " + d);
			

			sum += b * (d - c);
			h[i] = a - b;
			e[2 * i] = new Event(c, i, true);
			e[2 * i + 1] = new Event(d, i, false);
		}
		
		h[n] = -2551361;
		e[2*n] = new Event(p + 1, n, true);
		e[2*n + 1] = new Event(p + 1, n, false);
		
		Arrays.sort(e);
		Heap sit, stand;
		sit = new Heap(false);
		stand = new Heap(true);
		long s = 0;
		int prev = -1;
//		System.err.println(sum);
		
		for (Event ev : e) {
//			System.err.println(ev);
			int k = ev.n;
			
			if (ev.k != prev && prev != -1) {
				s = sit.getSum();
//				System.err.println("on " + prev + " sum= " + s);
			}	
			
			if (ev.isComeIn) {
				if (h[k] > 0) {
					if (sit.size() < m) {
						sit.add(h[k]);
//						System.err.println(k + " " + h[k] + " sits");
//						System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//						System.err.println(stand.size() + " stand " + stand.getExtremum());
//						System.err.println(sit.size() + " sit " + sit.getExtremum());
//						System.err.println("-----------------");
					} else {
						if (h[k] > sit.getExtremum()) {
							long t = sit.extractExtremum();
							sit.add(h[k]);
							stand.add(t);
//							System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//							System.err.println(k + " " + h[k] + " sits");
//							System.err.println("HZ who " + t + " stands");
//							System.err.println(stand.size() + " stand " + stand.getExtremum());
//							System.err.println(sit.size() + " sit " + sit.getExtremum());
//							System.err.println("-----------------");
						} else {
							stand.add(h[k]);
//							System.err.println(k + " " + h[k] + " stands");
//							System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//							System.err.println(stand.size() + " stand " + stand.getExtremum());
//							System.err.println(sit.size() + " sit " + sit.getExtremum());
//							System.err.println("-----------------");
//							System.err.println(stand.size() + " " + stand.getExtremum());
						}
					}
				} else {
					stand.add(h[k]);
//					System.err.println(k + " " + h[k] +   " stands");
//					System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//					System.err.println(stand.size() + " stand " + stand.getExtremum());
//					System.err.println(sit.size() + " sit " + sit.getExtremum());
//					System.err.println("-----------------");
				}
			} else {
				if (stand.size() > 0 && stand.getExtremum() >= h[k]) {
					stand.Delete(h[k]);
//					System.err.println(k + " " + h[k] + " quits");
//					System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//					System.err.println(stand.size() + " stand " + stand.getExtremum());
//					System.err.println(sit.size() + " sit " + sit.getExtremum());
//					System.err.println("-----------------");
				} else {
					sit.Delete(h[k]);
					
//					System.err.println(k + " " + h[k] + " quits");
//					System.err.println(stand.hm.containsKey(-625222L) + " " + stand.hm.get(-625222L));
//					System.err.println(stand.size() + " stand " + stand.getExtremum());
//					System.err.println(sit.size() + " sit " + sit.getExtremum());
					
					if (stand.size() > 0 && stand.getExtremum() > 0) {
						long t = stand.extractExtremum();
						sit.add(t);
//						System.err.println("HZ who sits " + t);
						
					}
					
//					System.err.println(stand.size() + " stand " + stand.getExtremum());
//					System.err.println(sit.size() + " sit " + sit.getExtremum());
//					System.err.println("-----------------");
					
				}
			}
			if (prev != ev.k && prev != -1) {
				sum += s * (ev.k - prev);
//				System.err.println(sum + " changed");
			}	
			
			prev = ev.k;
		}
		
		out.println(sum);
	}
}