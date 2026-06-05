package com.shop.dao;

import com.shop.entity.OrderItem;
import java.util.List;

public interface OrderItemDao {
    List<OrderItem> selectByOrderId(Integer orderId);

    int insert(OrderItem orderItem);

    int deleteByOrderId(Integer orderId);
}
