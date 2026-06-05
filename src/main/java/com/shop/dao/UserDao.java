package com.shop.dao;

import com.shop.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {
    User selectByUsername(String username);

    User selectById(Integer id);

    int insert(User user);

    int update(User user);

    User selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
}
