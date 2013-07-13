import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		long cont = ouf.nextInt();
		long jury = ans.nextInt();
		if (jury < 0) return new Outcome(Type.FAIL, "Panic");
		if (cont != jury)
			return new Outcome(Type.WA, "Expected: " + jury + ", found: " + cont);
	
		return new Outcome(Type.OK, "" + jury);
	}

}