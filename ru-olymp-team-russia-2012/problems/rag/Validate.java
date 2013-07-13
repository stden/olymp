import static java.lang.Math.abs;
import static java.lang.Math.max;
import static java.lang.Math.min;

import java.io.*;
import java.util.*;

public class Validate {
	public void run() {
		StrictScanner inf = new StrictScanner(System.in);
		int w = inf.nextInt();
		int h = inf.nextInt();
		ensureLimits(w, 2, 100000, "w");
		ensureLimits(h, 2, 100000, "h");
		inf.nextLine();
		int n = inf.nextInt();
		ensureLimits(n, 2, 100000, "n");
		inf.nextLine();
		Point[] p = new Point[n];
		for (int i = 0; i < n; i++) {
			int x = inf.nextInt();
			int y = inf.nextInt();
			if (i > 0) {
				ensureLimits(y, 1, h - 1, "y[" + (i + 1) + "]");
			} else {
				ensureLimits(y, h, h, "y[" + (i + 1) + "]");
			}
			if (i + 1 < n) {
				ensureLimits(x, 1, w - 1, "x[" + (i + 1) + "]");
			} else {
				ensureLimits(x, w, w, "x[" + (i + 1) + "]");
			}
			p[i] = new Point(x, y);
			inf.nextLine();
		}
		isChain(p);
		isChain(rev(p)); // not sure whether the algorithm is correct
		for (int i = 0; i < n - 2; i++) {
			int dxi = p[i + 1].x - p[i].x;
			int dyi = p[i + 1].y - p[i].y;
			int dxi1 = p[i + 2].x - p[(i + 1) % n].x;
			int dyi1 = p[i + 2].y - p[(i + 1) % n].y;
			ensure(vp(dxi, dyi, dxi1, dyi1) != 0
					|| sp(dxi, dyi, dxi1, dyi1) > 0,
					"two consequent sides are overlapping");
		}
		inf.close();
	}

	long vp(long x1, long y1, long x2, long y2) {
		return x1 * y2 - x2 * y1;
	}

	long sp(long x1, long y1, long x2, long y2) {
		return x1 * x2 + y1 * y2;
	}

	final static double EPS = 1e-8;

	static int compare(double a, double b) {
		return abs(a - b) < EPS ? 0 : a < b ? -1 : 1;
	}

	static Point[] rev(Point[] p) {
		for (int i = 0; i < p.length; i++) {
			int t = p[i].x;
			p[i].x = p[i].y;
			p[i].y = t;
		}
		return p;
	}

