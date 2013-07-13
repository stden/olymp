import java.io.*;
import java.util.*;
import java.math.*;

final class LongSub {
	public static void main(String[] argv) throws IOException {
		Reader reader = new FileReader("sub.in");
		Scanner in = new Scanner(reader);
		BigInteger a = in.nextBigInteger();
		BigInteger b = in.nextBigInteger();
		in.close();

		PrintWriter out = new PrintWriter("sub.out");
		out.println(a.subtract(b));
		out.close();
	}
}
