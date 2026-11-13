import java.io.*;
import java.util.*;
import java.math.*;

public class function_ab implements Runnable {
    public static void main(String[] args) {
	new Thread(new function_ab()).start();
    }

    @Override
    public void run() {
	try {
	    br = new BufferedReader(new FileReader("function.in"));
	    out = new PrintWriter("function.out");
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
    
    final int MAX_N = 100000;
    
    private void solve() throws IOException {
	int n = nextInt();
	myAssert(1 <= n && n <= MAX_N);
	char[] s = br.readLine().toCharArray();
	myAssert(s.length == 4);
	int[][] mt = new int[2][2];
	for (int i = 0; i < 2; ++i) {
	    for (int j = 0; j < 2; ++j) {
		char tc = s[i * 2 + j];
		myAssert('0' <= tc && tc <= '1');
		mt[i][j] = tc - '0'; 
	    }
	}
	
	int[][] d = new int[n][2];
	for (int[] t : d) {
	    Arrays.fill(t, -1);
	}
	int[][] p = new int[n][2];
	int[][] c = new int[n][2];
	d[0][0] = 0;
	d[0][1] = 1;
	c[0][0] = 0;
	c[0][1] = 1;
	
	Arrays.fill(p[0], -1);
	for (int i = 0; i < n - 1; ++i) {
	    for (int u = 0; u < 2; ++u) {
		for (int v = 0; v < 2; ++v) {
		    int k = mt[u][v];
		    int tans = d[i][u] + v;
		    if (tans > d[i + 1][k]) {
			d[i + 1][k] = tans;
			p[i + 1][k] = u;
			c[i + 1][k] = v;
		    }
		}
	    }
	}
	
	if (d[n - 1][1] == -1) {
	    out.println("Impossible");
	} else {
	    char[] ans = new char[n];
	    int x = 1;
	    for (int i = n - 1; i >= 0; --i) {
		ans[i] = (char)('0' + c[i][x]);
		x = p[i][x]; 
	    }
	    out.println(new String(ans));
	}
    }

}
