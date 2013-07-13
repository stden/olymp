import ru.ifmo.testlib.InStream;
import ru.ifmo.testlib.Outcome;
import ru.ifmo.testlib.Outcome.Type;
import static ru.ifmo.testlib.Outcome.Type.*;
import java.util.*;

public class Check implements ru.ifmo.testlib.Checker {

    @Override
    public Outcome test(InStream inf, InStream ouf, InStream ans) {
        int n = inf.nextInt();
        int a[] = new int[n];

        for (int i = 0; i < n; i++)
            a[i] = inf.nextInt();

        int k = ouf.nextInt();
        if (k == -1)
            return new Outcome(WA,"participant didn't find solution");
        if (k < 0)
            return new Outcome(WA,"k = "+k);
        if (k > n)
            return new Outcome(WA,"Too many operations: "+k);
        for (int i = 0; i < k; i++){
            int x = ouf.nextInt()-1;
            if (!(0 <= x && x < n-1))
                return new Outcome(WA,"bad index in operation "+(i+1)+" : "+x);
            int t = a[x];
            a[x] = a[x+1];
            a[x+1] = t;
        }

        for (int i = 0; i < n-2; i++){
            if (a[i] < a[i+1] && a[i+1] < a[i+2])
                return new Outcome(WA,String.format("a[%d] < a[%d] < a[%d]",i+1,i+2,i+3));
            if (a[i] > a[i+1] && a[i+1] > a[i+2])
                return new Outcome(WA,String.format("a[%d] > a[%d] > a[%d]",i+1,i+2,i+3));
        }

        return new Outcome(OK, k + " operations");
    }
}
