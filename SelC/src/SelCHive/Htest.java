package SelCHive;

import java.sql.*;


public class Htest {
   public static void main(String[] args) {
      
      try {
         Class.forName("org.apache.hive.jdbc.HiveDriver");
      } catch (Exception e) {
         System.out.println("Class.forName 오류:" + e);
      }

      try {
         Connection con =  DriverManager.getConnection("jdbc:hive2://192.168.56.103:10000/default", "", "");
         
         Statement stmt = con.createStatement();
          ResultSet res = stmt.executeQuery("SELECT MID, LOC FROM SELC_SEARCHLOG");
            while (res.next()) { 
                 System.out.println(res.getString(1)+","+res.getString(2));
                
            }
            
            
      } catch (Exception e) {
         System.out.println("Connection con 오류!!" +e);
      }
   }
   
}
