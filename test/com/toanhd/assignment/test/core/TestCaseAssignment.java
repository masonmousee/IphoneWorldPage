/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.toanhd.assignment.test.core;

import java.sql.Connection;
import java.sql.SQLException;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Test;
import sample.shopping.Cart;
import sample.shopping.Item;
import sample.shopping.Order;
import sample.shopping.Product;
import sample.shopping.User;
import sample.ultis.DBUtils;

/**
 *
 * @author maseh
 */
public class TestCaseAssignment {

    @Test
    public void testContainsOrder() {
        Cart cart = new Cart();
        Order order1 = new Order(1, "1/1/2001", "admin", 11, "tytytytyty", "0868879");
        Order order2 = new Order(2, "10/1/2002", "admin", 12, "tyty", "0868879");

        // Thêm đơn hàng vào giỏ hàng
        cart.addOrder(order2);

        // Kiểm tra xem giỏ hàng có chứa đơn hàng order1 hay không
        assertTrue(cart.containsOrder(order1));

        // Kiểm tra xem giỏ hàng không chứa đơn hàng order2 (chưa được thêm)
        assertFalse(cart.containsOrder(order2));
    }

    @Test
    public void testGettersAndSetters() {
        // Tạo một đối tượng Product để kiểm tra
        Product product = new Product();

        // Đặt giá trị cho các thuộc tính
        product.setId("123");
        product.setName("Product 1");
        product.setPrice(10.99);
        product.setQuantity(5);
        product.setImg("product_image.jpg");

        // Kiểm tra các getter có trả về giá trị đúng không
        assertEquals("123", product.getId());
        assertEquals("Product 1", product.getName());
        assertEquals(10.99, product.getPrice(), 0.001);
        assertEquals(6, product.getQuantity());
        assertEquals("product_image.jpg", product.getImg());
    }
    
    @Test
    public void testGetConnectionV1() throws ClassNotFoundException {
        try {
            Connection conn = DBUtils.getConnectionV1();
            
            // Kiểm tra xem đối tượng kết nối không phải là null
            assertNotNull(conn);
            
            // Kiểm tra xem đối tượng kết nối có mở thành công hay không
            assertFalse(conn.isClosed());
            
            // Đóng kết nối
            conn.close();
            
            // Kiểm tra xem đối tượng kết nối đã đóng hay chưa
            assertTrue(conn.isClosed());
        } catch (SQLException e) {
            fail("Không nên có lỗi khi lấy kết nối từ getConnectionV1");
        }
    }
}

