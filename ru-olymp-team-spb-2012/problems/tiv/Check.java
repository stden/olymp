import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;

import java.util.*;
import java.io.*;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		String jAns = ans.nextLine().toUpperCase();
		String pAns = ouf.nextLine().toUpperCase();

		int n = inf.nextInt();
		String[] num = new String[n];

		for (int i = 0; i < n; i++)
			num[i] = inf.nextToken();
		
		if (!pAns.equals("YES") && !pAns.equals("NO"))
			return new Outcome(Type.PE, "'YES' or 'NO' expected, '" + pAns + "' found" );
		
        if (jAns.equals("YES") && pAns.equals("NO"))
        	return new Outcome(Type.WA, "Jury has solution");
        
        if (jAns.equals("NO") && pAns.equals("YES") && check(ouf, num))
        	return new Outcome(Type.FAIL, "Jury didn't find solution, but participant found solution!");
        
        if (pAns.equals("YES") && check(ouf, num))
        	return new Outcome(Type.OK, "Ok!");

		
		return new Outcome(Type.OK, "Ok!");
	}

	public boolean check(InStream ouf, String[] num) {
		int[] ans = new int[10];
		for (int i = 0; i < 10; i++)
			ans[i] = ouf.nextInt();

		boolean[] used = new boolean[10];
		for (int i = 0; i < 10; i++) {
			if (ans[i] < 0 || ans[i] > 9)
				throw new Outcome(Type.WA, "Incorrect digit!");
			if (used[ans[i]])
				throw new Outcome(Type.WA,
						"Different letters correspond to the same digit.");
			used[ans[i]] = true;
		}
		int[] ch = new int[num.length];

		for (int i = 0; i < num.length; i++) {
			if (num[i].length() != 1)
				if (ans[num[i].charAt(0) - 'a'] == 0) {
					throw new Outcome(Type.WA, "Leading zero!");
				}

			for (int j = 0; j < num[i].length(); j++)
				ch[i] = ch[i] * 10 + ans[num[i].charAt(j) - 'a'];
		}

		for (int i = 1; i < num.length; i++)
			if (ch[i - 1] >= ch[i])
				throw new Outcome(Type.WA, "Incorrect answer!");
		return true;
	}

}
