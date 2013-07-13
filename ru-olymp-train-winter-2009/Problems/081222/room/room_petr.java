import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.Scanner;

public class room_petr {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner scanner = new Scanner(new File("room.in"));
        BigInteger n = new BigInteger(scanner.next());
        BigInteger m = BigInteger.valueOf(2).multiply(n.divide(BigInteger.valueOf(3)));
        BigInteger ans = m.multiply(m.add(BigInteger.ONE)).divide(BigInteger.valueOf(2)).add(n.divide(BigInteger.valueOf(3)).multiply(n.divide(BigInteger.valueOf(3))).add(n.mod(BigInteger.valueOf(3)).multiply(m.add(BigInteger.ONE))));
        PrintWriter writer = new PrintWriter("room.out");
        writer.println(ans);
        writer.close();
    }
}
