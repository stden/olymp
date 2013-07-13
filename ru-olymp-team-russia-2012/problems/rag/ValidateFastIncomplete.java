import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.TreeSet;

public class ValidateFastIncomplete {

    public void run() {
        StrictScanner inf = new StrictScanner(System.in);

        int w = inf.nextInt();
        int h = inf.nextInt();
        inf.nextLine();
        ensureLimits(w, 1, 100000, "w");
        ensureLimits(h, 1, 100000, "h");
        
        int n = inf.nextInt();
        inf.nextLine();
        ensureLimits(n, 2, 100000, "n");

        int[] x = new int[n];
        int[] y = new int[n];
        for (int i = 0; i < n; i++) {
            x[i] = inf.nextInt();
            y[i] = inf.nextInt();
            inf.nextLine();
            
            if (i == 0) {
                ensureLimits(x[i], 1, w - 1, "x[1]");
                ensure(y[i] == h, "y[1]");
            } else if (i == n - 1) {
                ensure(x[i] == w, "x[" + n + "]");
                ensureLimits(y[i], 1, h - 1, "y[" + n + "]");
            } else {
                ensureLimits(x[i], 1, w - 1, "x[" + (i + 1) + "]");
                ensureLimits(y[i], 1, h - 1, "y[" + (i + 1) + "]");
            }
        }
        
        Segment[] s = new Segment[n - 1];
        ArrayList<Event> events = new ArrayList<Event>();
        for (int i = 0; i < n - 1; i++) {
            s[i] = new Segment(i, x[i], y[i], x[i + 1], y[i + 1]);
            if (y[i] != y[i + 1]) {
                events.add(new Event(0, Math.min(y[i], y[i + 1]), s[i]));
                events.add(new Event(2, Math.max(y[i], y[i + 1]), s[i]));
            } else {
                events.add(new Event(1, y[i], s[i]));
            }
        }
        
        Collections.sort(events);
        
        TreeSet<Segment> segs = new TreeSet<Segment>(new Cmp());
        for (Event e : events) {
            curY = e.y;
            if (e.type == 0) {
                Segment left = segs.lower(e.s);
                Segment right = segs.higher(e.s);
                if (left != null && right != null && Math.abs(left.index - right.index) > 1 && left.intersect(right)) {
                    ensure(false, "Segments " + (left.index + 1) + " and " + (right.index + 1) + " intersect");
                }
                if (left != null && Math.abs(left.index - e.s.index) > 1 && left.intersect(e.s)) {
                    ensure(false, "Segments " + (left.index + 1) + " and " + (e.s.index + 1) + " intersect");
                }
                if (right != null && Math.abs(right.index - e.s.index) > 1 && right.intersect(e.s)) {
                    ensure(false, "Segments " + (right.index + 1) + " and " + (e.s.index + 1) + " intersect");
                }
                segs.add(e.s);
            } else if (e.type == 1) {
                // todo
            } else if (e.type == 2) {
                Segment left = segs.lower(e.s);
                Segment right = segs.higher(e.s);
                if (left != null && right != null && Math.abs(left.index - right.index) > 1 && left.intersect(right)) {
                    ensure(false, "Segments " + (left.index + 1) + " and " + (right.index + 1) + " intersect");
                }
                segs.remove(e.s);
            }
        }
        
        inf.close();
    }
    
    double curY;

    class Event implements Comparable<Event> {
        int type;
        int y;
        Segment s;

        Event(int type, int y, Segment s) {
            this.type = type;
            this.y = y;
            this.s = s;
        }

        public int compareTo(Event o) {
            if (y < o.y) {
                return -1;
            } else if (y > o.y) {
                return 1;
            } else if (type != o.type) {
                return type - o.type;
            } else {
                return s.index - o.s.index;
            }
        }
    }
    
    class Segment {
        int index;
        int x1, y1, x2, y2;
        
        boolean intersect(Segment s) {
            return segmentsIntersect(x1, y1, x2, y2, s.x1, s.y1, s.x2, s.y2);
        }
        
        double xAt(double y) {
            return x1 + (x2 - x1) * (y - y1) / (y2 - y1);
        }

        Segment(int index, int x1, int y1, int x2, int y2) {
            this.index = index;
            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
        }
    }

    final static double EPS = 1e-9;
    
