package com.bee.ic.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

import sun.misc.BASE64Encoder;

/**
 * 
 * @author hadeslee
 */
public final class HashUtil {

	/**
	 * 
	 * @param file
	 * @return
	 */
	public static String getMD5(File file) {
		FileInputStream fis = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			fis = new FileInputStream(file);
			byte[] buffer = new byte[8192];
			int length = -1;
			while ((length = fis.read(buffer)) != -1) {
				md.update(buffer, 0, length);
			}
			return bytesToString(md.digest());
		} catch (IOException ex) {
			Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE, null,
					ex);
			return null;
		} catch (NoSuchAlgorithmException ex) {
			Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE, null,
					ex);
			return null;
		} finally {
			try {
				fis.close();
			} catch (IOException ex) {
				Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE,
						null, ex);
			}
		}
	}

	public static String getSHA(File file) {
		FileInputStream fis = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA");
			fis = new FileInputStream(file);
			byte[] buffer = new byte[8192];
			int length = -1;
			while ((length = fis.read(buffer)) != -1) {
				md.update(buffer, 0, length);
			}
			return bytesToString(md.digest());
		} catch (IOException ex) {
			Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE, null,
					ex);
			return null;
		} catch (NoSuchAlgorithmException ex) {
			Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE, null,
					ex);
			return null;
		} finally {
			try {
				fis.close();
			} catch (IOException ex) {
				Logger.getLogger(HashUtil.class.getName()).log(Level.SEVERE,
						null, ex);
			}
		}
	}

	public static String bytesToString(byte[] data) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		char[] temp = new char[data.length * 2];
		for (int i = 0; i < data.length; i++) {
			byte b = data[i];
			temp[i * 2] = hexDigits[b >>> 4 & 0x0f];
			temp[i * 2 + 1] = hexDigits[b & 0x0f];
		}
		return new String(temp);

	}

	public static String getSHA(String strSrc, String encName) {
		MessageDigest md = null;
		String strDes = null;
		BASE64Encoder enc = null;

		byte[] bt = strSrc.getBytes();
		try {
			if (encName == null || encName.equals("")) {
				encName = "SHA-256";
			}
			md = MessageDigest.getInstance(encName);
			md.update(bt);
			enc = new BASE64Encoder();
			strDes = enc.encode(md.digest()); // to HexString
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
		return strDes;
	}

	public static String getSHA(String strSrc) {
		return getSHA(strSrc, null);
	}

	public static String bytes2Hex(byte[] bts) {
		String des = "";
		String tmp = null;
		for (int i = 0; i < bts.length; i++) {
			tmp = (Integer.toHexString(bts[i] & 0xFF));
			if (tmp.length() == 1) {
				des += "0";
			}
			des += tmp;
		}
		return des;
	}
	
	public static void main(String[] argv){
		String a = "123456";
		System.out.println(getSHA(a));
	}

}
