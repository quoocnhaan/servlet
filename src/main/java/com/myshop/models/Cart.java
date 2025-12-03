/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myshop.models;

import com.myshop.facade.ProductFacade;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author PHT
 */
public class Cart {

    private Map<Integer, Item> map;

    public Cart() {
        this.map = new HashMap<>();
    }

    public void add(int id, int quantity) throws SQLException {
        Item item = this.map.get(id);
        if (item == null) {
            //neu item chua co trong cart them item moi vao cart
            ProductFacade pf = new ProductFacade();
            Product product = pf.getProductById(id);
            item = new Item(product, quantity);
            map.put(id, item);
        } else {
            //neu item da co trong cart thi chi tang quantity
            item.setQuantity(item.getQuantity() + quantity);
        }
    }

    public void remove(int id) {
        this.map.remove(id);
    }

    public Collection<Item> getItems() {
        return map.values();
    }

    public double getTotal() {
        double sum = 0;
        for (Item item : map.values()) {
            sum += item.getQuantity() * item.getProduct().getPriceAfterDiscount();
        }
        return sum;
    }

    public void empty() {
        map.clear();
    }

    public void update(int id, int qty) {
        Item item = this.map.get(id);
        item.setQuantity(qty);
    }

    public int getSize() {
        return map.size();
    }
}
