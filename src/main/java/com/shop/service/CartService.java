package com.shop.service;

import com.shop.entity.Cart;
import java.util.List;

public interface CartService {
    List<Cart> getByUserId(Integer userId);

    boolean add(Cart cart);

    boolean updateQuantity(Integer id, Integer quantity);

    boolean delete(Integer id);

    boolean clearByUserId(Integer userId);
}
