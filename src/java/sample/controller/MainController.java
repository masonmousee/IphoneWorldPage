/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String SHOPPING_PAGE = "shopping.jsp";
    private static final String LOGIN = "Login";
    private static final String LOGIN_SERVLET = "LoginServlet";
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_SERVLET = "LogoutServlet";
    private static final String SEARCH = "Search";
    private static final String SEARCH_SERVLET = "ShowServlet";
    private static final String ADD = "Add to Cart";
    private static final String ADD_SERVLET = "AddServlet";
    private static final String HOME = "home";
    private static final String SHOW_ALL_SERVLET = "ShowAllServlet";
    private static final String VIEW = "view";
    private static final String VIEWCART = "viewCart.jsp";
    private static final String REMOVE = "remove";
    private static final String REMOVE_SERVLET = "RemoveServlet";
    private static final String EDIT = "edit";
    private static final String EDIT_SERVLET = "EditServlet";
    private static final String CHECKOUT = "Check out";
    private static final String INVOICE_SERLVET = "InvoiceServlet";
    private static final String CONFRIM = "Confirm";
    private static final String CHECKOUT_SERVLET = "CheckoutServlet";
    private static final String CREATE = "Create";
    private static final String CREATE_SERVLET = "CreateServlet";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = SHOPPING_PAGE;
        try {
            if (action == null) {
                url = SHOW_ALL_SERVLET;
            } else if (LOGIN.equals(action)) {
                url = LOGIN_SERVLET;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_SERVLET;
            } else if (SEARCH.equals(action)) {
                url = SEARCH_SERVLET;
            } else if (ADD.equals(action)) {
                url = ADD_SERVLET;
            } else if (HOME.equals(action)) {
                url = SHOW_ALL_SERVLET;
            } else if (VIEW.equals(action)) {
                url = VIEWCART;
            } else if (REMOVE.equals(action)) {
                url = REMOVE_SERVLET;
            } else if (EDIT.equals(action)) {
                url = EDIT_SERVLET;
            } else if (CHECKOUT.equals(action)) {
                url = CHECKOUT_SERVLET;
            } else if (CREATE.equals(action)) {
                url = CREATE_SERVLET;
            }else if(CONFRIM.equals(action)){
                url  = INVOICE_SERLVET;
            }

        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

}
