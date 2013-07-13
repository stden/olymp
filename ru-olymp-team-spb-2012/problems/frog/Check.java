import java.util.*;

import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		long an = ans.nextLong();
		long out = ouf.nextLong();
		if (an != out) return new Outcome(Type.WA, "Expected: " + an + ", found: " + out);
		return new Outcome(Type.OK, "");
	}
}
