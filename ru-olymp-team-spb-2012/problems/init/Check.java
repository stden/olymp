import java.util.*;

import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int pa = ouf.nextInt();
		int ja = ans.nextInt();
		if (pa != ja) {
			return new Outcome(Type.WA, "Expected: " + ja + ", found: " + pa);
		}
		return new Outcome(Type.OK, "" + ja);
	}
}