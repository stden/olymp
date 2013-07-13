// Задача "Неправильное сложение"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Федор Царев, tsarev@rain.ifmo.ru
// Автор решения: Федор Царев, tsarev@rain.ifmo.ru

import java.io.*;
import java.util.*;

public class addition_ft implements Runnable {

	private Scanner in;
	private PrintWriter out;
	String fname = "addition";

	private void myAssert(boolean e, String message) {
		if (!e) {
			throw new Error("Assertion failure!!! " + message);
		}
	}                               

	String add(String a, String b) {
		String res = "";
		while (a.length() < b.length()) {
			a = "0" + a;
		}
		while (b.length() < a.length()) {
			b = "0" + b;
		}
		int n = a.length();
		for (int i = n - 1; i >= 0; i--) {
			int x = a.charAt(i) - '0';
			int y = b.charAt(i) - '0';
			res = (x + y) + res;
		}
		return res;
	}

	String[] s;
	HashSet<String> set;
	boolean[] w;
	int[] p;

	void go(int pos) {
		if (pos == 3) {
			set.add(add(s[p[0]], add(s[p[1]], s[p[2]])));
			set.add(add(add(s[p[0]], s[p[1]]), s[p[2]]));
			return;
		}
		for (int i = 0; i < 3; i++) {
			if (!w[i]) {
				p[pos] = i;
				w[i] = true;
				go(pos + 1);
				w[i] = false;
			}
		}
	}

	public void solve() {
		int a = in.nextInt();
		int b = in.nextInt();
		int c = in.nextInt();
		myAssert(1 <= a && a <= 1000000, "a is out of range: " + a);
		myAssert(1 <= b && b <= 1000000, "b is out of range: " + b);
		myAssert(1 <= c && c <= 1000000, "c is out of range: " + c);
		String sa = Integer.toString(a);
		String sb = Integer.toString(b);
		String sc = Integer.toString(c);
		s = new String[] {sa, sb, sc};
		set = new HashSet<String>();
		w = new boolean[3];
		p = new int[3];
		go(0);
		ArrayList<Long> list = new ArrayList<Long>();
		for (String ss : set) {
			list.add(Long.parseLong(ss));
		}
		Collections.sort(list);
		if (list.size() == 1) {
			out.println("NO");
		} else {
			out.println("YES");
		}
		for (long x : list) {
			out.println(x);
		}
	}

	public void run() {
		try {
			solve();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		} finally {
			out.close();
		}		
	}

	public addition_ft() {
		try {
			in = new Scanner(new File(fname + ".in"));
			out = new PrintWriter(new File(fname + ".out"));
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}


	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Thread(new addition_ft()).start();
	}

}                       