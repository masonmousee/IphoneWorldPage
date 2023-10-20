/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.ultis;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author LAPTOP
 */
public class DBUtils {
    private static final String USER_NAME = "SA";
    private static final String PASSWORD="12345";
    private static final String DB_NAME="ProjectPRJ3";
   public static Connection getConnectionV1() throws SQLException, ClassNotFoundException{
        Connection conn = null;
        //load thư viện jsbc để kết nối với MS SQL Sever
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url="jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME;
        conn = DriverManager.getConnection(url, USER_NAME, PASSWORD);
        return conn;
    }
    public static Connection getConnection() throws SQLException, ClassNotFoundException, NamingException{
        Connection conn = null;
        Context context = new InitialContext();
        Context end = (Context)context.lookup("java:comp/env");
        DataSource ds = (DataSource) end.lookup("DBCon");
        conn = ds.getConnection();
        return conn;
    }
}