    class Cmp implements Comparator<Segment> {
        public int compare(Segment o1, Segment o2) {
            double x1 = o1.xAt(curY);
            double x2 = o2.xAt(curY);
            if (x1 < x2 - EPS) {
                return -1;
            } else if (x1 > x2 + EPS) {
                return 1;
            } else {
                double xnext1 = o1.xAt(curY + 1);
                double xnext2 = o2.xAt(curY + 1);
                if (xnext1 < xnext2 - EPS) {
                    return -1;
                } else if (xnext1 > xnext2 + EPS) {
                    return 1;
                } else {
                    return 0;
                }
            }
        }
    }

    boolean segmentsIntersect(long x1, long y1, long x2, long y2, long x3, long y3, long x4, long y4) {
        long a1 = y1 - y2;
        long b1 = x2 - x1;
        long c1 = -(a1 * x1 + b1 * y1);
        long a2 = y3 - y4;
        long b2 = x4 - x3;
        long c2 = -(a2 * x3 + b2 * y3);

        if (a1 * b2 == a2 * b1) {
            if (a1 * x3 + b1 * y3 + c1 == 0 && a1 * x4 + b1 * y4 + c1 == 0 && a2 * x1 + b2 * y1 + c2 == 0 && a2 * x2 + b2 * y2 + c2 == 0) {
                long minx = Math.max(Math.min(x1, x2), Math.min(x3, x4));
                long maxx = Math.min(Math.max(x1, x2), Math.max(x3, x4));
                long miny = Math.max(Math.min(y1, y2), Math.min(y3, y4));
                long maxy = Math.min(Math.max(y1, y2), Math.max(y3, y4));
                if (minx > maxx || miny > maxy) {
                    return false;
                }
                return true;
            } else {
                return false;
            }
        } else {
            long s13 = a1 * x3 + b1 * y3 + c1;
            long s14 = a1 * x4 + b1 * y4 + c1;
            if (s13 > 0 && s14 > 0 || s13 < 0 && s14 < 0) {
                return false;
            }
            long s21 = a2 * x1 + b2 * y1 + c2;
            long s22 = a2 * x2 + b2 * y2 + c2;
            if (s21 > 0 && s22 > 0 || s21 < 0 && s22 < 0) {
                return false;
            }
            return true;
        }
    }

    public static void main(String[] args) {
        new ValidateFastIncomplete().run();
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
            ensure(pos == line.length(),  "Extra characters on line " + lineNo);
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
            ensure(line.length() > 0,  "Empty line " + lineNo);
            if (pos == 0)
                ensure(line.charAt(0) > ' ',  "Line " + lineNo + " starts with whitespace");
            else {
                ensure(pos < line.length(),  "Line " + lineNo + " is over");
                ensure(line.charAt(pos) == ' ',  "Wrong whitespace on line " + lineNo);
                pos++;
                ensure(pos < line.length(),  "Line " + lineNo + " is over");
                ensure(line.charAt(0) > ' ',  "Line " + lineNo + " has double whitespace");
            }
            StringBuilder sb = new StringBuilder();
            while (pos < line.length() && line.charAt(pos) > ' ')
                sb.append(line.charAt(pos++));
            return sb.toString();
        }

        public int nextInt() {
            String s = next();
            ensure(s.length() == 1 || s.charAt(0) != '0',  "Extra leading zero in number " + s + " on line " + lineNo);
            ensure(s.charAt(0) != '+',  "Extra leading '+' in number " + s + " on line " + lineNo);
            try {
                return Integer.parseInt(s);
            } catch (NumberFormatException e) {
                throw new AssertionError("Malformed number " + s + " on line " + lineNo);
            }
        }

        public double nextDouble() {
            String s = next();
            ensure(s.length() == 1 || s.startsWith("0.") || s.charAt(0) != '0',  "Extra leading zero in number " + s + " on line " + lineNo);
            ensure(s.charAt(0) != '+',  "Extra leading '+' in number " + s + " on line " + lineNo);
            try {
                return Double.parseDouble(s);
            } catch (NumberFormatException e) {
                throw new AssertionError("Malformed number " + s + " on line " + lineNo);
            }
        }
    }

    void ensure(boolean b, String message) {
        if (!b) {
            throw new AssertionError(message);
        }
    }

    void ensureLimits(int n, int from, int to, String name) {
        ensure(from <= n && n <= to, name + " must be from " + from + " to " + to);
    }

}