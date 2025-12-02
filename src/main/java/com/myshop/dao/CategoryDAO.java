package com.myshop.dao;

import com.myshop.models.Category;
import com.myshop.util.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // Get all categories
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();

        String sql = "SELECT Id, Name FROM Categories";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("Id"),
                        rs.getString("Name")
                );
                list.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get category by ID
    public Category getCategoryById(int id) {
        String sql = "SELECT Id, Name FROM Categories WHERE Id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(
                            rs.getInt("Id"),
                            rs.getString("Name")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Insert category
    public boolean insertCategory(Category category) {
        String sql = "INSERT INTO Categories (Name) VALUES (?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getName());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Update category
    public boolean updateCategory(Category category) {
        String sql = "UPDATE Categories SET Name = ? WHERE Id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Delete category
    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM Categories WHERE Id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
