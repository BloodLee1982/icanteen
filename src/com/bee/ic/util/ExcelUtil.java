package com.bee.ic.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.directwebremoting.extend.DataUrlDownloadManager;

import com.bee.ic.domain.Dishes;
import com.bee.ic.domain.Order;
import com.bee.ic.pojo.Dishesd;
import com.bee.ic.pojo.Info;

public class ExcelUtil {

	public static String fileToRead = "D:/dd.xls";
	public static void main(String[] args) {
		try {
			HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(fileToRead));
			HSSFSheet sheet = wb.getSheet("Sheet1");
			int rowNum = sheet.getLastRowNum();
			HSSFRow row = sheet.getRow(0);
			int colNum = row.getPhysicalNumberOfCells();
			for (int i = 0; i <= rowNum; i++) {
				row = sheet.getRow(i);
				int j = 0;
				 while (j < colNum) {
					 
					 //System.out.println(getCellFormatValue(row.getCell((short) j)) + "------");
					 System.out.println(row.getCell((short) j).getColumnIndex());
					 System.out.println(getCellFormatValue(row.getCell((short) j)) + "------");
					 j++;
				 }
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public static String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING:
            strCell = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_NUMERIC:
            strCell = String.valueOf(cell.getNumericCellValue());
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN:
            strCell = String.valueOf(cell.getBooleanCellValue());
            break;
        case HSSFCell.CELL_TYPE_BLANK:
            strCell = "";
            break;
        default:
            strCell = "";
            break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        if (cell == null) {
            return "";
        }
        return strCell;
    }
	
	public static String getCellFormatValue(HSSFCell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
            // 如果当前Cell的Type为NUMERIC
            case HSSFCell.CELL_TYPE_NUMERIC:
            case HSSFCell.CELL_TYPE_FORMULA: {
                // 判断当前的cell是否为Date
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    // 如果是Date类型则，转化为Data格式
                    
                    //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
                    //cellvalue = cell.getDateCellValue().toLocaleString();
                    
                    //方法2：这样子的data格式是不带带时分秒的：2011-10-12
                    Date date = cell.getDateCellValue();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    cellvalue = sdf.format(date);
                    
                }
                // 如果是纯数字
                else {
                    // 取得当前Cell的数值
                    cellvalue = String.valueOf(cell.getNumericCellValue());
                }
                break;
            }
            // 如果当前Cell的Type为STRIN
            case HSSFCell.CELL_TYPE_STRING:
                // 取得当前的Cell字符串
                cellvalue = cell.getRichStringCellValue().getString();
                break;
            // 默认的Cell值
            default:
                cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;

    }
	