	boolean isChain(Point[] p) {
		final int n = p.length;
		{
			Set<Point> set = new HashSet<Point>();
			for (int i = 0; i < n; i++) {
				if (!set.add(p[i])) {
					return false;
				}
			}
		}
		Segment[] all = new Segment[n - 1];
		for (int i = 0; i + 1 < n; i++) {
			all[i] = new Segment(p[i], p[i + 1]);
		}
		final Comparator<Segment> comp = new Comparator<Segment>() {
			@Override
			public int compare(Segment o1, Segment o2) {
				double a = o1.getY(currentX);
				double b = o2.getY(currentX);
				final int c = Validate.compare(a, b);
				if (c == 0) {
					if (o1.p1 == o2.p1) {
						return Validate.compare(o1.getY(currentX + 1),
								o2.getY(currentX + 1));
					} else if (o2.p2 == o2.p2) {
						return Validate.compare(o1.getY(currentX - 1),
								o2.getY(currentX - 1));
					} else {
						return Validate.compare(o1.getY(currentX + 1),
								o2.getY(currentX + 1));
					}
				}
				return c;
			}
		};
		NavigableSet<Segment> set = new TreeSet<Segment>(comp);
		List<Event> events = new ArrayList<Event>();
		List<Event> verticalEvents = new ArrayList<Event>();
		for (Segment e : all) {
			if (e.p1.x == e.p2.x) {
				verticalEvents.add(new Event(e.p1.x, e, 0));
				events.add(new Event(e.p1.x, e, 0));
			} else {
				events.add(new Event(e.p1.x, e, 1));
				events.add(new Event(e.p2.x, e, -1));
			}
		}

		Collections.sort(events);
		Collections.sort(verticalEvents);
		int curVertical = 0;
		for (int i = 0; i < events.size();) {
			int j = i;
			int curX = events.get(i).x;
			currentX = events.get(i).x;
			while (j < events.size() && events.get(j).x == curX) {
				++j;
			}
			int nextVertical = curVertical;
			while (nextVertical < verticalEvents.size()
					&& verticalEvents.get(nextVertical).x == curX) {
				if (nextVertical > curVertical) {
					final Segment s1 = verticalEvents.get(nextVertical).s;
					final Segment s2 = verticalEvents.get(nextVertical - 1).s;
					ensure(!intersects(s1, s2), s1 + " and " + s2
							+ " does intersect");
				}
				++nextVertical;
			}
			if (!checkVertical(set, verticalEvents, curVertical, nextVertical)) {
				return false;
			}
			for (int cur = i; cur < j; cur++) {
				Event e = events.get(cur);
				if (e.begin == 0) {
					continue;
				}
				Segment s = e.s;
				if (e.begin == -1) {
					set.remove(s);
					// if (!set.remove(s)) {
					// throw new AssertionError();
					// }
				}
				Segment low = set.floor(s);
				if (low != null) {
					Segment s1 = low;
					Segment s2 = s;
					ensure(!intersects(s1, s2), s1 + " and " + s2
							+ " does intersect");
				}
				Segment high = set.ceiling(s);
				if (high != null) {
					Segment s1 = high;
					Segment s2 = s;
					ensure(!intersects(s1, s2), s1 + " and " + s2
							+ " does intersect");
				}
				if (e.begin == 1) {
					// if (!set.add(s)) {
					// throw new AssertionError();
					// }
					set.add(s);
				}
			}
			if (!checkVertical(set, verticalEvents, curVertical, nextVertical)) {
				return false;
			}
			curVertical = nextVertical;
			i = j;
		}
		return true;
	}

	boolean checkVertical(NavigableSet<Segment> set,
			List<Event> verticalEvents, int curVertical, int nextVertical) {
		for (int cur = curVertical; cur < nextVertical; cur++) {
			final Segment curV = verticalEvents.get(cur).s;
			Segment e = set.floor(curV);
			if (e != null && intersects(e, curV)) {
				Segment s1 = e;
				Segment s2 = curV;
				ensure(false, s1 + " and " + s2 + " does intersect");
				return false;
			}
		}
		return true;
	}

	static double currentX;

	static long vmulFromPoint(Point from, Point a, Point b) {
		long x1 = a.x - from.x;
		long y1 = a.y - from.y;
		long x2 = b.x - from.x;
		long y2 = b.y - from.y;
		return x1 * y2 - x2 * y1;
	}

	static boolean intersects(Segment a, Segment b) {
		long v1 = vmulFromPoint(a.p1, b.p1, b.p2);
		long v2 = vmulFromPoint(a.p2, b.p1, b.p2);
		long u1 = vmulFromPoint(b.p1, a.p1, a.p2);
		long u2 = vmulFromPoint(b.p2, a.p1, a.p2);
		if (v1 == 0 && v2 == 0 && u1 == 0 && u2 == 0) {
			int z1 = min(max(a.p1.x, a.p2.x), max(b.p1.x, b.p2.x))
					- max(min(a.p1.x, a.p2.x), min(b.p1.x, b.p2.x));
			int z2 = min(max(a.p1.y, a.p2.y), max(b.p1.y, b.p2.y))
					- max(min(a.p1.y, a.p2.y), min(b.p1.y, b.p2.y));
			if (z1 < 0 || z2 < 0) {
				return false;
			}
			if (z1 > 0 || z2 > 0) {
				return true;
			}
			return !(a.p1 == b.p1 || a.p2 == b.p1 || a.p1 == b.p2 || a.p2 == b.p2);
		}
		if (a.p1 == b.p1 || a.p2 == b.p1 || a.p1 == b.p2 || a.p2 == b.p2) {
			return false;
		}
		return Long.signum(v1) != Long.signum(v2)
				&& Long.signum(u1) != Long.signum(u2);
	}

