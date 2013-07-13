import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int m = inf.nextInt();
		int n = inf.nextInt();

		long ja = ans.nextLong();
		long pa = ouf.nextLong();
		if (ja != pa) {
			return new Outcome(Type.WA, "Wrong nuber of days: " + pa + " instead of " + ja);
		}

		for (int i = 0; i <  m; ++i) {
			for (int j = 0; j < n; ++j) {
    			long cont = ouf.nextLong();
    			long jury = ans.nextLong();
    			if (cont != jury)
    				return new Outcome(Type.WA, "Wrong tree height at (" + i + ", " + j + ") : " + cont + " instead of " + jury);
    		}
		}
		return new Outcome(Type.OK, "");
	}

}