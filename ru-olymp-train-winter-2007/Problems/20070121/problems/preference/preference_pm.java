import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class preference_pm implements Runnable {
    final String TASK_ID = "preference";
    final String IN_FILE = TASK_ID + ".in";
    final String OUT_FILE = TASK_ID + ".out";
    final static String VALUES = "789TJQKA";
    final static String SUITS = "SCDH";
    final static int NUM_PLAYERS = 3;
    final static int NUM_CARDS = VALUES.length() * SUITS.length();


    public static void main(String[] args) {
        new Thread(new preference_pm()).start();
    }

    static class Card {
        int id;

        public Card(String desc) {
            if (desc.length() != 2)
                throw new RuntimeException("wrong length of a card description");

            int value = VALUES.indexOf(desc.charAt(0));
            int suit = SUITS.indexOf(desc.charAt(1));

            if (value < 0 || suit < 0)
                throw new RuntimeException("strange card description");

            id = suit * VALUES.length() + value;
        }

        public Card(int id) {
            this.id = id;
        }

        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            Card card = (Card) o;

            if (id != card.id) return false;

            return true;
        }

        public int hashCode() {
            return id;
        }

        public String toString() {
            int value = id % VALUES.length();
            int suit = id / VALUES.length();
            return VALUES.charAt(value) + "" + SUITS.charAt(suit);
        }
    }

    static class Position {
        long cardMask;
        byte whoMoves;
        byte trump;

        @SuppressWarnings("unchecked")
        public Position(byte whoMoves) {
            cardMask = 0;
            this.whoMoves = whoMoves;
            trump = -1;
        }

        void assignCard(int cardId, int who) {
            cardMask ^= ((long) (getOwner(cardId) ^ who) << (cardId * 2));
        }

        private int getOwner(int cardId) {
            return (int) ((cardMask >>> (cardId * 2)) & 3);
        }

        public Position(Position p) {
            this(p.whoMoves);
            cardMask = p.cardMask;
            trump = p.trump;
        }


        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            Position position = (Position) o;

            if (cardMask != position.cardMask) return false;
            if (trump != position.trump) return false;
            if (whoMoves != position.whoMoves) return false;

            return true;
        }

        public int hashCode() {
            int result;
            result = (int) (cardMask ^ (cardMask >>> 32));
            result = 31 * result + whoMoves;
            result = 31 * result + trump;
            return result;
        }
    }

    static class Game {
        Set<Card> toDismiss;
        int trump;

        public Game(Set<Card> toDismiss, int trump) {
            this.toDismiss = toDismiss;
            this.trump = trump;
        }
    }

    static class PositionDescription {
    		int score;
    		int alpha;
    		int beta;

    		public PositionDescription(int score, int alpha, int beta) {
    		    this.score = score;
    		    this.alpha = alpha;
    		    this.beta = beta;
    		}
    }


    Position start;
    int res;
    List<Game> winningGames;
    Map<Position, PositionDescription> cache;
    int[] moveTryOrder;

    public void run() {
        try {
            readInput();
            solve();
            writeOutput();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    private void solve() {
        res = -1;
        winningGames = new ArrayList<Game>();
        cache = new HashMap<Position, PositionDescription>();

        byte[] trumpTryOrder = buildTrumpTryOrder();

        for (byte trump : trumpTryOrder) {
            moveTryOrder = buildMoveTryOrder(trump);
            int[] dismissTryOrder = buildDismissTryOrder(trump);

            for (int d1 : dismissTryOrder)
                if (start.getOwner(d1) == 0)
                    for (int d2 : dismissTryOrder)
                        if (d1 < d2 && start.getOwner(d2) == 0) {
                            Set<Card> toDismiss = new HashSet<Card>();
                            toDismiss.add(new Card(d1));
                            toDismiss.add(new Card(d2));
                            Game game = new Game(toDismiss, trump);
                            Position first = new Position(start);
                            first.assignCard(d1, 3);
                            first.assignCard(d2, 3);
                            first.trump = trump;
                            int alpha = (byte) Math.max(res - 1, 0);
                            int beta = 10;

                            int value = evaluate(first, alpha, beta);
                            if (value > res) {
                                res = value;
                                winningGames.clear();
                            }
                            if (value == res) {
                                winningGames.add(game);
                            }

                            System.out.println("One more game: dismissing " + new Card(d1) + " and " + new Card(d2) + " with trump " + (trump < 0 ? "N" : SUITS.charAt(trump)) + " gives " + (value < res ? ("<" + res) : value) + " score.");
                        }

            cache.clear();
        }
    }

    private int[] buildDismissTryOrder(byte trump) {
        int[] tmp = buildMoveTryOrder(trump);
        int[] res = new int[tmp.length];
        for (int i = 0; i < tmp.length; ++i)
            res[i] = tmp[tmp.length - 1 - i];
        return res;
    }

    private int[] buildMoveTryOrder(byte trump) {
        int[] moveTryOrder = new int[NUM_CARDS];
        int index = 0;
        if (trump >= 0)
            for (int i = VALUES.length() - 1; i >= 0; --i)
                moveTryOrder[index++] = trump * VALUES.length() + i;
        for (int i = VALUES.length() - 1; i >= 0; --i)
            for (int j = 0; j < SUITS.length(); ++j)
                if (j != trump)
                    moveTryOrder[index++] = j * VALUES.length() + i;
        if (index != NUM_CARDS)
            throw new RuntimeException();
        return moveTryOrder;
    }

    private byte[] buildTrumpTryOrder() {
        byte[] trumpTryOrder = new byte[SUITS.length() + 1];
        trumpTryOrder[SUITS.length()] = -1;
        int[] suitWeight = new int[SUITS.length()];
        for (byte suit = 0; suit < SUITS.length(); ++suit) {
            for (int value = 0; value < VALUES.length(); ++value)
                if (start.getOwner(suit * VALUES.length() + value) == 0)
                    suitWeight[suit] += (100 + value);
            trumpTryOrder[suit] = suit;
        }
        for (int i = 0; i < SUITS.length(); ++i)
            for (int j = 0; j < SUITS.length() - 1; ++j)
                if (suitWeight[trumpTryOrder[j]] < suitWeight[trumpTryOrder[j + 1]]) {
                    byte t = trumpTryOrder[j];
                    trumpTryOrder[j] = trumpTryOrder[j + 1];
                    trumpTryOrder[j + 1] = t;
                }
        return trumpTryOrder;
    }

    private boolean hasSuit(Position p, int player, int suit) {
        if (suit < 0)
            return false;
        for (int value = 0; value < VALUES.length(); ++value)
            if (p.getOwner(suit * VALUES.length() + value) == player)
                return true;
        return false;
    }

    private boolean validTurn(int starter, int trump, int card, boolean canTrump, boolean canOffsuit) {
        if (card / VALUES.length() == starter / VALUES.length())
            return true;
        if (card / VALUES.length() == trump && canTrump)
            return true;
        if (canOffsuit)
            return true;
        return false;
    }

    private int fight(int trump, int c1, int c2) {
        if (c2 / VALUES.length() == c1 / VALUES.length())
            return Math.max(c1, c2);
        if (c2 / VALUES.length() == trump)
            return c2;
        else
            return c1;
    }

    private int evaluate(Position p, int alpha, int beta) {
        if (alpha >= beta)
            return alpha;

        PositionDescription desc;

        if (cache.containsKey(p)) {
            desc = cache.get(p);
            if (desc.alpha < desc.score && desc.score < desc.beta)
              	return desc.score;
            if (desc.alpha >= desc.score)
                beta = desc.alpha;
            if (desc.beta <= desc.score)
                alpha = desc.beta;
            if (alpha >= beta)
                return alpha;
        } else {
            desc = null;
        }

        int res;

        if (p.cardMask == -1) {
            res = 0;
        } else {
            byte p1 = p.whoMoves;
            byte p2 = (byte) ((p1 + 1) % 3);
            byte p3 = (byte) ((p2 + 1) % 3);
            byte b1 = p1 == 0 ? -1 : Byte.MAX_VALUE;
            for (int c1 : moveTryOrder)
                if (p.getOwner(c1) == p1) {
                    boolean can2trump = !hasSuit(p, p2, c1 / VALUES.length());
                    boolean can2offsuit = can2trump && !hasSuit(p, p2, p.trump);
                    boolean can3trump = !hasSuit(p, p3, c1 / VALUES.length());
                    boolean can3offsuit = can3trump && !hasSuit(p, p3, p.trump);
                    byte b2 = p2 == 0 ? -1 : Byte.MAX_VALUE;
                    for (int c2 : moveTryOrder)
                        if (p.getOwner(c2) == p2)
                            if (validTurn(c1, p.trump, c2, can2trump, can2offsuit)) {
                                byte b3 = p3 == 0 ? -1 : Byte.MAX_VALUE;
                                for (int c3 : moveTryOrder)
                                    if (p.getOwner(c3) == p3)
                                        if (validTurn(c1, p.trump, c3, can3trump, can3offsuit)) {
                                            int topper = fight(p.trump, fight(p.trump, c1, c2), c3);
                                            Position next = new Position(p);
                                            next.assignCard(c1, 3);
                                            next.assignCard(c2, 3);
                                            next.assignCard(c3, 3);
                                            byte nextTurn;
                                            if (topper == c1)
                                                nextTurn = p1;
                                            else if (topper == c2)
                                                nextTurn = p2;
                                            else if (topper == c3)
                                                nextTurn = p3;
                                            else
                                                throw new RuntimeException();
                                            int added = nextTurn == 0 ? 1 : 0;
                                            next.whoMoves = nextTurn;
                                            int nAlpha = alpha;
                                            int nBeta = beta;
                                            if (p3 == 0) nAlpha = Math.max(nAlpha, b3); else nBeta = Math.min(nBeta, b3);
                                            if (p2 == 0) nAlpha = Math.max(nAlpha, b2); else nBeta = Math.min(nBeta, b2);
                                            if (p1 == 0) nAlpha = Math.max(nAlpha, b1); else nBeta = Math.min(nBeta, b1);
                                            nAlpha -= added;
                                            nBeta -= added;
                                            nAlpha = Math.max(nAlpha, 0);
                                            nBeta = Math.min(nBeta, countCards(next));
                                            int cur = added + evaluate(next, nAlpha, nBeta);
                                            if (p3 == 0)
                                                b3 = (byte) Math.max(b3, cur);
                                            else
                                                b3 = (byte) Math.min(b3, cur);
                                        }
                                if (p2 == 0)
                                    b2 = (byte) Math.max(b2, b3);
                                else
                                    b2 = (byte) Math.min(b2, b3);
                            }
                    if (p1 == 0)
                        b1 = (byte) Math.max(b1, b2);
                    else
                        b1 = (byte) Math.min(b1, b2);
                }
            res = b1;
        }

        if (desc == null) {
            desc = new PositionDescription(res, alpha, beta);
            cache.put(p, desc);
        } else {
            desc.alpha = Math.min(alpha, desc.alpha);
            desc.beta = Math.max(beta, desc.beta);
            desc.score = res;
        }

        return res;
    }

    private int countCards(Position position) {
        int am = 0;
        for (int i = 0; i < NUM_CARDS; ++i)
            if (position.getOwner(i) == 0)
                ++am;
        return am;
    }

    private void writeOutput() throws FileNotFoundException {
        PrintWriter writer = new PrintWriter(OUT_FILE);

        writer.println(res);
        writer.println(winningGames.size());
        for (Game game : winningGames) {
            boolean first = true;
            for (Card card : game.toDismiss) {
                if (first)
                    first = false;
                else
                    writer.print(" ");
                writer.print(card);
            }
            writer.println();
            if (game.trump < 0)
                writer.println("N");
            else
                writer.println(SUITS.charAt(game.trump));
        }

        writer.close();
    }

    private void readInput() throws FileNotFoundException {
        Scanner scanner = new Scanner(new File(IN_FILE));

        byte firstTurn = (byte) (scanner.nextInt() - 1);
        start = new Position(firstTurn);
        Set<Card> all = new HashSet<Card>();
        for (int who = 0; who < NUM_PLAYERS; ++who)
            for (int i = 0; i < 10 + (who == 0 ? 2 : 0); ++i) {
                Card c = new Card(scanner.next());
                if (all.contains(c))
                    throw new RuntimeException("duplicate card");
                all.add(c);
                start.assignCard(c.id, who);
            }
    }
}
