import java.io.*;
import java.util.*;

public class Gen {

	static int done = 0;

	static final Random rand = new Random(556668949239L);
	static final int max = 1000000, min = 1000;
	
	static final int[] mediumR = {19191, 271100, 333333, 498754};
	static final int[] bigR = {max, max - 1193, 666679, 996001};
	
	static void print(int a, int b) throws IOException {
		done++;
		System.err.println(done);
		PrintWriter out;
		if (done < 10)
			out = new PrintWriter("../tests/0" + String.valueOf(done));
		else
			out = new PrintWriter("../tests/" + String.valueOf(done));
		double r = (double) a / 1000;
		double l = (double) b / 1000;
		out.println(r + " " + l);
		out.close();
	}
	
	public static void main(String[] args) throws IOException {
		File dir = new File("../tests");
		if (!dir.exists())
			dir.mkdir();
		done = 0;
		//Sample
		print(1000, 2000);
		print(1000, 1710);
		//R = min
		print(min, min);
		print(min, min + 333);
		print(min, 2 * min - 13);
		print(min, 2 * min + 1);
		print(min, max);
		//mediumR
		for (int r : mediumR) {
			print(r, min);
			print(r, min + rand.nextInt(1000));
			print(r, r - rand.nextInt(1000));
			print(r, r + rand.nextInt(1000));
			print(r, min + rand.nextInt(r - min));
			print(r, r + rand.nextInt(r));
			print(r, 2 * r - rand.nextInt(1000));
			print(r, 2 * r);
			print(r, max);
		}
		//bigR
		for (int r : bigR) {
			print(r, min);
			print(r, min + rand.nextInt(1000));
			print(r, r - rand.nextInt(1000));
			print(r, r);
			print(r, min + rand.nextInt(r - min));
			if (max != r) {
				print(r, max);
			}
		}
	}
}
