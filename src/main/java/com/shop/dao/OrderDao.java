package com.shop.dao;

import com.shop.entity.Order;
import java.util.List;

public interface OrderDao {
    Order selectById(Integer id);

    Order selectByOrderNo(String orderNo);

    List<Order> selectByUserId(Integer userId);

    List<Order> selectAll();

    int insert(Order order);

    int updateStatus(Order order);
}
