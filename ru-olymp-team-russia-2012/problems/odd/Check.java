import ru.ifmo.testlib.*;
import ru.ifmo.testlib.Outcome.Type;

public class Check implements Checker {
	@Override
	public Outcome test(InStream inf, InStream ouf, InStream ans) {
		int n = inf.nextInt();
		int m = inf.nextInt();
		int[] from = new int[m];
		int[] to = new int[m];
		for (int i = 0; i < m; i++) {
			from[i] = inf.nextInt() - 1;
			to[i] = inf.nextInt() - 1;
		}
		int kP = ouf.nextInt();
		int kJ = ans.nextInt();
		if (kP == -1 && kJ >= 0) {
			return new Outcome(Type.WA,
					"Contestant didn't find the solution, but it exists");
		}
		if (kP == -1 && kJ == -1) {
			return new Outcome(Type.OK, "No solution");
		}
		boolean[] used = new boolean[m];
		boolean[] odd = new boolean[n];
		for (int i = 0; i < kP; i++) {
			int j = ouf.nextInt();
			if (j < 1 || j > m) {
				throw new Outcome(Type.WA, j + " is not in range [1, " + m
						+ "] at position " + (i + 1));
			}
			--j;
			if (used[j]) {
				return new Outcome(Type.WA, "edge #" + (j + 1) + " used twice");
			}
			used[j] = true;
			odd[from[j]] ^= true;
			odd[to[j]] ^= true;
		}
		for (int i = 0; i < n; i++) {
			if (!odd[i]) {
				return new Outcome(Type.WA, "the degree of vertex #" + (i + 1)
						+ " isn't odd");
			}
		}
		if (kJ == -1) {
			return new Outcome(Type.FAIL,
					"Contestant has found correct solution, but jury thinks, it didn't exist");
		}
		return new Outcome(Type.OK, "OK " + kP + " edges used");
	}
}
