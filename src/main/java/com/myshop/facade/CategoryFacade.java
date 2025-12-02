/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.facade;

import com.myshop.dao.CategoryDAO;
import com.myshop.models.Category;

import java.util.List;

public class CategoryFacade {

    private final CategoryDAO categoryDAO;

    public CategoryFacade() {
        this.categoryDAO = new CategoryDAO();
    }

    // Get all categories
    public List<Category> getAll() {
        return categoryDAO.getAllCategories();
    }

    // Get category by ID
    public Category getById(int id) {
        return categoryDAO.getCategoryById(id);
    }

    // Create a new category
    public boolean create(Category category) {
        return categoryDAO.insertCategory(category);
    }

    // Update category
    public boolean update(Category category) {
        return categoryDAO.updateCategory(category);
    }

    // Delete category
    public boolean delete(int id) {
        return categoryDAO.deleteCategory(id);
    }
}