	public static void outExcelDay(List<Order> ol, List<Dishes> dl) {
		
		List<Info> infoList = new ArrayList<Info>();
		for(int k = 0; k < dl.size(); k++) {
			Info info = new Info();
			info.setId(dl.get(k).getId());
			info.setName(dl.get(k).getName());
			info.setPrice(dl.get(k).getPrice());
			info.setNum(0);
			info.setTotal(0);
			infoList.add(info);
		}
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("日报表");
		HSSFRow row = sheet.createRow((int) 0);
		// TODO 设置各种表格参数
		HSSFCellStyle style = wb.createCellStyle(); // 样式对象  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平  
        
		// 表格第一行
		HSSFRow row1 = sheet.createRow(0);
		sheet.addMergedRegion(new Region(0, (short) 0, 0, (short) 10));  
        row1.setHeightInPoints(25);  
        HSSFCell cell1 = row1.createCell((short)0);   //--->创建一个单元格  
        cell1.setCellStyle(style);  
        cell1.setCellValue("美达厨房日报表");  
        
        //表格第二行  
        sheet.addMergedRegion(new Region(1,(short)0,1,(short)10));  
        HSSFRow row2 = sheet.createRow(1);  
        HSSFCell cell2 = row2.createCell((short)0); 
        cell2.setCellValue("报告日期："+DateUtil.nowStringDate(DateUtil.DATE_PATTERN_YYYYMMDD3));  
        cell2.setCellStyle(style);  
          
          
        //表格第四行  
        sheet.addMergedRegion(new Region(2, (short)0, 2, (short)0));  
        HSSFRow row4 = sheet.createRow(2);  
        row4.setHeightInPoints((short)50); 
        
        HSSFCell cell4 = row4.createCell((short)0);  
        cell4.setCellStyle(style);  
        cell4.setCellValue("订单总价");  
          
        HSSFCell cell4_1 = row4.createCell((short)1);  
        cell4_1.setCellStyle(style);  
        cell4_1.setCellValue("订单详细");
        
        HSSFCell cell4_2 = row4.createCell((short)2);  
        cell4_2.setCellStyle(style);  
        cell4_2.setCellValue("订单时间");
        
        String temp = "";
        for(int i = 0; i < ol.size(); i++) {
        	temp = "";
			Order o = ol.get(i);
			JSONObject jo = JSONObject.fromObject(o.getDishWords());
			JSONArray jsonArray = JSONArray.fromObject(jo.get("dishes"));
			List<Dishesd> list = JSONArray.toList(jsonArray, Dishesd.class);
			row = sheet.createRow((int) i + 3);
			HSSFCell cellList = row.createCell((short) 0);
			cellList.setCellStyle(style);
			cellList.setCellValue((double) o.getPrice());
			
			for(int j = 0; j < list.size(); j++) {
				for(int l = 0; l < infoList.size(); l++) {
					if(list.get(j).getId() == infoList.get(l).getId()) {
						infoList.get(l).setNum(infoList.get(l).getNum() + list.get(j).getNum());
						infoList.get(l).setTotal(infoList.get(l).getTotal() + (list.get(j).getPrice() * list.get(j).getNum()));
					}
				}
				temp += list.get(j).getName() + list.get(j).getNum();
			}
			row.createCell((short) 1).setCellValue(temp);
			row.createCell((short) 2).setCellValue(DateUtil.format(o.getCreateDate(), DateUtil.DATE_PATTERN_YYYYMMDDHHMM));
			
		}
        
        HSSFSheet sheet2 = wb.createSheet("数据统计");
        HSSFRow row2_1 = sheet2.createRow(0);
		sheet2.addMergedRegion(new Region(0, (short) 0, 0, (short) 10));  
		row2_1.setHeightInPoints(25);  
        HSSFCell cell2_1 = row2_1.createCell((short)0);   //--->创建一个单元格  
        cell2_1.setCellStyle(style);  
        cell2_1.setCellValue("美达厨房数据统计报表");  
        
        //表格第二行  
        sheet2.addMergedRegion(new Region(1,(short)0,1,(short)10));  
        HSSFRow row2_2 = sheet2.createRow(1);  
        HSSFCell cell2_2 = row2_2.createCell((short)0);  
        cell2_2.setCellValue("报告日期："+DateUtil.nowStringDate(DateUtil.DATE_PATTERN_YYYYMMDD3));  
        cell2_2.setCellStyle(style);  
        
        sheet2.addMergedRegion(new Region(2, (short)0, 2, (short)0));
        HSSFRow row2_3 = sheet2.createRow(2);
        row2_3.setHeightInPoints(25);
        HSSFCell cell3_1 = row2_3.createCell((short)0);  
        cell3_1.setCellStyle(style);  
        cell3_1.setCellValue("菜品名");  
        
        HSSFCell cell3_2 = row2_3.createCell((short)1);  
        cell3_2.setCellStyle(style);  
        cell3_2.setCellValue("单价");  
        
        HSSFCell cell3_3 = row2_3.createCell((short)2);  
        cell3_3.setCellStyle(style);  
        cell3_3.setCellValue("当天总数");  
        
        HSSFCell cell3_4 = row2_3.createCell((short)3); 
        cell3_4.setCellStyle(style); 
        cell3_4.setCellValue("当天总价"); 
        double allprice = 0;
        Integer totalNum = 0;
        for(int n = 0; n < infoList.size(); n++) {
			row = sheet2.createRow((int) n + 3);
			row.createCell((short) 0).setCellValue(infoList.get(n).getName());
			row.createCell((short) 1).setCellValue((double)infoList.get(n).getPrice());
			row.createCell((short) 2).setCellValue((int)infoList.get(n).getNum());
			row.createCell((short) 3).setCellValue((double)infoList.get(n).getTotal());
			allprice += infoList.get(n).getTotal();
			totalNum += infoList.get(n).getNum();
		}
        HSSFRow row2_x = sheet2.createRow(infoList.size() + 5);
        row2_x.createCell((short) 0).setCellValue("本日销售汇总：");
        row2_x.createCell((short) 2).setCellValue(totalNum);
        row2_x.createCell((short) 3).setCellValue(allprice);
        FileOutputStream fileOut = null;  
        try{
            fileOut = new FileOutputStream("d:\\" + DateUtil.nowStringDate(DateUtil.DATE_PATTERN_YYYYMMDD1) + "日报表.xls");
            wb.write(fileOut);  
            //fileOut.close();  
        }catch(Exception e){  
            e.printStackTrace();  
        }
        finally{  
            if(fileOut != null){  
                try {  
                    fileOut.close();  
                } catch (IOException e) {  
                    // TODO Auto-generated catch block  
                    e.printStackTrace();  
                }  
            }  
        }  
	}
	
