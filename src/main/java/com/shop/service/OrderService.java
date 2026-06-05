package com.shop.service;

import com.shop.entity.Order;
import java.util.List;

public interface OrderService {
    Order getById(Integer id);

    List<Order> getByUserId(Integer userId);

    List<Order> getAll();

    boolean create(Order order, List<Integer> cartIds);

    boolean updateStatus(Integer id, String status);

    boolean cancel(Integer id);
}
