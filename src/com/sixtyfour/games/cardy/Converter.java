package com.sixtyfour.games.cardy;

import java.io.*;
import java.nio.file.Files;

/**
 * A hacky converter tool that takes txt-files located in the txt-subdir and
 * converts it into SEQ-files in the seq directory that BASIC on the C64 can read
 * 
 * @author EgonOlsen
 *
 */
public class Converter {

	public static void main(String[] args) {
		Converter conv = new Converter();
		conv.convert();
	}

	public void convert() {
		convertTexts();
	}

	public void convertTexts() {
		File[] txts = new File("txt").listFiles((dir, name) -> name.endsWith(".txt"));

		for (File txt : txts) {
			System.out.println("Converting " + txt);
			String name = txt.getName().replace(".txt", "");
			try (OutputStream os = new FileOutputStream("seq/" + name + ".hlp")) {
				String desc = getText(new String(Files.readAllBytes(txt.toPath()))).toLowerCase();
				write(os, null, desc + "|", true);
				write(os, null, "***|", false);

			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			System.out.println("Done  with " + txt);
		}
		System.out.println("All done!");
	}

	private void write(OutputStream os, String prefix, String txt, boolean fullText) {
		try {
			os.write(toBytes(prefix));
			txt = clean(txt);
			int ol = 0;
			do {
				ol = txt.length();
				txt = txt.replace("  ", " ");
			} while (txt.length() != ol);
			String[] parts = txt.split(" |\r");
			int len = 0;
			int pc = 0;
			for (String part : parts) {
				pc++;
				if (part.isEmpty()) {
					continue;
				}
				part = part.trim();
				boolean breaky = false;
				if (part.endsWith("~")) {
					part = part.substring(0, part.length() - 1);
					breaky = true;
				}
				len = len + part.length() + 1;
				if (pc < parts.length && parts[pc].length() + len > 40) {
					os.write(toBytes(part));
					os.write(toBytes("\r"));
					len = 0;
				} else {
					os.write(toBytes(part + (fullText ? " " : "")));
					if (breaky) {
						os.write(toBytes("\r"));
						len = 0;
					}
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private String clean(String txt) {
		txt = txt.replace("ö", "oe").replace("Ö", "Oe");
		txt = txt.replace("ä", "ae").replace("Ä", "Ae");
		txt = txt.replace("ü", "ue").replace("Ü", "Ue");
		txt = txt.replace("ß", "ss");
		txt = txt.replace("|", "~\r").replace("\t", " ");
		txt = txt.replace(",", ";");
		return txt;
	}

	private byte[] toBytes(String txt) {
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		if (txt != null) {
			for (int i = 0; i < txt.length(); i++) {
				char c = txt.charAt(i);
				if (c == '_') {
					c = ' ';
				}
				int ci = getConvertedChar(c);
				bos.write(ci);
			}
		}
		return bos.toByteArray();
	}

	private int getConvertedChar(int c) {
		if (c >= 'a' && c <= 'z') {
			c = (char) (c - 32);
		} else if (c >= 'A' && c <= 'Z') {
			c = (char) (c + 32);
		}
		return c;
	}

	private String getText(String tmp) {
		tmp = tmp.replace("\"", "'").replace(":", ".");
		return tmp;
	}
}
