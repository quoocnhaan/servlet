/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.facade;

/**
 *
 * @author PC
 */
import com.myshop.dao.ProductDAO;
import com.myshop.model.Product;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class ProductFacade {

    private ProductDAO productDAO = new ProductDAO();

    // Get all products
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // Search by name
    public List<Product> searchByName(String keyword) {
        if (keyword == null || keyword.isEmpty()) {
            return getAllProducts();
        }
        return productDAO.getAllProducts().stream()
                .filter(p -> p.getName().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());
    }

    // Filter by category ID
    public List<Product> filterByCategory(int categoryId) {
        return productDAO.getAllProducts().stream()
                .filter(p -> p.getCategory() != null && p.getCategory().getId() == categoryId)
                .collect(Collectors.toList());
    }

    // Sort by price
    public List<Product> sortByPrice(boolean ascending) {
        List<Product> products = productDAO.getAllProducts();
        products.sort(Comparator.comparingDouble(Product::getPrice));
        if (!ascending) {
            Collections.reverse(products);
        }
        return products;
    }

    // Pagination
    public List<Product> paginate(List<Product> products, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, products.size());
        if (fromIndex > toIndex) {
            return Collections.emptyList();
        }
        return products.subList(fromIndex, toIndex);
    }

    // CRUD via DAO
    public boolean addProduct(Product product) {
        return productDAO.insertProduct(product);
    }

    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    public boolean deleteProduct(int id) {
        return productDAO.deleteProduct(id);
    }

    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }
}
