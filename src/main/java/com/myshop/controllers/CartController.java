/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myshop.controllers;

import com.myshop.models.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PHT
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
        switch (action) {
            case "index":
                index(request, response);
                break;
            case "add":
                add(request, response);
                break;
            case "remove":
                remove(request, response);
                break;
            case "empty":
                remove(request, response);
                break;
            case "update":
                update(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //chuyển request & response cho LAYOUT
        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        request.setAttribute("cartItems", cart.getItems());
        request.setAttribute("grandTotal", cart.getTotal());

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //lấy session object
            HttpSession session = request.getSession();
            //lấy cart từ session
            Cart cart = (Cart) session.getAttribute("cart");
            //nếu trong session chưa có cart thì tạo mới
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            //lấy thông tin từ client
            int id = Integer.parseInt(request.getParameter("id"));
            cart.add(id, 1);
        } catch (SQLException ex) {
            //Lưu thông báo lỗi vào request để truyền thông báo lỗi cho view toy.jsp
            request.setAttribute("message", ex.getMessage());
            //In chi tiết lỗi
            ex.printStackTrace();
        }
        //vẫn ở lại trang /home/index.do
        //request.getRequestDispatcher("/home/index.do").forward(request, response);
        request.getRequestDispatcher("/").forward(request, response);
    }

    protected void remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy session object
        HttpSession session = request.getSession();
        //lấy cart từ session
        Cart cart = (Cart) session.getAttribute("cart");
        //lấy id của item
        int id = Integer.parseInt(request.getParameter("id"));
        //remove item
        cart.remove(id);

        request.setAttribute("cartItems", cart.getItems());
        request.setAttribute("grandTotal", cart.getTotal());

        //vẫn ở lại trang giỏ hàng /cart/index.do
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
    }

    protected void empty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy session object
        HttpSession session = request.getSession();
        //lấy cart từ session
        Cart cart = (Cart) session.getAttribute("cart");
        //remove item
        cart.empty();
        //vẫn ở lại trang giỏ hàng /cart/index.do
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy session object
        HttpSession session = request.getSession();
        //lấy cart từ session
        Cart cart = (Cart) session.getAttribute("cart");
        //lấy id, qty của item
        int id = Integer.parseInt(request.getParameter("id"));
        int qty = Integer.parseInt(request.getParameter("qty"));

        //update item
        cart.update(id, qty);

        //vẫn ở lại trang giỏ hàng /cart/index.do
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
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

}
