// Задача "Трамвай"
// Автор решения: Сергей Мельников, melnikov@rain.ifmo.ru

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StreamTokenizer;
import java.util.Arrays;
import java.util.TreeSet;

public class tram_sm extends Thread {
	class Passenger implements Comparable<Passenger> {
		long a, b, in, out, key ,d;
		long lastch;

		public Passenger(int a, int b, int c, int d, int key) {
			this.a = a;
			this.b = b;
			this.in = c;
			this.out = d;
			this.key = key;
			lastch = in;
			this.d = a - b;
		}

		public int compareTo(Passenger o) {
			if (d > o.d) {
				return -1;
			}
			if (d < o.d) {
				return 1;
			}
			if (key < o.key)
				return -1;
			if (key > o.key)
				return 1;
			return 0;
		}
		@Override
		public String toString() {
			return ""+key+"{"+d+"} ";
		}
	}

	class Event implements Comparable<Event> {
		Passenger p;
		int time;
		boolean isIn;

		public Event(int time, Passenger p, boolean isIn) {
			this.time = time;
			this.p = p;
			this.isIn = isIn;
		}

		public int compareTo(Event o) {
			if (time < o.time)
				return -1;
			if (time > o.time)
				return 1;
			return 0;
		}

	}

	TreeSet<Passenger> sit, stand;
	long time;

	long res;

	void pushDown(Passenger p) {
		if (p.a < p.b)
			return;
		stand.remove(p);
		res += p.b * (time - p.lastch);
		p.lastch = time;
		sit.add(p);
	}

	void solve() {
		int n = nextInt();
		int m = nextInt();
		// int p =
		nextInt();
		Passenger[] ps = new Passenger[n];
		Event[] ev = new Event[2 * n];
		for (int i = 0; i < ps.length; i++) {
			int a = nextInt();
			int b = nextInt();
			int c = nextInt();
			int d = nextInt();
			ps[i] = new Passenger(a, b, c, d, i+1);
			ev[2 * i] = new Event(c, ps[i], true);
			ev[2 * i + 1] = new Event(d, ps[i], false);
		}
		Arrays.sort(ev);
		sit = new TreeSet<Passenger>();
		stand = new TreeSet<Passenger>();
		res = 0;
		for (int i = 0; i < ev.length; i++) {
			time = ev[i].time;
//			System.err.println(time+":");
			if (ev[i].isIn) {
				stand.add(ev[i].p);
				ev[i].p.lastch = time;
				if (sit.size()<m) {
					pushDown(stand.first());
				} else if (stand.first().compareTo(sit.last()) < 0) {
//					System.err.println(stand.first()+"-->"+sit.last());
					Passenger up = sit.last();
					sit.remove(up);
					Passenger down = stand.first();
					stand.remove(down);
					res += up.a * (time - up.lastch);
					up.lastch = time;
					res += down.b * (time - down.lastch);
					down.lastch = time;
					sit.add(down);
					stand.add(up);
				}
			} else {
				if (stand.contains(ev[i].p)) {
					res += ev[i].p.b * (time - ev[i].p.lastch);
					stand.remove(ev[i].p);
				} else {
					res += ev[i].p.a * (time - ev[i].p.lastch);
					sit.remove(ev[i].p);
					if (!stand.isEmpty()) {
						pushDown(stand.first());
					}
				}
			}
//			System.err.println("sit:"+sit);
//			System.err.println("stand:"+stand);
		}
//		System.out.println(res);
		out.println(res);
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	StreamTokenizer in;
	PrintWriter out;

	int nextInt() {
		try {
			in.nextToken();
			return (int) in.nval;
		} catch (IOException e) {
			return 0;
		}
	}

	public void run() {
		try {
			in = new StreamTokenizer(new BufferedReader(new FileReader(
					"tram.in")));
			out = new PrintWriter(new File("tram.out"));
			solve();
			out.flush();
			out.close();
			// new FilePrinter("tram.out",System.out);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public static void main(String[] args) {
		new tram_sm().start();
	}

}
