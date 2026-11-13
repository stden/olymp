import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int t = inf.nextInt();
		for (int i = 0; i < t; ++i) {
			long cont = ouf.nextLong();
			long jury = ans.nextLong();
			if (cont != jury)
				return new Outcome(Type.WA, "Test " + (i + 1) + " - expected: " + jury + ", found: " + cont);
		}
		return new Outcome(Type.OK, "" + t + " tests");
	}

}