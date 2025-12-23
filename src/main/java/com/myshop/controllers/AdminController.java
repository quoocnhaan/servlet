/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.controllers;

import com.myshop.facade.CategoryFacade;
import com.myshop.facade.OrderFacade;
import com.myshop.facade.ProductFacade;
import com.myshop.models.Category;
import com.myshop.models.Order;
import com.myshop.models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    private final CategoryFacade categoryFacade = new CategoryFacade();
    private final ProductFacade productFacade = new ProductFacade();
    private final OrderFacade orderFacade = new OrderFacade();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "product":
                product(request, response);
                break;
            case "order":
                order(request, response);
                break;
            default:
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

    private void product(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Category> categories = categoryFacade.getAll();
            request.setAttribute("categories", categories);

            List<Product> products = productFacade.getAll();
            request.setAttribute("products", products);

            request.setAttribute("total", products.size());

            request.setAttribute("outStock", productFacade.getOutOfStock());
            
            request.setAttribute("nav", "product");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }

    private void order(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Order> orders = orderFacade.getAllOrders();
            request.setAttribute("orders", orders);
            
            request.setAttribute("nav", "order");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", e.getMessage());
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);

        }
    }

}