	public static void outExcelDate(List<Order> ol, List<Dishes> dl, String start, String end) {
		
		List<Info> infoList = new ArrayList<Info>();
		for(int k = 0; k < dl.size(); k++) {
			Info info = new Info();
			info.setId(dl.get(k).getId());
			info.setName(dl.get(k).getName());
			info.setPrice(dl.get(k).getPrice());
			info.setNum(0);
			info.setTotal(0);
			infoList.add(info);
		}
		
		for(int i = 0; i < ol.size(); i++) {
			Order o = ol.get(i);
			JSONObject jo = JSONObject.fromObject(o.getDishWords());
			JSONArray jsonArray = JSONArray.fromObject(jo.get("dishes"));
			List<Dishesd> list = JSONArray.toList(jsonArray, Dishesd.class);
		
			for(int j = 0; j < list.size(); j++) {
				for(int l = 0; l < infoList.size(); l++) {
					if(list.get(j).getId() == infoList.get(l).getId()) {
						infoList.get(l).setNum(infoList.get(l).getNum() + list.get(j).getNum());
						infoList.get(l).setTotal(infoList.get(l).getTotal() + (list.get(j).getPrice() * list.get(j).getNum()));
					}
				}
			}
		}
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("日期段报表");
		HSSFRow row = sheet.createRow((int) 0);
		// TODO 设置各种表格参数
		HSSFCellStyle style = wb.createCellStyle(); // 样式对象  
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平  
        
		// 表格第一行
		HSSFRow row1 = sheet.createRow(0);
		sheet.addMergedRegion(new Region(0, (short) 0, 0, (short) 10));  
        row1.setHeightInPoints(25);  
        HSSFCell cell1 = row1.createCell((short)0);   //--->创建一个单元格  
        cell1.setCellStyle(style);  
        cell1.setCellValue("美达厨房日报表");  
        
        //表格第二行  
        sheet.addMergedRegion(new Region(1,(short)0,1,(short)10));  
        HSSFRow row2 = sheet.createRow(1);  
        HSSFCell cell2 = row2.createCell((short)0);  
        cell2.setCellValue("报告日期段："+ start + " 到  " + end);  
        cell2.setCellStyle(style);   
        
        sheet.addMergedRegion(new Region(2, (short)0, 2, (short)0));
        HSSFRow row2_3 = sheet.createRow(2);
        HSSFCell cell3_1 = row2_3.createCell((short)0);  
        cell3_1.setCellValue("菜品名");  
        
        HSSFCell cell3_2 = row2_3.createCell((short)1);  
        cell3_2.setCellValue("单价");  
        
        HSSFCell cell3_3 = row2_3.createCell((short)2);  
        cell3_3.setCellValue("总数");  
        
        HSSFCell cell3_4 = row2_3.createCell((short)3);  
        cell3_4.setCellValue("总价"); 
        double allprice = 0;
        Integer totalNum = 0;
        for(int n = 0; n < infoList.size(); n++) {
			row = sheet.createRow((int) n + 3);
			row.createCell((short) 0).setCellValue(infoList.get(n).getName());
			row.createCell((short) 1).setCellValue((double)infoList.get(n).getPrice());
			row.createCell((short) 2).setCellValue((int)infoList.get(n).getNum());
			row.createCell((short) 3).setCellValue((double)infoList.get(n).getTotal());
			allprice += infoList.get(n).getTotal();
			totalNum += infoList.get(n).getNum();
		}
        HSSFRow row2_x = sheet.createRow(infoList.size() + 5);
        row2_x.createCell((short) 0).setCellValue("销售汇总：");
        row2_x.createCell((short) 2).setCellValue(totalNum);
        row2_x.createCell((short) 3).setCellValue(allprice);
        FileOutputStream fileOut = null;  
        try{              
            fileOut = new FileOutputStream("d:\\" + start + "到" + end + "报表.xls");  
            wb.write(fileOut);  
            //fileOut.close();  
            System.out.print("OK");  
        }catch(Exception e){  
            e.printStackTrace();  
        }
        finally{  
            if(fileOut != null){  
                try {  
                    fileOut.close();  
                } catch (IOException e) {  
                    // TODO Auto-generated catch block  
                    e.printStackTrace();  
                }  
            }  
        }  
	}
}
