package com.shop.service;

import com.shop.entity.User;

public interface UserService {
    User login(String username, String password);

    boolean register(User user);

    User getById(Integer id);

    User getByUsername(String username);

    boolean update(User user);
}