	static class Segment {
		Point p1;
		Point p2;

		Segment(Point p1, Point p2) {
			if (p1.x > p2.x || p1.x == p2.x && p1.y > p2.y) {
				Point t = p1;
				p1 = p2;
				p2 = t;
			}
			this.p1 = p1;
			this.p2 = p2;
		}

		double getY(double x) {
			if (p1.x == p2.x) {
				return max(p2.y, p1.y) - 10 * EPS;
			}
			return p1.y + 1. * (x - p1.x) / (p2.x - p1.x) * (p2.y - p1.y);
		}

		@Override
		public String toString() {
			return "Segment [p1=" + p1 + ", p2=" + p2 + "]";
		}

	}

	static class Event implements Comparable<Event> {
		int x;
		Segment s;
		int begin;

		Event(int x, Segment s, int begin) {
			this.x = x;
			this.s = s;
			this.begin = begin;
		}

		@Override
		public int compareTo(Event o) {
			if (x != o.x) {
				return x - o.x;
			}
			if (begin != o.begin) {
				return begin - o.begin;
			}
			return s.p1.y - o.s.p1.y;
		}

		@Override
		public String toString() {
			return "Event [x=" + x + ", s=" + s + ", begin=" + begin + "]";
		}

	}

	static class Point {
		int x;
		int y;

		Point(int x, int y) {
			this.x = x;
			this.y = y;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + x;
			result = prime * result + y;
			return result;
		}

		@Override
		public String toString() {
			return "Point [x=" + x + ", y=" + y + "]";
		}

		@Override
		public boolean equals(Object obj) {
			Point other = (Point) obj;
			if (x != other.x)
				return false;
			if (y != other.y)
				return false;
			return true;
		}

	}

	public static void main(String[] args) {
		new Validate().run();
	}

	public class StrictScanner {
		private final BufferedReader in;
		private String line = "";
		private int pos;
		private int lineNo;

		public StrictScanner(InputStream source) {
			in = new BufferedReader(new InputStreamReader(source));
			nextLine();
		}

		public void close() {
			ensure(line == null, "Extra data at the end of file");
			try {
				in.close();
			} catch (IOException e) {
				throw new AssertionError("Failed to close with " + e);
			}
		}

		public void nextLine() {
			ensure(line != null, "EOF");
			ensure(pos == line.length(), "Extra characters on line " + lineNo);
			try {
				line = in.readLine();
			} catch (IOException e) {
				throw new AssertionError("Failed to read line with " + e);
			}
			pos = 0;
			lineNo++;
		}

		public String next() {
			ensure(line != null, "EOF");
			ensure(line.length() > 0, "Empty line " + lineNo);
			if (pos == 0)
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " starts with whitespace");
			else {
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(pos) == ' ', "Wrong whitespace on line "
						+ lineNo);
				pos++;
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " has double whitespace");
			}
			StringBuilder sb = new StringBuilder();
			while (pos < line.length() && line.charAt(pos) > ' ')
				sb.append(line.charAt(pos++));
			return sb.toString();
		}

		public int nextInt() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Integer.parseInt(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}

		public long nextLong() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Long.parseLong(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}

		public double nextDouble() {
			String s = next();
			ensure(s.length() == 1 || s.startsWith("0.") || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Double.parseDouble(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}
	}

	void ensure(boolean b, String message) {
		if (!b) {
			throw new AssertionError(message);
		}
	}

	void ensureLimits(int n, int from, int to, String name) {
		ensure(from <= n && n <= to, name + " must be from " + from + " to "
				+ to);
	}

	void ensureLimitsLong(long n, long from, long to, String name) {
		ensure(from <= n && n <= to, name + " must be from " + from + " to "
				+ to);
	}

}