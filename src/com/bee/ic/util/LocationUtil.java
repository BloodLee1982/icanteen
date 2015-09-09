package com.bee.ic.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public final class LocationUtil {

	public static final String inputStream2String(InputStream in) throws UnsupportedEncodingException, IOException{
		if(in == null)
			return "";
		
		StringBuffer out = new StringBuffer();
		byte[] b = new byte[4096];
		for (int n; (n = in.read(b)) != -1;) {
			out.append(new String(b, 0, n, "UTF-8"));
		}
		return out.toString();
	}
	
	public static final boolean checkSignature(String token,String signature,String timestamp,String nonce){
		List<String> params = new ArrayList<String>();
		params.add(token);
		params.add(timestamp);
		params.add(nonce);
		Collections.sort(params,new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		String temp = params.get(0)+params.get(1)+params.get(2);
		return SHA1.encode(temp).equals(signature);
	}
	
	/**
	 * 根据经纬度和半径计算经纬度范围
	 * 
	 * @param lat 纬度Y
	 * @param lon 经度X
	 * @param raidus 半径
	 * @return
	 */
	public static double[] getAround(double lat, double lon, int raidus) {

	      Double latitude = lat;
	      Double longitude = lon;
	
	      Double degree = (24901 * 1609) / 360.0;
	      double raidusMile = raidus;
	
	      Double dpmLat = 1 / degree;
	      Double radiusLat = dpmLat * raidusMile;
	      Double minLat = latitude - radiusLat;
	      Double maxLat = latitude + radiusLat;
	
	      Double mpdLng = degree * Math.cos(latitude * (Math.PI / 180));
	      Double dpmLng = 1 / mpdLng;
	      Double radiusLng = dpmLng * raidusMile;
	      Double minLng = longitude - radiusLng;
	      Double maxLng = longitude + radiusLng;
	      return new double[]{minLat, minLng, maxLat, maxLng};
	 }
}
