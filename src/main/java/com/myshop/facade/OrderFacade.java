/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.facade;

/**
 *
 * @author PC
 */
import com.myshop.dao.OrderDAO;
import com.myshop.models.Order;
import java.sql.SQLException;

import java.util.List;

public class OrderFacade {

    private final OrderDAO orderDAO;

    public OrderFacade() {
        this.orderDAO = new OrderDAO();
    }

    /**
     * Create a new order
     */
    public void createOrder(Order order) throws ClassNotFoundException, SQLException {
        if (order == null || order.getItems() == null || order.getItems().isEmpty()) {
            throw new IllegalArgumentException("Order or order items cannot be null/empty");
        }
        orderDAO.insert(order);
    }

    /**
     * Update only the status of an order
     */
    public boolean updateOrderStatus(int orderId, String status) throws ClassNotFoundException, SQLException {
        if (status == null || status.isEmpty()) {
            throw new IllegalArgumentException("Status cannot be null or empty");
        }
        return orderDAO.updateStatus(orderId, status);
    }

    /**
     * Get a single order by ID
     */
    public Order getOrderById(int orderId) throws ClassNotFoundException, SQLException {
        return orderDAO.getById(orderId);
    }

    /**
     * Get all orders
     */
    public List<Order> getAllOrders() throws ClassNotFoundException, SQLException {
        return orderDAO.getAll();
    }

    /**
     * Example business method: get orders by status
     */
    public List<Order> getOrdersByStatus(String status) throws ClassNotFoundException, SQLException {
        List<Order> allOrders = orderDAO.getAll();
        return allOrders.stream()
                .filter(order -> order.getStatus().equalsIgnoreCase(status))
                .toList();
    }
}
