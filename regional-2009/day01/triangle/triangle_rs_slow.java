import java.io.*;
import java.util.*;

/**
 * @author Roman V Satyukov
 */
public class triangle_rs_slow implements Runnable {
    private final String problemID = getClass().getName().split("_")[0].toLowerCase();
    private BufferedReader in;
    private PrintWriter out;

    private void solve() throws IOException {
    	int n = Integer.parseInt(in.readLine());
    	long[] x = new long[n];
    	long[] y = new long[n];
    	for (int i = 0; i < n; i++) {
    		StringTokenizer st = new StringTokenizer(in.readLine());
    		x[i] = Integer.parseInt(st.nextToken());
    		y[i] = Integer.parseInt(st.nextToken());
    	}
    	long answer = 0;
    	for (int i = 0; i < n; i++) {
    		for (int j = 0; j < n; j++) {
    			if (i == j) {
    				continue;
    			}
    			long dx1 = x[j] - x[i];
    			long dy1 = y[j] - y[i];
    			long length1 = dx1 * dx1 + dy1 * dy1;
    			for (int k = j + 1; k < n; k++) {
    				if (i == k) {
    					continue;
    				}
        			long dx2 = x[k] - x[i];
        			long dy2 = y[k] - y[i];
        			long length2 = dx2 * dx2 + dy2 * dy2;
        			if (length1 == length2) {
        				if (dx1 + dx2 != 0 || dy1 + dy2 != 0) {
        					answer++;
        				}
        			}
    			}
    		}
    	}
    	out.println(answer);
    }

	public void run() {
        try {
            in = new BufferedReader(new FileReader(new File(problemID + ".in")));
            out = new PrintWriter(new File(problemID + ".out"));
            solve();
            in.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public static void main(String[] args) {
        new Thread(new triangle_rs_slow()).start();
    }
}
