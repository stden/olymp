// Задача "Газон"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

import java.io.*;
import java.util.*;

public class lawn_vu_slow {
	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new File("lawn.in"));
		PrintWriter out = new PrintWriter(new File("lawn.out"));

		int x1 = in.nextInt(), y1 = in.nextInt();
		int x2 = in.nextInt(), y2 = in.nextInt();
		long x3 = in.nextInt(), y3 = in.nextInt(), r = in.nextInt();

		if (x1 > x2) {
			int t = x1;
			x1 = x2;
			x2 = t;
			t = y1;
			y1 = y2;
			y2 = t;
		}

		long ans = 0;		
		for (long x = Math.max(x1, x3 - r); x <= Math.min(x2, x3 + r); x++) {
			for (long y = Math.max(y1, y3 - r); y <= Math.min(y2, y3 + r); y++) {
				if (Math.hypot(x3 - x, y3 - y) <= r)
					ans++;
			}
		}

		out.println(ans);

		in.close();
		out.close();
	}
}