import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		long ja = ans.nextLong();
		long pa = ouf.nextLong();
		if (ja != pa) {
			return new Outcome(Type.WA, "Expected: " + ja + ", found: " + pa);
		}
		return new Outcome(Type.OK, "" + ja);
	}

}