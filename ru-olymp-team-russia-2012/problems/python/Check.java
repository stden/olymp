import ru.ifmo.testlib.Checker;
import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;

/**
 * User: altimin
 * Date: 11/18/12
 * Time: 1:09 AM
 */
public class Check implements Checker {
    @Override
    public Outcome test(InStream inf, InStream ouf, InStream ans) {
        int contestantMinAnswer = ouf.nextInt();
        int contestantMaxAnswer = ouf.nextInt();
        int juryMinAnswer = ans.nextInt();
        int juryMaxAnswer = ans.nextInt();
        if (contestantMaxAnswer != juryMaxAnswer) {
            return new Outcome(Outcome.Type.WA,
                    String.format("incorrect max value: expected %d, got %d", juryMaxAnswer, contestantMaxAnswer));
        }
        if (contestantMinAnswer != juryMinAnswer) {
            return new Outcome(Outcome.Type.WA,
                    String.format("incorrect min value: expected %d, got %d", juryMinAnswer, contestantMinAnswer));
        }
        return new Outcome(Outcome.Type.OK, String.format("min=%d, max=%d", juryMinAnswer, juryMaxAnswer));
    }
}
