package com.shop.service.impl;

import com.shop.dao.CartDao;
import com.shop.entity.Cart;
import com.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDao cartDao;

    @Override
    public List<Cart> getByUserId(Integer userId) {
        return cartDao.selectWithProduct(userId);
    }

    @Override
    public boolean add(Cart cart) {
        Cart exist = cartDao.selectByUserIdAndProductId(cart.getUserId(), cart.getProductId());
        if (exist != null) {
            return cartDao.updateQuantity(exist.getId(), exist.getQuantity() + cart.getQuantity()) > 0;
        }
        return cartDao.insert(cart) > 0;
    }

    @Override
    public boolean updateQuantity(Integer id, Integer quantity) {
        return cartDao.updateQuantity(id, quantity) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        return cartDao.deleteById(id) > 0;
    }

    @Override
    public boolean clearByUserId(Integer userId) {
        return cartDao.deleteByUserId(userId) > 0;
    }
}
