import java.awt.*;
import java.awt.image.*;
import java.io.*;
import java.util.*;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;

public class Visualizer {
	private static double xc, yc, scale;
	private static int wid = 800;
	private static int hei = 600;
	private static int border = 10;
	private static Color rectColor = Color.RED;
	private static Color circColor = Color.YELLOW;
	
	private static int getScreenX(double x) {
		return (int) (wid / 2 + (x - xc) / scale);
	}

	private static int getScreenY(double y) {
		return (int) (hei / 2 - (y - yc) / scale);
	}

	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new FileReader(args[0]));
		int x1 = in.nextInt();
		int y1 = in.nextInt();
		int x2 = in.nextInt();
		int y2 = in.nextInt();
		int x3 = in.nextInt();
		int y3 = in.nextInt();
		int r = in.nextInt();
		int xmin = Math.min(x1, x3 - r);
		int xmax = Math.max(x2, x3 + r);
		int ymin = Math.min(y1, y3 - r);
		int ymax = Math.max(y2, y3 + r);
		xc = (xmin + xmax) * 0.5;
		yc = (ymin + ymax) * 0.5;
		double scalex = (xmax - xmin) * 1d / (wid - 2 * border);
		double scaley = (ymax - ymin) * 1d / (hei - 2 * border);
		scale = Math.max(scalex, scaley);
		wid = (int) (2 * border + (xmax - xmin) / scale);
		hei = (int) (2 * border + (ymax - ymin) / scale);
		
		BufferedImage img = new BufferedImage(wid, hei, BufferedImage.TYPE_INT_RGB);
		Graphics g = img.getGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, wid, hei);
		g.setColor(rectColor);
		g.fillRect(getScreenX(x1), getScreenY(y2), getScreenX(x2) - getScreenX(x1), getScreenY(y1) - getScreenY(y2));
		g.setXORMode(circColor);
		g.fillOval(getScreenX(x3 - r), getScreenY(y3 + r), getScreenX(x3 + r) - getScreenX(x3 - r), getScreenY(y3 - r) - getScreenY(y3 + r));
//		int sr = (int) Math.round(r / scale);
//		int sx3 = getScreenX(x3);
//		int sy3 = getScreenY(y3);
//		g.fillOval(sx3 - sr, sy3 - sr, 2 * sr, 2 * sr);
		int nei = (int) (1 / scale);
		if (nei >= 2) {
			g.setPaintMode();
			g.setColor(Color.BLACK);
			for (int x = x1; x <= x2; x++) {
				for (int y = y1; y <= y2; y++) {
					if (Math.hypot(x - x3, y - y3) <= r) {
						int xp = getScreenX(x);
						int yp = getScreenY(y);
						int size = Math.max(nei / 8, 1);
						size = Math.min(size, 10);
						g.fillOval(xp - size, yp - size, 2 * size, 2 * size);
					}
				}
			}
		}
		ImageWriter iw = ImageIO.getImageWritersByFormatName("bmp").next();
		iw.setOutput(ImageIO.createImageOutputStream(new File(args[0] + ".bmp")));
		iw.write(img);
//		iw.write(img.getSubimage(border, border, wid - 2 * border, hei - 2 * border));
	}
}
