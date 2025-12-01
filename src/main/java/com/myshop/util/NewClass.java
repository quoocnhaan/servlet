/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author PC
 */
public class NewClass {
    public static void main(String[] args) {
        try (Connection conn = DBContext.getConnection()) {
            System.out.println("✅ Connection successful!");

            // Example query: list categories
            String sql = "SELECT Id, Name FROM Categories";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("Id");
                    String name = rs.getString("Name");
                    System.out.println(id + " - " + name);
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Connection failed!");
            e.printStackTrace();
        }
    }
}
