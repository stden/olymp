import java.util.*;
import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int n = inf.nextInt();
		for (int zz = 0; zz< n; zz++) {
		HashSet<String> correct = new HashSet<String>();
		correct.add("Yes");
		correct.add("No");
		String s = inf.nextToken();
		String t = inf.nextToken();
		String jAns = ans.nextToken();
		ans.nextLine();
		if (!correct.contains(jAns)) {
			return new Outcome(Type.FAIL, jAns
					+ " instead of Yes or No at jury's output");
		}
		if (jAns.equals("Yes")) {
			ans.nextLine();
		}
		String pAns = ouf.nextToken();
		if (!correct.contains(pAns)) {
			return new Outcome(Type.PE, s + " instead of Yes or No at output");
		}

		if (pAns.equals("Yes")) {
			ouf.nextLine();
			ArrayList<Integer> process = new ArrayList<Integer>();
			while (!ouf.seekEoLn()) {
				process.add(ouf.nextInt());
			}
			for (int x : process) {
				if ((x != 0) && (x != 1)) {
					return new Outcome(Type.WA, x
							+ " instead of zero or one at sertificate!");
				}
			}
			String resS;
			try {
				resS = process(s, process);
			} catch (AssertionError e) {
				return new Outcome(Type.WA, "Not enough actions at sertificate");
			} catch (IndexOutOfBoundsException e) {
				return new Outcome(Type.WA, "Extra actions at sertificate");
			}
			if (!resS.equals(t)) {
				return new Outcome(Type.WA,
						"Result of processing doesn't match");
			}
		}
		if (!jAns.equals(pAns)) {
			
		
		if (jAns.equals("Yes")) {
			return new Outcome(Type.WA, "Contestant hasn't found the solution");
		}
		return new Outcome(Type.FAIL,
				"Contestant has found the solution, but jury hasn't");
		}
		}
	return new Outcome(Type.OK, "Ok");

	}

	private String process(String s, ArrayList<Integer> process) {
		if (s.length() % 2 == 1) {
			if (process.size() != 0) {
				throw new IndexOutOfBoundsException(s + " "
						+ process.toString());
			}
			return s;
		}
		if (process.size() == 0) {
			// System.err.println(s);
			throw new AssertionError(s);
		}
		String left = s.substring(0, s.length() / 2);
		String right = s.substring(s.length() / 2);
		ArrayList<Integer> lProcess = new ArrayList<Integer>(process.subList(0,
				process.size() / 2));
		ArrayList<Integer> rProcess = new ArrayList<Integer>(process.subList(
				process.size() / 2, process.size() - 1));
		left = process(left, lProcess);
		right = process(right, rProcess);
		if (process.get(process.size() - 1) == 1)
			return right + left;
		else
			return left + right;
	}
}
