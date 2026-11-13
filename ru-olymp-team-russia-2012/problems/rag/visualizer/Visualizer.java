import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Locale;
import java.util.StringTokenizer;

public class Visualizer {

	static class Point {
		long x, y;

		public Point(long x1, long y1) {
			x = x1;
			y = y1;
		}
	}

	static long gy = 0;

	static class Segment implements Comparable<Segment> {
		Point st;
		Point en;

		public Segment(Point st1, Point en1) {
			if (en1.y > st1.y) {
				st = en1;
				en = st1;
			} else {
				st = st1;
				en = en1;
			}
		}

		public int compareTo(Segment o) {
			long a = en.y - st.y;
			long b = st.x - en.x;
			long c = -a * st.x - b * st.y;

			long a1 = o.en.y - o.st.y;
			long b1 = o.st.x - o.en.x;
			long c1 = -a1 * o.st.x - b1 * o.st.y;
			return Long.signum(a1 * (-b * gy - c) - (-b1 * gy - c1) * a);
		}

		double inter(int y) {
			long a = en.y - st.y;
			long b = st.x - en.x;
			long c = -a * st.x - b * st.y;
			return 1.0 * (-b * y - c) / a;
		}
	}

	static void visualiseOneTestCase(int caseId, PrintWriter out, MyScanner in)
			throws IOException {
		int w = 2 * in.nextInt();
		int h = 2 * in.nextInt();
		int n = in.nextInt();
		Point[] a = new Point[n];
		Segment[] x = new Segment[n - 1];
		HashSet<Integer> was = new HashSet<Integer>();
		ArrayList<Integer> arr = new ArrayList<Integer>();
		for (int i = 0; i < n; i++) {
			a[i] = new Point(2 * in.nextInt(), 2 * in.nextInt());
			if (i > 0) {
				x[i - 1] = new Segment(a[i], a[i - 1]);
			}
			if (!was.contains((int) a[i].y)) {
				arr.add((int) a[i].y);
				was.add((int) a[i].y);
			}
		}
		out.println("beginfig(" + caseId + ");");
		out.println("    u := 15cm;");
		Collections.sort(arr);
		double s = 0;
		for (int i = 0; i < arr.size() - 1; i++) {
			gy = (arr.get(i) + arr.get(i + 1)) / 2;
			Segment opt = null;
			int k = 0;
			for (int j = 0; j < n - 1; j++) {
				if (x[j].st.y > gy && x[j].en.y < gy) {
					if (opt == null || opt.compareTo(x[j]) < 0) {
						opt = x[j];
					}
					k++;
				}
			}
			if (k % 2 == 1) {
				s += Math.abs((arr.get(i) - arr.get(i + 1))
						* (w - opt.inter(arr.get(i)) + w - opt.inter(arr
								.get(i + 1))) / 2);
				double x1 = opt.inter(arr.get(i));
				double x2 = opt.inter(arr.get(i + 1));
				double y1 = arr.get(i);
				double y2 = arr.get(i + 1);
				String outp = String
						.format("    fill (%6f * u,%6f * u)-- \n (%6f * u,%6f * u)--(%6f * u,%6f *u)--(%6f * u,%6f * u)--cycle withcolor .8 white;",
								x1 / w, y1 / h, 1.0, y1 / h, 1.0, y2 / h, x2
										/ w, y2 / h);
				out.println(outp);
			}
		}
		out.println(String.format(
				" fill (%6f * u, %6f * u)--(%6f * u, %6f * u)--(%6f * u, %6f * u)", 1.0,0.0,0.0,0.0,0.0,1.0));
		
		for (int i = 0; i < n; i++) {
			double x1 = a[i].x;
			double y1 = a[i].y;
			String outp = String
					.format("  --(%6f * u,%6f *u)",
							x1 / w, y1 / h);
		    out.println(outp);
		}	
		
		out.println("--cycle withcolor .2 white;");

		out.println(String.format(
				"    draw (%6f * u, %6f * u)--(%6f * u, %6f * u);", 0.0, 0.0,
				0.0, 1.0));
		out.println(String.format(
				"    draw (%6f * u, %6f * u)--(%6f * u, %6f * u);", 0.0, 1.0,
				1.0, 1.0));
		out.println(String.format(
				"    draw (%6f * u, %6f * u)--(%6f * u, %6f * u);", 1.0, 1.0,
				1.0, 0.0));
		out.println(String.format(
				"    draw (%6f * u, %6f * u)--(%6f * u, %6f * u);", 0.0, 0.0,
				1.0, 0.0));

		for (int i = 0; i < n - 1; i++) {
			Point a1 = x[i].st;
			Point b1 = x[i].en;
			double x1 = 1.0 * a1.x / w;
			double y1 = 1.0 * a1.y / h;
			double x2 = 1.0 * b1.x / w;
			double y2 = 1.0 * b1.y / h;
			out.println(String.format(
					"    draw (%6f * u, %6f * u)--(%6f * u, %6f * u);", x1, y1,
					x2, y2));
		}
		out.println("endfig;");
		out.println("%==================================");
		out.println();
	}

	static void visualise(String fname) throws IOException {
		String dir = fname + ".vis";
		File f = new File(dir);
		f.mkdir();
		PrintWriter mp = new PrintWriter(dir + "/rec.mp");
		MyScanner in = new MyScanner(new FileReader(fname));
		int tests = 1;
		for (int i = 1; i <= tests; i++)
			visualiseOneTestCase(i, mp, in);
		mp.println("end;");
		mp.close();

		File answer = new File(fname + ".out");
		if (!answer.exists())
			answer = null;
		if (fname.substring(fname.lastIndexOf('.') + 1, fname.length()).equals(
				"in")) {
			answer = new File(fname.substring(0, fname.lastIndexOf('.'))
					+ ".out");
			if (!answer.exists())
				answer = null;
		}
		BufferedReader ans = null;
		if (answer != null)
			ans = new BufferedReader(new FileReader(answer));

		PrintWriter out = new PrintWriter(dir + "/pics.tex");
		out.println("\\documentclass[11pt,a4paper,oneside]{article}");
		out.println("\\usepackage{graphicx}");
		out.println("\\begin{document}");
		for (int i = 1; i <= tests; i++) {
			String section = "case " + i;
			if (ans != null)
				section += ans.readLine();
			out.println("\\section{" + section + "}");
			out.println("    \\includegraphics{rec." + i + "} \\\\");
			out.println("\\pagebreak");
		}
		out.println("\\end{document}");
		out.close();

	}

	public static void main(String[] args) throws IOException {
		Locale.setDefault(Locale.US);
		visualise(args[0]);
	}

	static class MyScanner {
		BufferedReader br;
		StringTokenizer st;

		MyScanner(Reader r) {
			br = new BufferedReader(r);
		}

		String nextToken() throws IOException {
			while (st == null || !st.hasMoreTokens())
				st = new StringTokenizer(br.readLine());
			return st.nextToken();
		}

		int nextInt() throws IOException {
			return Integer.parseInt(nextToken());
		}
	}

}
