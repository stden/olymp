import java.io.*;
import java.util.*;
import java.math.*;

public class triangle_ab implements Runnable {
    public static void main(String[] args) {
	new Thread(new triangle_ab()).start();
    }

    @Override
    public void run() {
	try {
	    br = new BufferedReader(new FileReader("triangle.in"));
	    out = new PrintWriter("triangle.out");
	    solve();
	    out.close();
	} catch (Throwable e) {
	    e.printStackTrace();
	    System.exit(-1);
	}
    }

    BufferedReader br;
    StringTokenizer st;
    PrintWriter out;
    boolean eof = true;

    String cnv(String a) {
	return a.equals("") ? "0" : a;
    }

    String nextToken() {
	while (st == null || !st.hasMoreElements()) {
	    try {
		st = new StringTokenizer(br.readLine());
	    } catch (Exception e) {
		eof = true;
		return "";
	    }
	}
	return st.nextToken();
    }

    int nextInt() {
	return Integer.parseInt(cnv(nextToken()));
    }

    double nextDouble() {
	return Double.parseDouble(cnv(nextToken()));
    }

    void myAssert(boolean e) { 
	if (!e) {
	    throw new Error();
	}
    }
    
    final double MIN_FREQ = 30;
    final double MAX_FREQ = 4000;
    
    private void solve() throws IOException {
	int n = nextInt();
	myAssert(2 <= n && n <= 1000);
	
	double l = MIN_FREQ;
	double r = MAX_FREQ;
	double pf = 0;
	for (int i = 0; i < n; ++i) {
	    double f = nextDouble();
	    myAssert(MIN_FREQ <= f && f <= MAX_FREQ);
	    if (i > 0) {
		String s = nextToken();
		myAssert(s.equals("closer") || s.equals("further"));
		double m = (f + pf) / 2;
		if ((pf < f) ^ (s.equals("closer"))) {
		    r = Math.min(r, m);
		} else {
		    l = Math.max(l, m);
		}
		
	    }
	    pf = f;
	}
	out.println(l + " " + r);
    }

}
