/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.controllers;

import com.myshop.facade.CategoryFacade;
import com.myshop.facade.ProductFacade;
import com.myshop.models.Category;
import com.myshop.models.Product;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

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
        request.setAttribute("nav", "shop");
        switch (action) {
            case "index":
                index(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "edit":
                edit(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "create":
                create(request, response);
                break;
            default:
                index(request, response);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Category> categories = categoryFacade.getAll();
            request.setAttribute("categories", categories);

            String categoryStr = request.getParameter("category");
            String search = request.getParameter("search");
            String sort = request.getParameter("sort");
            String pageStr = request.getParameter("page");

            int page = 1;
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
            request.setAttribute("currentPage", page);

            List<Product> products = productFacade.getAll();

            if (categoryStr != null && !categoryStr.isBlank()) {
                int categoryId = Integer.parseInt(categoryStr);
                if (categoryId != 0) {
                    products = productFacade.filterByCategory(products, categoryId);
                }
                request.setAttribute("category", categoryStr);
            }

            if (search != null && !search.isBlank()) {
                products = productFacade.searchByName(products, search);
                request.setAttribute("search", search);
            }

            if (sort != null && !sort.isBlank()) {
                boolean desc = sort.equalsIgnoreCase("desc");
                products = productFacade.sortByPrice(products, desc);
                request.setAttribute("sort", sort);
            }

            int totalProducts = products.size();
            int totalPages = (int) Math.ceil((double) totalProducts / Config.PAGESIZE);

            products = productFacade.paginate(products, page);

            request.setAttribute("products", products);
            request.setAttribute("totalPages", totalPages);

            String pageUrl = "/product/index.do"
                    + "?search=" + (search != null ? search : "")
                    + "&category=" + (categoryStr != null ? categoryStr : "")
                    + "&sort=" + (sort != null ? sort : "");

            request.setAttribute("pageUrl", pageUrl);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message", ex.getMessage());
        }

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

//    protected void index(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        try {
//            List<Product> products = null;
//            int totalProducts = 0;
//            int totalPages = 0;
//
//            List<Category> categories = categoryFacade.getAll();
//            request.setAttribute("categories", categories);
//
//            String categoryStr = request.getParameter("category");
//            String search = request.getParameter("search");
//            String sort = request.getParameter("sort");
//
//            int page = Integer.parseInt((String) request.getAttribute("page"));
//            request.setAttribute("currentPage", page);
//
//            if ((categoryStr != null && !categoryStr.isBlank()) || (search != null && !search.isBlank()) || (sort != null && !sort.isBlank())) {
//                if (!categoryStr.isBlank()) {
//                    int categoryId = Integer.parseInt(categoryStr);
//                    if (categoryId != 0) {
//                        products = productFacade.filterByCategory(products, categoryId);
//                    }
//                }
//                if (!search.isBlank()) {
//                    products = productFacade.searchByName(products, search);
//                    request.setAttribute("search", search);
//                }
//
//                if (!sort.isBlank()) {
//                    products = productFacade.sortByPrice(products, sort.equalsIgnoreCase("desc"));
//                    request.setAttribute("sort", sort);
//                }
//                totalProducts = products.size();
//                products = productFacade.paginate(products, page);
//            } else {
//                products = productFacade.paginate(page);
//                totalProducts = productFacade.getAll().size();
//            }
//            totalPages = (int) Math.ceil((double) totalProducts / Config.PAGESIZE);
//            request.setAttribute("totalPages", totalPages);
//
//            request.setAttribute("products", products);
//
//            String pageUrl = "/product/index.do?page=" + page + "&search=" + search + "&category=" + categoryStr + "&sort=" + sort;
//            request.setAttribute("pageUrl", pageUrl);
//
//        } catch (Exception ex) {
//            request.setAttribute("message", ex.getMessage());
//            ex.printStackTrace();
//        }
//        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
//    }
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
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Category category = categoryFacade.getById(categoryId);

            String imagePath = request.getParameter("image");

            Product product = new Product(id, name, description, price, discount, quantity, imagePath, category);

            boolean success = productFacade.updateProduct(product);

            if (!success) {
                request.getSession().setAttribute("message", "Failed to create product.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/product.do");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String returnUrl = request.getParameter("returnUrl");

        productFacade.deleteProduct(id);
        request.getRequestDispatcher(returnUrl).forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        try {
            // 1. Read form fields
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String image = request.getParameter("image");
            double discount = Double.parseDouble(request.getParameter("discount"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // 2. Create product object
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setDiscount(discount);
            product.setQuantity(quantity);

            // 3. Set category
            Category category = new Category();
            category.setId(categoryId);
            product.setCategory(category);

            // 4. Handle image upload
            product.setImagePath("/images/products/" + image);

            // 5. Insert using your existing DAO (unchanged)
            boolean success = productFacade.addProduct(product);

            if (!success) {
                request.getSession().setAttribute("message", "Failed to create product.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/product.do");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error/index.jsp").forward(request, response);
        }
    }
}
