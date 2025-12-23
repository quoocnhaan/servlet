/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.facade;

/**
 *
 * @author PC
 */
import com.myshop.controllers.Config;
import com.myshop.dao.ProductDAO;
import com.myshop.models.Product;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class ProductFacade {

    private ProductDAO productDAO = new ProductDAO();

    // Get all products
    public List<Product> getAll() {
        return productDAO.getAllProducts();
    }

    public List<Product> getNewArrivals() {
        return productDAO.getAllProducts()
                .stream()
                .filter(Product::isNewArrival)
                .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                .collect(Collectors.toList());
    }

    public List<Product> getDiscountProducts() {
        return productDAO.getAllProducts()
                .stream()
                .filter(p -> p.getDiscount() > 0)
                .collect(Collectors.toList());
    }

    public int getOutOfStock() {
        return (int) productDAO.getAllProducts()
                .stream()
                .filter(p -> p.getQuantity() == 0)
                .count();
    }

    // Search by name
    public List<Product> searchByName(List<Product> products, String keyword) {
        if (products == null) {
            products = getAll();
        }
        if (keyword == null || keyword.isEmpty()) {
            return products;
        }
        return products.stream()
                .filter(p -> p.getName().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());
    }

    // Filter by category ID
    public List<Product> filterByCategory(List<Product> products, int categoryId) {
        if (products == null) {
            return productDAO.getAllProducts().stream()
                    .filter(p -> p.getCategory() != null && p.getCategory().getId() == categoryId)
                    .collect(Collectors.toList());
        }
        return products.stream()
                .filter(p -> p.getCategory() != null && p.getCategory().getId() == categoryId)
                .collect(Collectors.toList());
    }

    // Sort by price
    public List<Product> sortByPrice(List<Product> products, boolean desc) {
        if (products == null) {
            products = getAll();
        }
        products.sort(Comparator.comparingDouble(Product::getPriceAfterDiscount));
        if (desc) {
            Collections.reverse(products);
        }
        return products;
    }

    // Pagination
    public List<Product> paginate(int page) {
        return productDAO.getProductsPaginated(page);
    }

    public List<Product> paginate(List<Product> products, int page) {
        int fromIndex = (page - 1) * Config.PAGESIZE;
        int toIndex = Math.min((fromIndex + Config.PAGESIZE), products.size());
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
