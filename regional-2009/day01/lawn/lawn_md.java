import java.io.*;
import java.util.*;

public class lawn_md implements Runnable {
	private static Scanner in;
	private static PrintWriter out;

	public void run() {
		int x1 = in.nextInt();
		int y1 = in.nextInt();
		int x2 = in.nextInt();
		int y2 = in.nextInt();
		int x3 = in.nextInt();
		int y3 = in.nextInt();
		int r = in.nextInt();
		long ans = 0;
		for (int y = y1; y <= y2; y++) {
			if (Math.abs(y - y3) > r)
				continue;
			int d = (int) Math.sqrt(r * (long) r - (y - y3) * (long) (y - y3));
			int xLo = Math.max(x1, x3 - d);
			int xHi = Math.min(x2, x3 + d);
			ans += Math.max(xHi - xLo + 1, 0);
		}
		out.println(ans);
	}

	public static void main(String[] args) throws IOException, InterruptedException {
		Locale.setDefault(Locale.US);
		in = new Scanner(new FileReader("lawn.in"));
		out = new PrintWriter("lawn.out");
		Thread thread = new Thread(new lawn_md());
		thread.start();
		thread.join();
		in.close();
		out.close();
	}
}
