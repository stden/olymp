import java.util.*;

import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	class Point {
		double x, y;

		public Point(double x, double y) {
			super();
			this.x = x;
			this.y = y;
		}
		
		public double length() {
			return Math.sqrt(x * x + y * y);
		}
		
		public double dist(Point p2) {
			return Math.sqrt((x - p2.x) * (x - p2.x) + (y - p2.y) * (y - p2.y)); 
		}
	}
	
	static final double veryBig = 1100;
	static final double eps = 1e-6;
	
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		Point p1 = new Point(ouf.nextDouble(), ouf.nextDouble());
		Point p2 = new Point(ouf.nextDouble(), ouf.nextDouble());
		if (p1.x >= veryBig || p1.x <= -veryBig ||
				p1.y >= veryBig || p1.y <= -veryBig ||
						p2.x >= veryBig || p2.x <= -veryBig ||
								p2.y >= veryBig || p2.y <= -veryBig) {
			return new Outcome(Type.WA, "Too big coordinates");
		}

		double r = inf.nextDouble();
		double l = inf.nextDouble();
		
		if (Math.abs(p1.length() - r) > eps) {
			return new Outcome(Type.WA, "Point1 out of circle");
		}
		if (Math.abs(p2.length() - r) > eps) {
			return new Outcome(Type.WA, "Point2 out of circle");
		}
		l = Math.min(2 * r, l);
		if (Math.abs(p1.dist(p2) - l) > eps) {
			return new Outcome(Type.WA, "Distance between points differ from right distance");
		}
		return new Outcome(Type.OK, "");
	}
}