/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myshop.controllers;

import com.myshop.models.Cart;
import com.myshop.models.User;
import java.io.IOException;
import java.sql.SQLException;
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
        request.setAttribute("nav", "cart");
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
                empty(request, response);
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
        String referer = request.getHeader("Referer");

        try {
            //lấy session object
            HttpSession session = request.getSession();

            User user = (User) session.getAttribute("user");
            if (user == null) {
                request.getRequestDispatcher("/user/login.do").forward(request, response);
            }

            //lấy cart từ session
            Cart cart = (Cart) session.getAttribute("cart");
            //nếu trong session chưa có cart thì tạo mới
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            //lấy thông tin từ client
            int id = Integer.parseInt(request.getParameter("id"));
            String qtyStr = request.getParameter("qty");
            if (qtyStr == null) {
                cart.add(id, 1);
            } else {
                cart.add(id, Integer.parseInt(qtyStr));
            }

            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                // fallback if no referer header exists
                response.sendRedirect(request.getContextPath() + "/home/index.do");
            }

        } catch (SQLException ex) {
            //Lưu thông báo lỗi vào request để truyền thông báo lỗi cho view toy.jsp
            request.setAttribute("message", ex.getMessage());
            //In chi tiết lỗi
            ex.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
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

        //vẫn ở lại trang giỏ hàng /cart/index.do
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
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
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
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
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
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
