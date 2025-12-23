/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.controllers;

import com.myshop.facade.UserFacade;
import com.myshop.models.User;
import java.io.IOException;
import java.util.Date;
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
@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

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

        String method = request.getMethod();
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "login":
                if ("POST".equalsIgnoreCase(method)) {
                    // process login form submission
                    login(request, response);
                } else {
                    // show login page
                    showLoginPage(request, response);
                }
                break;

            case "register":
                if ("POST".equalsIgnoreCase(method)) {
                    // process register form submission
                    register(request, response);
                } else {
                    // show register page
                    showRegisterPage(request, response);
                }
                break;

            case "logout":
                logout(request, response);
                break;
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String referer = request.getHeader("Referer");

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            UserFacade userFacade = new UserFacade();
            User user = userFacade.login(username, password);
            if (user == null) {
                request.setAttribute("message", "Please check your email and password");
                request.setAttribute("javax.servlet.error.status_code", 401);
                request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
            } else {
                System.out.println("login success");
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                if (user.getRole().equalsIgnoreCase("admin")) {
                    response.sendRedirect(request.getContextPath() + "/admin/product.do");
                } else {
                    response.sendRedirect(request.getContextPath());
                }
            }

        } catch (Exception e) {
            request.setAttribute("message", e.getMessage());
            e.printStackTrace();
            System.out.println("have errors");
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String role = user.getRole();
        session.invalidate();
        if (referer != null && !role.equalsIgnoreCase("admin")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/home/index.do");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                request.setAttribute("message", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
                return;
            }

            UserFacade userFacade = new UserFacade();

            if (userFacade.getUserByUsername(username) != null) {
                request.setAttribute("message", "Username is already taken.");
                request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setUsername(username);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(Config.CUSTOMER);
            user.setCreatedAt(new Date());
            user.setEnabled(true);

            boolean isSuccess = userFacade.register(user);
            if (isSuccess) {
                HttpSession session = request.getSession();
                User currentUser = userFacade.getUserByUsername(username);
                session.setAttribute("user", currentUser);
            }
            response.sendRedirect(request.getContextPath() + "/home/index.do");
        } catch (Exception e) {
            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
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

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

}
