package com.albumshelf.mvc.util;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class FormatUtil {

	private FormatUtil() {}

	//214 -> 3:34
	public static String formatDurata(Integer secondi) {
		if (secondi == null) return "--:--";
		int minuti = secondi / 60;
		int resto = secondi % 60;
		return minuti + ":" + (resto < 10 ? "0" + resto : resto);
	}

	//2418 -> 40 min
	public static String formatDurataMinuti(int secondiTotali) {
		int minuti = Math.round(secondiTotali / 60f);
		return minuti + " min";
	}

	//essendoci 5 stelle e 5 mezze-stelle, il voto va da 0 a 10. Con 0, 0.5 -> 1, 1 -> 1.5 ... 
	public static int getIndiceStelleSprite(BigDecimal voto) { 
		if (voto == null) return -1;
		return voto.multiply(new BigDecimal(2)).intValue();
	}

	public static String formatPrezzo(BigDecimal prezzo) {
		if (prezzo == null) return "";
		NumberFormat formatter = NumberFormat.getCurrencyInstance(Locale.ITALY);
		return formatter.format(prezzo);
	}
	
	public static String formatVotoNumerico(BigDecimal voto) {
		if (voto == null) return "N/D";
		return voto.setScale(1, java.math.RoundingMode.HALF_UP) + " / 5";
	}

	public static String formatData(Date data) {
		if (data == null) return "";
		return new SimpleDateFormat("dd/MM/yyyy").format(data);
	}

	public static String formatDataEstesa(Date data) {
		if (data == null) return "";
		return new SimpleDateFormat("d MMMM yyyy", Locale.ITALIAN).format(data);
	}
}