/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.controllers;

import com.myshop.facade.OrderFacade;
import com.myshop.models.Cart;
import com.myshop.models.Item;
import com.myshop.models.Order;
import com.myshop.models.OrderItem;
import com.myshop.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

    private final OrderFacade orderFacade = new OrderFacade();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");
        String method = request.getMethod();

        switch (action) {
            case "checkout":
                if ("POST".equalsIgnoreCase(method)) {
                    checkout(request, response);
                } else {
                    showCheckOutPage(request, response);
                }
                break;
            case "edit":
                edit(request, response);
                break;
            case "index":
                index(request, response);
                break;
            case "revenue":
                revenue(request, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            Cart cart = (Cart) session.getAttribute("cart");

            Order order = new Order();
            order.setStatus(Config.NEW);
            order.setUser(user);

            List<OrderItem> items = new ArrayList<>();
            for (Item item : cart.getItems()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setProduct(item.getProduct());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setUnitPrice(item.getProduct().getPriceAfterDiscount());

                items.add(orderItem);
            }
            order.setItems(items);
            orderFacade.createOrder(order);
            cart.empty();
            request.getRequestDispatcher("/").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", e.getMessage());
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Order> orders = orderFacade.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", e.getMessage());
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        orderFacade.updateOrderStatus(id, status);
        response.sendRedirect(request.getContextPath() + "/admin/order.do");
    }

    private void showCheckOutPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        request.setAttribute("cartItems", cart.getItems());
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    private void revenue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        double revenue = orderFacade.revenue(type);
        request.setAttribute("revenue", revenue);
        request.setAttribute("currentType", type);
        request.getRequestDispatcher("/admin/order.do").forward(request, response);
    }

}
