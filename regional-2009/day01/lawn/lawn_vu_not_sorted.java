// Задача "Газон"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

// Решение, не сортирующее координаты углов.
// Считаю, что следует или оговорить это в условии задачи, 
// или решение должно получать баллов 80

import java.io.*;
import java.util.*;

public class lawn_vu_not_sorted {
	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new File("lawn.in"));
		PrintWriter out = new PrintWriter(new File("lawn.out"));

		int x1 = in.nextInt(), y1 = in.nextInt();
		int x2 = in.nextInt(), y2 = in.nextInt();
		long x3 = in.nextInt(), y3 = in.nextInt(), r = in.nextInt();

		long ans = 0;		
		for (long x = Math.max(x1, x3 - r); x <= Math.min(x2, x3 + r); x++) {
			long l = Math.round(Math.floor(Math.sqrt(r * r - (x3 - x) * (x3 - x))));

			ans += Math.max(0, Math.min(y2, y3 + l) - Math.max(y3 - l, y1) + 1);
		}

		out.println(ans);

		in.close();
		out.close();
	}
}