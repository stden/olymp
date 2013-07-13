import java.util.*;

import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	double eps = 1.1e-6;
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		double pa = ouf.nextDouble();
		double ja = ans.nextDouble();
		if ((Math.abs(pa-ja) > eps) && !((pa/ja > 1 - eps) && (pa/ja < 1 + eps))) {
			return new Outcome(Type.WA, "Expected: " + ja + ", found: " + pa);
		}
		return new Outcome(Type.OK, "" + ja);
	}
}