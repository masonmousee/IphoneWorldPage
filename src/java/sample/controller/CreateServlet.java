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
import sample.user.UserDAO;
import sample.user.UserDTO;
import sample.user.UserError;

/**
 *
 * @author LAPTOP
 */
public class CreateServlet extends HttpServlet {

    private static final String ERROR = "create.jsp";
    private static final String SUCCESS = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            boolean check = false;
            UserError userErr = new UserError();

            if (userID.trim().length() < 2 || userID.trim().length() > 20) {
                check = true;
                userErr.setUserIDError("Username is required from 6 to 20 chars");
            }
            if (!password.trim().equals(confirm.trim())) {
                check = true;
                userErr.setConfirmError("Those password does not match");
            }
            if (fullName.trim().length() < 5 || fullName.trim().length() > 50) {
                check = true;
                userErr.setFullNameError("Full name is required from 6 to 20 chars");
            }
            if (roleID.length() < 2 || roleID.length() > 5) {
                check = true;
                userErr.setFullNameError("RoleID is required from 2 to 5 chars");
            }
            if (check) {
                request.setAttribute("USER_ERROR", userErr);
            } else {
                UserDAO dao = new UserDAO();
                UserDTO user = new UserDTO(userID, fullName, roleID, password);
                boolean checkDup = dao.checkDuplicate(userID);
                if (checkDup) {
                    userErr.setUserIDError("UserID is Duplicated : " + userID + " !");
                    request.setAttribute("USER_ERROR", userErr);
                } else {
                    boolean checkInsert = dao.insert(user);
                    if (checkInsert) {
                        url = SUCCESS;
                    } else {
                        userErr.setError("Can not insert, unknow error");
                        request.setAttribute("USER_ERROR", userErr);
                    }
                }
            }
        } catch (Exception e) {
            log("Error at createController: " + e.toString());
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
