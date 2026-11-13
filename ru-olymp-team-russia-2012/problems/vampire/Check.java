import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;
import static ru.ifmo.testlib.Outcome.Type.*;

import java.math.BigInteger;
import java.util.*;

public class Check implements ru.ifmo.testlib.Checker {

	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int k = inf.nextInt();
		int n = inf.nextInt();

		HashSet<BigInteger> used = new HashSet<BigInteger>();
		for (int i = 0; i < k; i++) {
			String line = ouf.nextLine();
			String data[] = line.split("=");
			if (data.length != 2) {
				return new Outcome(PE, "No = or several =-s");
			}
			if (!isNumber(data[0])) {
				return new Outcome(PE, data[0] + " instead of first number");
			}
			String data2[] = data[1].split("x");
			if (data2.length != 2) {
				return new Outcome(PE, "No x-s or several x-s");
			}
			if (!isNumber(data2[0])) {
				return new Outcome(PE, data2[0] + " instead of fang 1");
			}
			if (!isNumber(data2[1])) {
				return new Outcome(PE, data2[1] + " instead of fang 2");
			}

			BigInteger vampire = new BigInteger(data[0]);
			BigInteger fang1 = new BigInteger(data2[0]);
			BigInteger fang2 = new BigInteger(data2[1]);
			String error = isVampire(vampire, fang1, fang2, n);
			if (error != null) {
				return new Outcome(WA, "Line " + (i + 1) + ". Number "
						+ vampire + " is not a vampire number - " + error);
			}

			if (used.contains(vampire)) {
				return new Outcome(WA, "Line " + (i + 1) + ". Number "
						+ vampire + " already used");
			}

			used.add(vampire);
		}

		return new Outcome(OK, k + " numbers");
	}

	private boolean isNumber(String string) {
		for (int i = 0; i < string.length(); i++) {
			char c = string.charAt(i);
			if (c < '0' || c > '9') {
				return false;
			}
			if (i == 0 && c == '0') {
				return false;
			}
		}
		return true;
	}

	private String isVampire(BigInteger vampire, BigInteger fang1,
			BigInteger fang2, int n) {
		if (!vampire.equals(fang1.multiply(fang2))) {
			return "product is wrong";
		}
		if (vampire.toString().length() != n) {
			return "number length is wrong";
		}
		if (fang1.toString().length() != n / 2) {
			return "fang 1 length is wrong";
		}
		if (fang2.toString().length() != n / 2) {
			return "fang 2 length is wrong";
		}

		int cnt1[] = digitize(vampire.toString());
		int cnt2[] = digitize(fang1.toString());
		int cnt3[] = digitize(fang2.toString());
		for (int i = 0; i < 10; i++) {
			if (cnt1[i] != cnt2[i] + cnt3[i]) {
				return "digit " + i + " count is wrong";
			}
		}
		return null;
	}

	private int[] digitize(String string) {
		int result[] = new int[10];
		for (int i = 0; i < string.length(); i++) {
			result[string.charAt(i) - '0']++;
		}
		return result;
	}
}
