package com.shop.service.impl;

import com.shop.dao.UserDao;
import com.shop.entity.User;
import com.shop.service.UserService;
import com.shop.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User login(String username, String password) {
        User user = userDao.selectByUsername(username);
        if (user != null && PasswordUtil.verify(password, user.getPassword())) {
            if (user.getStatus() == 0) {
                return null;
            }
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        User exist = userDao.selectByUsername(user.getUsername());
        if (exist != null) {
            return false;
        }
        user.setPassword(PasswordUtil.md5(user.getPassword()));
        user.setRole("user");
        user.setStatus(1);
        return userDao.insert(user) > 0;
    }

    @Override
    public User getById(Integer id) {
        return userDao.selectById(id);
    }

    @Override
    public User getByUsername(String username) {
        return userDao.selectByUsername(username);
    }

    @Override
    public boolean update(User user) {
        return userDao.update(user) > 0;
    }
}
