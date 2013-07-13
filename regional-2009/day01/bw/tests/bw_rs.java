import java.io.*;
import java.util.*;

/**
 * @author Roman V Satyukov
 */
public class bw_rs implements Runnable {
    private final String problemID = getClass().getName().split("_")[0].toLowerCase();
    private BufferedReader in;
    private PrintWriter out;

    private void check(boolean expr, String message) {
        if (!expr) {
            throw new AssertionError(message);
        }
    }
    
    private int[][] readImage(int w, int h) throws IOException {
    	int[][] first = new int[h][w];
    	for (int i = 0; i < h; i++) {
    		String current = in.readLine();
    		check(current.length() == w, "First image is not correct");
    		for (int j = 0; j < w; j++) {
    			char ch = current.charAt(j);
    			check(ch == '0' || ch == '1', "Image doesn't consist only of 0 and 1");
    			first[i][j] = ch - '0';
    		}
    	}
    	return first;
    }
    
    private int[][] readOperation() throws IOException {
    	String line = in.readLine();
    	check(line.length() == 4, "Operation description length is not 4");
    	for (int i = 0; i < 4; i++) {
    		check(line.charAt(i) == '0' || line.charAt(i) == '1', "Incorrect operation description");
    	}
    	int[][] op = new int[2][2];
    	op[0][0] = line.charAt(0) - '0';
    	op[0][1] = line.charAt(1) - '0';
    	op[1][0] = line.charAt(2) - '0';
    	op[1][1] = line.charAt(3) - '0';
		return op;
	}

    private void solve() throws IOException {
    	StringTokenizer st = new StringTokenizer(in.readLine());
    	int w = Integer.parseInt(st.nextToken());
    	int h = Integer.parseInt(st.nextToken());
    	check((1 <= w) && (w <= 100), "w is not in [1..100]");
    	check((1 <= h) && (h <= 100), "h is not in [1..100]");
    	int[][] first = readImage(w, h);
    	int[][] second = readImage(w, h);
    	int[][] operation = readOperation();
    	for (int i = 0; i < h; i++) {
    		for (int j = 0; j < w; j++) {
    			out.print(operation[first[i][j]][second[i][j]]);
    		}
    		out.println();
    	}
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
        new Thread(new bw_rs()).start();
    }
}
