/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.dao;

/**
 *
 * @author PC
 */
import com.myshop.models.Product;
import com.myshop.models.Category;
import com.myshop.util.DBContext;

import java.sql.*;
import java.util.ArrayList;

import java.util.List;

public class ProductDAO {

    // Get all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.Id as CategoryId, c.Name as CategoryName "
                + "FROM Products p LEFT JOIN Categories c ON p.CategoryId = c.Id";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = null;
                int categoryId = rs.getInt("CategoryId");
                if (!rs.wasNull()) {
                    category = new Category(categoryId, rs.getString("CategoryName"));
                }

                Product product = new Product(
                        rs.getInt("Id"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("ImagePath"),
                        category,
                        rs.getTimestamp("CreatedAt")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Get product by ID
    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT p.*, c.Id as CategoryId, c.Name as CategoryName "
                + "FROM Products p LEFT JOIN Categories c ON p.CategoryId = c.Id WHERE p.Id=?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = null;
                    int categoryId = rs.getInt("CategoryId");
                    if (!rs.wasNull()) {
                        category = new Category(categoryId, rs.getString("CategoryName"));
                    }

                    product = new Product(
                            rs.getInt("Id"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getInt("Quantity"),
                            rs.getString("ImagePath"),
                            category,
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Insert new product
    public boolean insertProduct(Product product) {
        String sql = "INSERT INTO Products (Name, Description, Price, Quantity, ImagePath, CategoryId) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getImagePath());
            if (product.getCategory() != null) {
                ps.setInt(6, product.getCategory().getId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update product
    public boolean updateProduct(Product product) {
        String sql = "UPDATE Products SET Name=?, Description=?, Price=?, Quantity=?, ImagePath=?, CategoryId=? WHERE Id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getImagePath());
            if (product.getCategory() != null) {
                ps.setInt(6, product.getCategory().getId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.setInt(7, product.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete product
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM Products WHERE Id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
