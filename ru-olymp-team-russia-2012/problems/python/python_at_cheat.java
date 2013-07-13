import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.Scanner;

public class python_at_cheat {
    Scanner in;
    PrintWriter out;

    public python_at_cheat()  {
    }

    final int precision = 1000;
    BigDecimal eps = new BigDecimal(new BigInteger("1"), 100);


    public void run() throws IOException {
        in = new Scanner(new File("python.in"));
        out = new PrintWriter(new File("python.out"));
        int a = in.nextInt(); BigDecimal A = new BigDecimal(a);
        int b = in.nextInt(); BigDecimal B = new BigDecimal(b);
        BigDecimal AB = A.multiply(B); AB = AB.setScale(precision);
        BigDecimal maxla = new BigDecimal(b).setScale(precision);
        BigDecimal minla = AB.divide(new BigDecimal(a + 1).setScale(precision), BigDecimal.ROUND_HALF_DOWN).add(eps);
        BigDecimal maxlb = new BigDecimal(a).setScale(precision);
        BigDecimal minlb = AB.divide(new BigDecimal(b + 1).setScale(precision), BigDecimal.ROUND_HALF_DOWN).add(eps);
        BigDecimal min = minlb.divide(maxla, BigDecimal.ROUND_HALF_DOWN);
        BigDecimal max = maxlb.divide(minla, BigDecimal.ROUND_HALF_DOWN);
        BigDecimal minC = min.setScale(0, RoundingMode.DOWN);
        BigDecimal maxC = max.setScale(0, RoundingMode.DOWN);
        out.println(minC);
        out.println(maxC);
        in.close();
        out.close();

    }

    public static void main(String[] args) throws IOException {
        new python_at_cheat().run();
    }

}
