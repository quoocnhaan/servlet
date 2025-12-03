/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.dao;

/**
 *
 * @author PC
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.myshop.facade.ProductFacade;
import com.myshop.models.Order;
import com.myshop.models.OrderItem;
import com.myshop.models.Product;
import com.myshop.models.User;
import com.myshop.util.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PHT
 */
public class OrderDAO {

    public void insert(Order order) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stmHeader = null;
        PreparedStatement stmDetail = null;

        try {
            con = DBContext.getConnection();
            con.setAutoCommit(false);

            String sqlHeader = "INSERT INTO Orders (status, userId, totalamount) VALUES (?, ?, ?)";
            stmHeader = con.prepareStatement(sqlHeader, Statement.RETURN_GENERATED_KEYS);
            stmHeader.setString(1, order.getStatus());
            stmHeader.setInt(2, order.getUser().getId());
            stmHeader.setDouble(3, order.getTotal());

            int count = stmHeader.executeUpdate();
            if (count == 0) {
                throw new SQLException("Inserting order failed, no rows affected.");
            }

            try (ResultSet rs = stmHeader.getGeneratedKeys()) {
                if (rs.next()) {
                    order.setId(rs.getInt(1));
                } else {
                    throw new SQLException("Inserting order failed, no ID obtained.");
                }
            }

            String sqlDetail = "INSERT INTO OrderItems (orderId, productId, quantity, unitprice) VALUES (?, ?, ?, ?)";
            stmDetail = con.prepareStatement(sqlDetail);
            for (OrderItem item : order.getItems()) {
                stmDetail.setInt(1, order.getId());
                stmDetail.setInt(2, item.getProduct().getId());
                stmDetail.setInt(3, item.getQuantity());
                stmDetail.setDouble(4, item.getProduct().getPriceAfterDiscount());
                stmDetail.executeUpdate();
            }

            con.commit();

        } catch (SQLException ex) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            throw ex;
        } finally {
            if (stmHeader != null) {
                stmHeader.close();
            }
            if (stmDetail != null) {
                stmDetail.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean updateStatus(int orderId, String status) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";

        try (Connection con = DBContext.getConnection(); PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, status);
            stm.setInt(2, orderId);

            int rows = stm.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Updating order status failed, no rows affected.");
            }
            return rows > 0;
        }
    }

    // GET by ID
    public Order getById(int orderId) throws ClassNotFoundException, SQLException {
        String sqlHeader = "SELECT * FROM Orders WHERE id = ?";
        String sqlDetail = "SELECT * FROM OrderItems WHERE orderId = ?";
        Order order = null;
        ProductFacade productFacade = new ProductFacade();

        try (Connection con = DBContext.getConnection(); PreparedStatement stmHeader = con.prepareStatement(sqlHeader)) {

            stmHeader.setInt(1, orderId);
            try (ResultSet rsHeader = stmHeader.executeQuery()) {
                if (rsHeader.next()) {
                    order = new Order();
                    order.setId(rsHeader.getInt("id"));
                    order.setStatus(rsHeader.getString("status"));

                    User user = new User();
                    user.setId(rsHeader.getInt("userId"));
                    order.setUser(user);

                    order.setStatus(rsHeader.getString("status"));

                    order.setOrderDate(rsHeader.getTimestamp("OrderDate"));

                    // Get details
                    try (PreparedStatement stmDetail = con.prepareStatement(sqlDetail)) {
                        stmDetail.setInt(1, orderId);
                        try (ResultSet rsDetail = stmDetail.executeQuery()) {
                            List<OrderItem> items = new ArrayList<>();
                            while (rsDetail.next()) {
                                OrderItem item = new OrderItem();
                                Product p = productFacade.getProductById(rsDetail.getInt("productId"));
                                item.setProduct(p);
                                item.setQuantity(rsDetail.getInt("quantity"));
                                item.setUnitPrice(p.getPriceAfterDiscount());

                                items.add(item);
                            }
                            order.setItems(items);
                        }
                    }
                }
            }
        }

        return order;
    }

    // GET all orders
    public List<Order> getAll() throws ClassNotFoundException, SQLException {
        List<Order> orders = new ArrayList<>();
        String sqlHeader = "SELECT id FROM Orders";

        try (Connection con = DBContext.getConnection(); PreparedStatement stm = con.prepareStatement(sqlHeader); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                int orderId = rs.getInt("id");
                orders.add(getById(orderId)); // reuse getById
            }
        }
        return orders;
    }
}
