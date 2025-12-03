/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.controllers;

import com.myshop.facade.CategoryFacade;
import com.myshop.facade.ProductFacade;
import com.myshop.models.Category;
import com.myshop.models.Product;
import java.io.IOException;
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
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    private final ProductFacade productFacade = new ProductFacade();
    private final CategoryFacade categoryFacade = new CategoryFacade();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = (String) request.getAttribute("action");
        String method = request.getMethod();
        switch (action) {
            case "index":
                index(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "edit":
                if ("POST".equalsIgnoreCase(method)) {
                    edit(request, response);
                } else {
                    showEditPage(request, response);
                }
                break;
            case "delete":
                delete(request, response);
                break;
            default:
                index(request, response);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Product> products = null;
            int totalProducts = 0;
            int totalPages = 0;

            List<Category> categories = categoryFacade.getAll();
            request.setAttribute("categories", categories);

            String categoryStr = request.getParameter("category");
            String search = request.getParameter("search");
            String sort = request.getParameter("sort");

            int page = Integer.parseInt((String) request.getAttribute("page"));
            request.setAttribute("currentPage", page);

            if ((categoryStr != null && !categoryStr.isBlank()) || (search != null && !search.isBlank()) || (sort != null && !sort.isBlank())) {
                if (!categoryStr.isBlank()) {
                    int categoryId = Integer.parseInt(categoryStr);
                    if (categoryId != 0) {
                        products = productFacade.filterByCategory(products, categoryId);
                    }
                }
                if (!search.isBlank()) {
                    products = productFacade.searchByName(products, search);
                    request.setAttribute("search", search);
                }

                if (!sort.isBlank()) {
                    products = productFacade.sortByPrice(products, sort.equalsIgnoreCase("desc"));
                    request.setAttribute("sort", sort);
                }
                totalProducts = products.size();
                products = productFacade.paginate(products, page);
            } else {
                products = productFacade.paginate(page);
                totalProducts = productFacade.getAll().size();
            }
            totalPages = (int) Math.ceil((double) totalProducts / Config.PAGESIZE);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("products", products);

            String pageUrl = "/product/index.do?page=" + page + "&search=" + search + "&category=" + categoryStr + "&sort=" + sort;
            request.setAttribute("pageUrl", pageUrl);

        } catch (Exception ex) {
            request.setAttribute("message", ex.getMessage());
            ex.printStackTrace();
        }
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productFacade.getProductById(id);
            request.setAttribute("product", product);
        } catch (Exception ex) {
            request.setAttribute("message", ex.getMessage());
            ex.printStackTrace();
        }
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
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

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String imagePath = request.getParameter("image");

        Category category = categoryFacade.getById(categoryId);

        Product product = new Product(id, name, description, price, discount, quantity, imagePath, category);

        productFacade.updateProduct(product);

        request.getRequestDispatcher("/product/index.do?page=1").forward(request, response);
    }

    private void showEditPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String returnUrl = request.getParameter("returnUrl");

        Product product = productFacade.getProductById(id);
        List<Category> categories = categoryFacade.getAll();

        request.setAttribute("categories", categories);
        request.setAttribute("product", product);
        request.setAttribute("returnUrl", returnUrl);

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
