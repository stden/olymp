import java.util.*;

import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
			
		String an = ans.nextLine();
		String out = ouf.nextLine();
		if (!an.equals("YES") && !an.equals("NO")) {
			return new Outcome(Type.FAIL, "Fail. Jury have PE");
		}
		if (!out.equals("YES") && !out.equals("NO")) {
			return new Outcome(Type.PE, "YES or NO expected. Found: " + out);
		}
		
		if (!an.equals(out)) {
			return new Outcome(Type.WA, "Expected: " + an + ", found: " + out);
	    }

		return new Outcome(Type.OK, "");
	}
}