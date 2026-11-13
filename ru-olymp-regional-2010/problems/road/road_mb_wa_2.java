/**
 * Задача "Кольцевая автодорога"
 * Региональная олимпиада школьников по информатике, день второй.
 * Автор задачи: Владимир Ульянцев, ulyantsev@rain.ifmo.ru
 * Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru
 *
 * По каким-то причинам иногда не находит лучшей окружности нулевого радиуса.
 */

import java.io.*;
import java.util.*;

public class road_mb_wa_2 {
    static void myAssert(String msg, boolean exp) {
        if (!exp) {
            throw new AssertionError(msg);
        }
    }

    static long gcd(long a, long b) {
        a = Math.abs(a);
        b = Math.abs(b);
        while (b != 0) {
            long tmp = a % b;
            a = b;
            b = tmp;
        }
        return a;
    }

    static final String INF = "Infinity";

    static String createAnswer(String head, double x, double y, double r) {
        return head + "\n" + 0.5 * x + " " + 0.5 * y + " " + 0.5 * r;
    }

    public static void main(String[] args) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader("road.in"));
        int[] xs = new int[4];
        int[] ys = new int[4];
        for (int i = 0; i < 4; ++i) {
            String line = in.readLine();
            int wsidx = line.indexOf(' ');
            xs[i] = Integer.parseInt(line.substring(0, wsidx));
            ys[i] = Integer.parseInt(line.substring(wsidx + 1));
            myAssert("x is out of bounds", -100 <= xs[i] && xs[i] <= 100);
            myAssert("y is out of bounds", -100 <= ys[i] && ys[i] <= 100);
            xs[i] += xs[i];
            ys[i] += ys[i];
        }
        in.close();

        PrintWriter out = new PrintWriter("road.out");
        out.println(solve(xs, ys));
        out.close();
    }

    static String solve(int[] xs, int[] ys) {
        long[] answerXNum = new long[100];
        long[] answerYNum = new long[100];
        long[] answerXDen = new long[100];
        long[] answerYDen = new long[100];
        int answerCount = 0;

        boolean isInfinite = false;
        double minX = Double.NaN, minY = Double.NaN, minR = Double.POSITIVE_INFINITY;

        for (int p11 = 0; p11 < 4; ++p11) {
            for (int p12 = p11 + 1; p12 < 4; ++p12) {
                int cx1 = (xs[p11] + xs[p12]) / 2;
                int cy1 = (ys[p11] + ys[p12]) / 2;
                int dx1 = ys[p11] - ys[p12];
                int dy1 = xs[p12] - xs[p11];

                for (int p21 = 0; p21 < 4; ++p21) {
                    for (int p22 = p21 + 1; p22 < 4; ++p22) {
                        if (p21 == p11 && p22 == p12) {
                            continue;
                        }
                        int cx2 = (xs[p21] + xs[p22]) / 2;
                        int cy2 = (ys[p21] + ys[p22]) / 2;
                        int dx2 = ys[p21] - ys[p22];
                        int dy2 = xs[p22] - xs[p21];

                        int det0 = dy1 * dx2 - dx1 * dy2;
                        int det1 = (cy2 - cy1) * dx2 - (cx2 - cx1) * dy2;
                        if (det0 == 0) {
                            if (det1 == 0) {
                                long a = 2 * (dx1 * dx1 + dy1 * dy1);
                                long b = dx1 * (cx1 - xs[p11]) + dy1 * (cy1 - ys[p11]) + dx1 * (cx1 - xs[p21]) + dy1 * (cy1 - ys[p21]);
                                double t = -1.0 * b / a;
                                double x = cx1 + t * dx1;
                                double y = cy1 + t * dy1;
                                double r1 = Math.sqrt((xs[p11] - x) * (xs[p11] - x) + (ys[p11] - y) * (ys[p11] - y));
                                double r2 = Math.sqrt((xs[p21] - x) * (xs[p21] - x) + (ys[p21] - y) * (ys[p21] - y));
                                double r = (r1 + r2) / 2;
                                if (r < minR) {
                                    minR = r;
                                    minX = x;
                                    minY = y;
                                }
                                isInfinite = true;
                            }
                        } else {
                            long d0 = -1;
                            long d1 = -1;
                            for (int i = 0; i < 4; ++i) {
                                long dxNum = (long) (cx1 - xs[i]) * det0 + (long) dx1 * det1;
                                long dyNum = (long) (cy1 - ys[i]) * det0 + (long) dy1 * det1;
                                long d = dxNum * dxNum + dyNum * dyNum;
                                if (d0 == -1 || d0 == d) {
                                    d0 = d;
                                } else {
                                    d1 = d;
                                }
                            }

                            long numX = (long)cx1 * det0 + (long)det1 * dx1;
                            long numY = (long)cy1 * det0 + (long)det1 * dy1;
                            long gcdX = gcd(det0, numX);
                            long gcdY = gcd(det0, numY);
                            numX /= gcdX;
                            numY /= gcdY;
                            long denX = det0 / gcdX;
                            long denY = det0 / gcdY;

                            if (denX < 0) {
                                denX = -denX;
                                numX = -numX;
                            }
                            if (denY < 0) {
                                denY = -denY;
                                numY = -numY;
                            }

                            if (d0 == d1) {
                                minR = 0;
                                minX = (double)numX / denX;
                                minY = (double)numY / denY;
                                isInfinite = true;
                            } else {
                                boolean hasSamePoint = false;

                                for (int t = 0; t < answerCount; ++t) {
                                    if (answerXNum[t] == numX && answerXDen[t] == denX &&
                                        answerYNum[t] == numY && answerYDen[t] == denY) {
                                        hasSamePoint = true;
                                        break;
                                    }
                                }
                                if (!hasSamePoint) {
                                    answerXNum[answerCount] = numX;
                                    answerXDen[answerCount] = denX;
                                    answerYNum[answerCount] = numY;
                                    answerYDen[answerCount] = denY;
                                    ++answerCount;
                                }
                            }
                        }
                    }
                }
            }
        }

        for (int i = 0; i < answerCount; i++) {
            double x = (double)answerXNum[i] / answerXDen[i];
            double y = (double)answerYNum[i] / answerYDen[i];
            double max = 0, min = Double.POSITIVE_INFINITY;
            for (int j = 0; j < 4; ++j) {
                double dx = xs[j] - x;
                double dy = ys[j] - y;
                double r = Math.sqrt(dx * dx + dy * dy);
                max = Math.max(max, r);
                min = Math.min(min, r);
            }
            double r = (min + max) / 2;
            if (r < minR) {
                minR = r;
                minX = x;
                minY = y;
            }
        }
        return createAnswer(isInfinite ? "Infinity" : String.valueOf(answerCount), minX, minY, minR);
    }
}
