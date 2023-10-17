/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import sample.shopping.Cart;
import sample.shopping.Item;

import sample.shopping.Product;
import sample.ultis.DBUtils;

/**
 *
 * @author LAPTOP
 */
public class UserDAO {

    private static final String LOGIN = "SELECT fullName, roleID FROM tblUsers WHERE userID = ? AND password = ?";
    private static final String SEARCH = "SELECT userID, fullName, roleID  FROM tblUsers WHERE fullName like  ?";
    private static final String DELETE = "DELETE tblUsers WHERE userID = ?";
    private static final String UPDATE = "UPDATE tblUsers SET fullName = ? , roleID = ? WHERE userID = ? ";
    private static final String CHECK_DUPLICATE = "SELECT fullName FROM tblUsers WHERE userID = ?";
    private static final String INSERT = "INSERT INTO tblUsers(userID, fullName, roleID, password) VALUES(?,?,?,?)";

    public UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, userID);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    user = new UserDTO(userID, fullName, roleID, "");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public List<UserDTO> getListUser(String search) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String password = "***";
                    list.add(new UserDTO(userID, fullName, roleID, password));

                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public boolean delete(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean update(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, user.getFullName());
                ptm.setString(2, user.getRoleID());
                ptm.setString(3, user.getUserID());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean insert(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, user.getUserID());
                ptm.setString(2, user.getFullName());
                ptm.setString(3, user.getRoleID());
                ptm.setString(4, user.getPassword());

                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<Product> getAll() throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                String sql = "SELECT * FROM tblProduct ";
                ptm = conn.prepareStatement(sql);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    Product p = new Product(rs.getString("id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            rs.getString("img"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;

    }

    public List<Product> getProduct(String search) throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                String sql = "SELECT id,name,price,quantity,img FROM tblProduct WHERE name like ?";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    Product p = new Product(rs.getString("id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            rs.getString("img"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public Product getProductByID(String id) throws SQLException {
        Product product = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                String sql = "SELECT * FROM tblProduct WHERE id = ?";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, id);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String img = rs.getString("img");
                    product = new Product(id, name, price, quantity, img);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return product;

    }

    public void addOrder(UserDTO u, Cart cart, String userName, String phoneNumer, String shippingAddress) throws SQLException, ClassNotFoundException {
        LocalDateTime curDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        String formattedDateTime = curDateTime.format(formatter);
        Connection conn = null;
        PreparedStatement ptm1 = null;
        PreparedStatement ptm2 = null;
        ResultSet rs1 = null;
        try {
            conn = DBUtils.getConnectionV1();
            if (conn != null) {
                String sql = "INSERT INTO tblOrder(date, uid, total, userName, phoneNumber, shippingAddress) VALUES(?,?,?,?,?,?)";
                PreparedStatement ptm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ptm.setString(1, formattedDateTime);
                ptm.setString(2, u.getUserID());
                ptm.setDouble(3, cart.getTotalMoney());
                ptm.setString(4, userName);
                ptm.setString(5, phoneNumer);
                ptm.setString(6, shippingAddress);
                int affectedRows1 = ptm.executeUpdate();
                if (affectedRows1 == 0) {
                    throw new SQLException("Inserting order failed, no rows affected.");
                }

                ResultSet generatedKeys = ptm.getGeneratedKeys();
                int latestOrderIdInt = 0;
                if (generatedKeys.next()) {
                    latestOrderIdInt = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Inserting order failed, no ID obtained.");
                }

                for (Product p : cart.getCart().values()) {
                    String sql2 = "INSERT INTO tblOrderDetail(oid, pid, quantity, price) VALUES(?,?,?,?)";
                    ptm1 = conn.prepareStatement(sql2);
                    ptm1.setInt(1, latestOrderIdInt);
                    ptm1.setString(2, p.getId());
                    ptm1.setInt(3, p.getQuantity());
                    ptm1.setDouble(4, p.getPrice());
                    int affectedRows2 = ptm1.executeUpdate();
                    if (affectedRows2 == 0) {
                        throw new SQLException("Inserting order detail failed, no rows affected.");
                    }

                    String updateQuantitySql = "UPDATE tblProduct SET quantity = quantity - ? WHERE id = ?";
                    ptm2 = conn.prepareStatement(updateQuantitySql);
                    ptm2.setInt(1, p.getQuantity());
                    ptm2.setString(2, p.getId());
                    int affectedRows3 = ptm2.executeUpdate();
                    if (affectedRows3 == 0) {
                        throw new SQLException("Updating product quantity failed, no rows affected.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ptm1 != null) {
                    ptm1.close();
                }
                if (ptm2 != null) {
                    ptm2.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
// }
}
