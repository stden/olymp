import java.util.*;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class heritage_pm_maketable {
    final String TASK_ID = "heritage";
    final String OUT_FILE = TASK_ID + "_pm.dpr";
    final static int NUM_RECTS = 4;
    final static int MAX_SIZE = 100;


    static class Enumeration {
        int[] perm;
        boolean[] equal;

        public Enumeration(int[] perm, boolean[] equal) {
            this.perm = perm.clone();
            this.equal = equal.clone();
        }

        public void Canonize() {
            int[] rectPerm = new int[NUM_RECTS];
            boolean[] rectUsed = new boolean[NUM_RECTS];
            int[] bp = perm.clone();
            rec(0, rectPerm, rectUsed, bp);
            perm = bp;
        }

        private void rec(int num, int[] rectPerm, boolean[] rectUsed, int[] bp) {
            if (num >= NUM_RECTS) {
                process(rectPerm, bp);
                return;
            }

            for (int i = 0; i < NUM_RECTS; ++i)
                if (!rectUsed[i]) {
                    rectUsed[i] = true;
                    rectPerm[num] = i;
                    rec(num + 1, rectPerm, rectUsed, bp);
                    rectUsed[i] = false;
                }
        }

        private void process(int[] rectPerm, int[] bp) {
            for (int endPerm = 0; endPerm <= (1 << NUM_RECTS); ++endPerm) {
                int[] p = new int[2 * NUM_RECTS];
                for (int i = 0; i < 2 * NUM_RECTS; ++i)
                    p[i] = 2 * (rectPerm[i / 2]) + ((i & 1) ^ ((endPerm >> (i / 2)) & 1));
                int[] np = new int[2 * NUM_RECTS];
                for (int i = 0; i < 2 * NUM_RECTS; ++i)
                    np[i] = p[perm[i]];
                int cmp = 0;
                for (int i = 0; i < 2 * NUM_RECTS; ++i)
                    if (np[i] != bp[i]) {
                        cmp = np[i] - bp[i];
                        break;
                    }
                if (cmp < 0) {
                    System.arraycopy(np, 0, bp, 0, 2 * NUM_RECTS);
                }
            }
        }

        public boolean equals(Object o) {
            Enumeration that = (Enumeration) o;

            for (int i = 0; i < 2 * NUM_RECTS; ++i)
                if (perm[i] != that.perm[i] || equal[i] != that.equal[i])
                    return false;

            return true;
        }

        public int hashCode() {
            int result = 0;
            for (int i = 0; i < 2 * NUM_RECTS; ++i)
                result = (result * 31) + perm[i] + 37 * (equal[i] ? 1 : 0);
            return result;
        }
    }


    public static void main(String[] args) throws FileNotFoundException {
        new heritage_pm_maketable().run();
    }

    int height;
    int width;
    double[][] res;
    double[][] resCnt;
    int totalCnt;
    Map<Enumeration, Integer> possibleEnumerations;

    private void run() throws FileNotFoundException {
        solve();
        writeOutput();
    }

    private void solve() {
        buildPossibleEnumerations();
        resCnt = new double[2 * NUM_RECTS + 1][2 * NUM_RECTS + 1];
        countIt();
        res = new double[MAX_SIZE + 1][MAX_SIZE + 1];
        for (int height = 0; height <= MAX_SIZE; ++height)
            for (int width = 0; width <= MAX_SIZE; ++width)
                for (int i = 0; i <= 2 * NUM_RECTS; ++i)
                    for (int j = 0; j <= 2 * NUM_RECTS; ++j)
                        res[height][width] += resCnt[i][j] * c(height + 1, i) * c(width + 1, j);
        for (int height = 0; height <= MAX_SIZE; ++height)
            for (int width = 0; width <= MAX_SIZE; ++width)
                for (int i = 0; i < 2 * NUM_RECTS; ++i)
                    res[height][width] /= (width + 1) * (height + 1);
    }

    private double c(int n, int k) {
        double res = 1;
        for (int i = 0; i < k; ++i)
            res = res * (n - i) / (i + 1);
        return res;
    }

    private void countIt() {
        int nEnum = possibleEnumerations.size();
        Enumeration[] all = possibleEnumerations.keySet().toArray(new Enumeration[0]);
        int[] amount = new int[nEnum];
        for (int i = 0; i < nEnum; ++i)
            amount[i] = possibleEnumerations.get(all[i]);
        int[] givesMask = buildMasks(nEnum, all);
        Map<Enumeration, Integer> subEnums = new HashMap<Enumeration, Integer>();
        for (int i = 0; i < nEnum; ++i) {
            if (i % 10 == 0)
                System.out.println(i);
            Enumeration xE = all[i];
            subEnums.clear();
            int[] rectPerm = new int[NUM_RECTS];
            boolean[] rectUsed = new boolean[NUM_RECTS];
            rec3(0, rectPerm, rectUsed, xE, subEnums);
            for (Enumeration xSub : subEnums.keySet()) {
                double xAmt = amount[i] / (subEnums.size());
                int xMask = subEnums.get(xSub);
                for (int j = 0; j < nEnum; ++j) {
                    Enumeration yE = all[j];
                    double yAmt = amount[j];
                    int yMask = givesMask[j];
                    if ((xMask & yMask) == 0 && xAmt > 0 && yAmt > 0) {
                        resCnt[countEquals(yE)][countEquals(xE)] += xAmt * yAmt;
                    }
                }
            }
        }
    }

    private int countEquals(Enumeration e) {
        int cnt = 0;
        for (int j = 0; j < 2 * NUM_RECTS; ++j)
            if (!e.equal[j])
                ++cnt;
        return cnt;
    }

    private void rec3(int num, int[] rectPerm, boolean[] rectUsed, Enumeration xE, Map<Enumeration, Integer> subEnums) {
        if (num >= NUM_RECTS) {
            process3(rectPerm, xE, subEnums);
            return;
        }

        for (int i = 0; i < NUM_RECTS; ++i)
            if (!rectUsed[i]) {
                rectUsed[i] = true;
                rectPerm[num] = i;
                rec3(num + 1, rectPerm, rectUsed, xE, subEnums);
                rectUsed[i] = false;
            }
    }

    private void process3(int[] rectPerm, Enumeration xE, Map<Enumeration, Integer> subEnums) {
        int[] np = new int[2 * NUM_RECTS];
        for (int i = 0; i < 2 * NUM_RECTS; ++i) {
            int z = xE.perm[i];
            np[i] = 2 * (rectPerm[z / 2]) + (z & 1);
        }
        for (int i = 1; i < 2 * NUM_RECTS; ++i)
            if (xE.equal[i] && np[i] < np[i - 1])
                return;
        Enumeration e = new Enumeration(np, xE.equal);
        if (subEnums.containsKey(e))
            return;
        int nmask = buildMask(e);
        subEnums.put(e, nmask);
    }

    int buildMask(Enumeration e) {
        int mask = 0;
        for (int a = 0; a < NUM_RECTS; ++a)
            for (int b = 0; b < NUM_RECTS; ++b)
                if (a != b) {
                    int la = find(e.perm, 2 * a);
                    int ra = find(e.perm, 2 * a + 1);
                    if (la >= ra)
                        throw new RuntimeException();
                    int lb = find(e.perm, 2 * b);
                    int rb = find(e.perm, 2 * b + 1);
                    if (lb >= rb)
                        throw new RuntimeException();
                    boolean ok = true;
                    if (ra < lb) {
                        for (int j = ra + 1; j <= lb; ++j)
                            if (!e.equal[j]) {
                                ok = false;
                                break;
                            }
                    } else if (rb < la) {
                        for (int j = rb + 1; j <= la; ++j)
                            if (!e.equal[j]) {
                                ok = false;
                                break;
                            }
                    }
                    if (ok)
                        mask |= (1 << (a * NUM_RECTS + b));
                }
        return mask;
    }

    private int[] buildMasks(int nEnum, Enumeration[] all) {
        int[] mask = new int[nEnum];
        for (int i = 0; i < nEnum; ++i) {
            Enumeration e = all[i];
            mask[i] = buildMask(e);
        }
        return mask;
    }

    private int find(int[] x, int y) {
        for (int i = 0; i < x.length; ++i)
            if (x[i] == y)
                return i;
        throw new RuntimeException();
    }

    private void buildPossibleEnumerations() {
        int[] perm = new int[2 * NUM_RECTS];
        boolean[] used = new boolean[2 * NUM_RECTS];
        possibleEnumerations = new HashMap<Enumeration, Integer>();
        totalCnt = 0;
        rec(0, perm, used);
        System.out.println(possibleEnumerations.size());
    }

    private void rec(int num, int[] perm, boolean[] used) {
        if (num >= 2 * NUM_RECTS) {
            process(perm);
            return;
        }

        for (int i = 0; i < 2 * NUM_RECTS; ++i)
            if (!used[i]) {
                used[i] = true;
                perm[num] = i;
                rec(num + 1, perm, used);
                used[i] = false;
            }
    }

    private void process(int[] perm) {
        boolean[] equal = new boolean[2 * NUM_RECTS];
        rec2(1, perm, equal);
    }

    private void rec2(int num, int[] perm, boolean[] equal) {
        if (num >= 2 * NUM_RECTS) {
            process2(perm, equal);
            return;
        }

        if (perm[num] > perm[num - 1]) {
            equal[num] = true;
            rec2(num + 1, perm, equal);
        }
        equal[num] = false;
        rec2(num + 1, perm, equal);
    }

    private void process2(int[] perm, boolean[] equal) {
        Enumeration e = new Enumeration(perm, equal);
        ++totalCnt;
        if (totalCnt % 1000 == 0)
            System.out.println(totalCnt + ", so far: " + possibleEnumerations.size());
        e.Canonize();
        if (possibleEnumerations.containsKey(e))
            possibleEnumerations.put(e, possibleEnumerations.get(e) + 1);
        else
            possibleEnumerations.put(e, 1);
    }

    private void writeOutput() throws FileNotFoundException {
        PrintWriter writer = new PrintWriter(OUT_FILE);

        for (int height = 0; height <= MAX_SIZE; ++height)
            for (int width = 0; width <= MAX_SIZE; ++width)
                writer.println("Res[" + height + "," + width + "]:=" + res[height][width] + ";");

        writer.close();
    }
}
