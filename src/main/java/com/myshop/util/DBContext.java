/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.util;

/**
 *
 * @author PC
 */
import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class DBContext {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=WebShop;encrypt=false";
    private static final String USER = "sa";
    private static final String PASS = "1";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}