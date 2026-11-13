import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;
import static ru.ifmo.testlib.Outcome.Type.*;
import java.util.*;

public class Check implements ru.ifmo.testlib.Checker {

    @Override
    public Outcome test(InStream inf, InStream ouf, InStream ans) {
        double jv = ans.nextDouble();
        double pv = ouf.nextDouble();

        if (Math.abs(jv - pv) / Math.max(jv, 1) > 2e-6) {
            return new Outcome(WA, String.format("expected %.10f, found: %.10f", jv, pv));
        }

        return new Outcome(OK, String.format("answer is %.10f", jv));
    }
}
