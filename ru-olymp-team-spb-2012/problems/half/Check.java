import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;
import static ru.ifmo.testlib.Outcome.Type.*;
import java.util.*;

public class Check implements ru.ifmo.testlib.Checker {

    @Override
    public Outcome test(InStream inf, InStream ouf, InStream ans) {
    	int ja = ans.nextInt();
		int pa = ouf.nextInt();

		if (ja != pa) {
			return new Outcome(WA, String.format("Expected: %d, found: %d", ja, pa));
		}

		for (int i = 0; i < ja; i++) {
			double jv = ans.nextDouble();
			double pv = ouf.nextDouble();

			if (Math.abs(jv - pv) > 0.1) {
				return new Outcome(WA, String.format("Number %d - expected: %f, found: %f", i + 1, jv, pv));
			}
		}

		return new Outcome(OK, String.format("%d variants", ja));
    }
}
