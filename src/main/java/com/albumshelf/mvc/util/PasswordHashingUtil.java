package com.albumshelf.mvc.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.MessageDigest;
import java.util.Base64;

public class PasswordHashingUtil {

	private static final String ALGORITMO = "SHA-256";
	private static final int LUNGHEZZA_SALT_BYTE = 16;

	private PasswordHashingUtil() {}
	public static String hash(String passwordInChiaro) {
		byte[] salt = generaSalt();
		byte[] hash = calcolaHash(passwordInChiaro, salt);
		return Base64.getEncoder().encodeToString(salt) + ":" + Base64.getEncoder().encodeToString(hash);
	}

	public static boolean verifica(String passwordInChiaro, String hashSalvato) {
		String[] parti = hashSalvato.split(":");
		if (parti.length != 2) return false;

		byte[] salt = Base64.getDecoder().decode(parti[0]);
		byte[] hashAtteso = Base64.getDecoder().decode(parti[1]);
		byte[] hashCalcolato = calcolaHash(passwordInChiaro, salt);

		return MessageDigest.isEqual(hashAtteso, hashCalcolato);
	}

	private static byte[] generaSalt() {
		byte[] salt = new byte[LUNGHEZZA_SALT_BYTE];
		new SecureRandom().nextBytes(salt);
		return salt;
	}

	private static byte[] calcolaHash(String passwordInChiaro, byte[] salt) {
		try {
			MessageDigest digest = MessageDigest.getInstance(ALGORITMO);
			digest.update(salt);
			return digest.digest(passwordInChiaro.getBytes(java.nio.charset.StandardCharsets.UTF_8));
		} catch (NoSuchAlgorithmException e) {
			throw new IllegalStateException("Algoritmo di hashing non disponibile: " + ALGORITMO, e);
		}
	}
}