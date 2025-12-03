/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.facade;

/**
 *
 * @author PC
 */
import com.myshop.dao.UserDAO;
import com.myshop.models.User;
import java.util.Date;
import java.util.List;

public class UserFacade {

    private UserDAO userDAO = new UserDAO();

    // Register a new user
    public boolean register(User user) {
        user.setCreatedAt(new Date());
        user.setEnabled(true);
        try {
            return userDAO.create(user);
        } catch (Exception e) {
            return false;
        }
    }

    public User login(String username, String password) {
        try {
            return userDAO.getByUserNameAndPassword(username, password);
        } catch (Exception e) {
            return null;
        }
    }

    // Get user by ID
    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    // Get user by username
    public User getUserByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    // Update user
    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    // Delete user
    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }

    // List all users
    public List<User> listAllUsers() {
        return userDAO.findAll();
    }
}
