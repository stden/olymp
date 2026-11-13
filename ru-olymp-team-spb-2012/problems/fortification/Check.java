import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

/**
 * Compares two files that contain one signed 32-bit integer number. Trailing and leading space
 * characters are allowed.
 * 
 * @author niyaz.nigmatullin
 * 
 */
public class Check implements Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int ansP = ouf.nextInt();
		int ansJ = ans.nextInt();
		if (ansP != ansJ) {
			return new Outcome(Type.WA, "Numbers differ - expected: \"" + ansJ
					+ "\", found: \"" + ansP + '"');
		}
		return new Outcome(Type.OK, "" + ansP);
	}

}
