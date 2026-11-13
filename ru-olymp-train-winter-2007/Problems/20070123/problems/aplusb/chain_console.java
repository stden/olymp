import java.util.Scanner;
import java.math.BigInteger;

public class chain_console {
    public static void main(String[] args) {
        aplusb_pm worker = new aplusb_pm();
        Scanner scanner = new Scanner(System.in);
        while (true) {
            String command = scanner.next();
            if (command.equals("parse")) {
                aplusb_pm.QuadraticIrrationality q = worker.parse(scanner.next());
                System.out.println("(" + q.a + (q.b.signum() >= 0 ? "+" : "") + q.b + "sqrt(" + q.d + "))/" + q.c);
            } else if (command.equals("format")) {
                BigInteger a = new BigInteger(scanner.next());
                BigInteger b = new BigInteger(scanner.next());
                BigInteger d = new BigInteger(scanner.next());
                BigInteger c = new BigInteger(scanner.next());
                System.out.println(worker.format(new aplusb_pm.QuadraticIrrationality(a, b, c, d)));
            } else if (command.equals("exit")) {
                break;
            } else {
                System.out.println("Possible commands: ");
                System.out.println("  format a b c d");
                System.out.println("  parse s");
                System.out.println("  exit");
            }
        }
    }
}
