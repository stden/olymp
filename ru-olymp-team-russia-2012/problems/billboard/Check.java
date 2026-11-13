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
            return new Outcome(WA, String.format("expected %d, found: %d", ja, pa));
        }

        return new Outcome(OK, String.format("answer is %d", ja));
    }
}
