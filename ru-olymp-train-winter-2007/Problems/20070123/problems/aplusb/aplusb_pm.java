import java.math.BigInteger;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class aplusb_pm {
    final String TASK_ID = "aplusb";
    final String IN_FILE = TASK_ID + ".in";
    final String OUT_FILE = TASK_ID + ".out";
    final int MAX_ANSWER = 1000;


    static class QuadraticIrrationality {
        BigInteger a;
        BigInteger b;
        BigInteger c;
        BigInteger d;

        public QuadraticIrrationality(BigInteger a, BigInteger b, BigInteger c, BigInteger d) {
            BigInteger z = a.gcd(b.gcd(c));
            if (z.signum() * c.signum() < 0)
                z = z.negate();
            this.a = a.divide(z);
            this.b = b.divide(z);
            this.c = c.divide(z);
            this.d = d;
        }

        public double estimate() {
            return (a.doubleValue() + b.doubleValue() * Math.sqrt(d.doubleValue())) / c.doubleValue();
        }


        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            QuadraticIrrationality that = (QuadraticIrrationality) o;

            if (!a.equals(that.a)) return false;
            if (!b.equals(that.b)) return false;
            if (!c.equals(that.c)) return false;
            if (!d.equals(that.d)) return false;

            return true;
        }

        public int hashCode() {
            int result;
            result = a.hashCode();
            result = 31 * result + b.hashCode();
            result = 31 * result + c.hashCode();
            result = 31 * result + d.hashCode();
            return result;
        }
    }

    public static void main(String[] args) throws FileNotFoundException {
        new aplusb_pm().run();
    }

    String aS;
    String bS;
    String cS;
    QuadraticIrrationality a;
    QuadraticIrrationality b;
    QuadraticIrrationality c;

    private void run() throws FileNotFoundException {
        readInput();
        solve();
        writeOutput();
    }

    private void solve() {
        a = parse(aS);
        b = parse(bS);
        c = add(a, b);
        if (c == null || c.b.signum() == 0)
            cS = "Impossible";
        else
            cS = format(c);
    }

    public String format(QuadraticIrrationality c) {
        StringBuilder res = new StringBuilder();
        res.append("[");
        BigInteger p1 = extractIntPart(c);
        res.append(p1);
        res.append(";");

        c = inverse(addInt(c, p1.negate()));
        List<BigInteger> items = new ArrayList<BigInteger>();
        Map<QuadraticIrrationality, Integer> where = new HashMap<QuadraticIrrationality, Integer>();
        int prePeriod;
        int period;
        int at = 0;
        while (true) {
            if (where.containsKey(c)) {
                prePeriod = where.get(c);
                period = at - prePeriod;
                break;
            }
            where.put(c, at);
            BigInteger p = extractIntPart(c);
            items.add(p);
            c = inverse(addInt(c, p.negate()));
            ++at;

            if (where.size() > MAX_ANSWER - 1)
                throw new RuntimeException();
        }

        System.out.println(where.size() + 1);

        for (int i = 0; i < prePeriod; ++i) {
            if (i > 0)
                res.append(",");
            res.append(items.get(i));
        }

        if (prePeriod > 0)
            res.append(",");
        res.append("(");
        for (int i = prePeriod; i < prePeriod + period; ++i) {
            if (i > prePeriod)
                res.append(",");
            res.append(items.get(i));
        }
        res.append(")]");
        return res.toString();
    }

    private BigInteger extractIntPart(QuadraticIrrationality q) {
        double z = q.estimate();
        if (Math.abs(z) > 1e15)
            throw new RuntimeException();
        long x1 = Math.round(z) - 1;
        while (true) {
            BigInteger z1 = q.c.multiply(BigInteger.valueOf(x1)).subtract(q.a);
            BigInteger z2 = q.b;
            if (z1.signum() > z2.signum())
                break;
            if (z1.signum() == z2.signum())
                if (z1.signum() < 0) {
                    if (z1.pow(2).compareTo(z2.pow(2).multiply(q.d)) < 0)
                        break;
                } else if (z1.signum() > 0) {
                    if (z1.pow(2).compareTo(z2.pow(2).multiply(q.d)) > 0)
                        break;
                }
            ++x1;
        }
        return BigInteger.valueOf(x1 - 1);
    }

    private QuadraticIrrationality add(QuadraticIrrationality x, QuadraticIrrationality y) {
        if (x.d.equals(y.d)) {
            BigInteger a = x.a.multiply(y.c).add(y.a.multiply(x.c));
            BigInteger b = x.b.multiply(y.c).add(y.b.multiply(x.c));
            BigInteger c = x.c.multiply(y.c);
            return new QuadraticIrrationality(a, b, c, x.d);
        } else return null;
    }

    private QuadraticIrrationality inverse(QuadraticIrrationality q) {
        BigInteger a = q.c.multiply(q.a);
        BigInteger b = q.c.multiply(q.b).negate();
        BigInteger c = q.a.multiply(q.a).subtract(q.b.multiply(q.b.multiply(q.d)));
        return new QuadraticIrrationality(a, b, c, q.d);
    }

    private QuadraticIrrationality addInt(QuadraticIrrationality q, BigInteger x) {
        BigInteger a = x.multiply(q.c).add(q.a);
        return new QuadraticIrrationality(a, q.b, q.c, q.d);
    }

    public QuadraticIrrationality parse(String desc) {
        String[] parts = desc.split("\\(");
        if (parts.length != 2)
            throw new RuntimeException();
        String periodS = parts[1];
        String preperiodS = parts[0];
        BigInteger a = BigInteger.ONE;
        BigInteger b = BigInteger.ZERO;
        BigInteger c = BigInteger.ZERO;
        BigInteger d = BigInteger.ONE;
        String[] periodDigits = periodS.split("[^0-9]");
        for (int i = periodDigits.length - 1; i >= 0; --i) {
            String item = periodDigits[i];
            if (item.length() > 0) {
                BigInteger num = new BigInteger(item);
                BigInteger nc = a;
                BigInteger nd = b;
                BigInteger na = num.multiply(a).add(c);
                BigInteger nb = num.multiply(b).add(d);
                a = na;
                b = nb;
                c = nc;
                d = nd;
            }
        }

        BigInteger qa = c;
        BigInteger qb = d.subtract(a);
        BigInteger qc = b.negate();
        QuadraticIrrationality q = solveQuadratic(qa, qb, qc);

        String[] preperiodDigits = preperiodS.split("[^0-9]");
        for (int i = preperiodDigits.length - 1; i >= 0; --i) {
            String item = preperiodDigits[i];
            if (item.length() > 0) {
                BigInteger num = new BigInteger(item);

                q = addInt(inverse(q), num);
            }
        }

        return q;
    }

    private QuadraticIrrationality solveQuadratic(BigInteger qa, BigInteger qb, BigInteger qc) {
        if (qa.signum() == 0)
            throw new RuntimeException();

        BigInteger z = qa.gcd(qb.gcd(qc));
        qa = qa.divide(z);
        qb = qb.divide(z);
        qc = qc.divide(z);
        if (qa.signum() < 0) {
            qa = qa.negate();
            qb = qb.negate();
            qc = qc.negate();
        }

        BigInteger d = qb.multiply(qb).subtract(BigInteger.valueOf(4).multiply(qa).multiply(qc));
        if (d.signum() <= 0)
            throw new RuntimeException();

        BigInteger b = extractSquare(d);
        d = d.divide(b.multiply(b));
        BigInteger a = qb.negate();
        BigInteger c = BigInteger.valueOf(2).multiply(qa);

        double x1 = (a.doubleValue() + b.doubleValue() * Math.sqrt(d.doubleValue())) / c.doubleValue();
        double x2 = (a.doubleValue() - b.doubleValue() * Math.sqrt(d.doubleValue())) / c.doubleValue();
        if (x1 < 0 || x2 >= 0)
            throw new RuntimeException();

        return new QuadraticIrrationality(a, b, c, d);
    }

    private BigInteger extractSquare(BigInteger d) {
        if (d.compareTo(BigInteger.valueOf(1000000000000000L)) >= 0)
            throw new RuntimeException();

        long z = d.longValue();

        long j = 1;
        for (long i = 2; i * i <= z; ++i)
            if (z % (i * i) == 0)
                j = i;

        return BigInteger.valueOf(j);
    }

    private void writeOutput() throws FileNotFoundException {
        PrintWriter writer = new PrintWriter(OUT_FILE);

        writer.println(cS);

        writer.close();
    }

    private void readInput() throws FileNotFoundException {
        Scanner scanner = new Scanner(new File(IN_FILE));

        aS = scanner.next();
        bS = scanner.next();
    }
}
