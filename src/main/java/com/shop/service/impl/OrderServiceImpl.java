package com.shop.service.impl;

import com.shop.dao.CartDao;
import com.shop.dao.OrderDao;
import com.shop.dao.OrderItemDao;
import com.shop.dao.ProductDao;
import com.shop.entity.Cart;
import com.shop.entity.Order;
import com.shop.entity.OrderItem;
import com.shop.entity.Product;
import com.shop.service.OrderService;
import com.shop.util.OrderNoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private OrderItemDao orderItemDao;

    @Autowired
    private CartDao cartDao;

    @Autowired
    private ProductDao productDao;

    @Override
    public Order getById(Integer id) {
        Order order = orderDao.selectById(id);
        if (order != null) {
            order.setItems(orderItemDao.selectByOrderId(id));
        }
        return order;
    }

    @Override
    public List<Order> getByUserId(Integer userId) {
        return orderDao.selectByUserId(userId);
    }

    @Override
    public List<Order> getAll() {
        return orderDao.selectAll();
    }

    @Override
    @Transactional
    public boolean create(Order order, List<Integer> cartIds) {
        BigDecimal total = BigDecimal.ZERO;
        for (Integer cartId : cartIds) {
            Cart cart = cartDao.selectWithProduct(order.getUserId())
                    .stream().filter(c -> c.getId().equals(cartId)).findFirst().orElse(null);
            if (cart == null) continue;
            Product product = productDao.selectById(cart.getProductId());
            if (product == null || product.getStock() < cart.getQuantity() || product.getStatus() == 0) {
                throw new RuntimeException("商品【" + product.getName() + "】库存不足或已下架");
            }
            total = total.add(product.getPrice().multiply(new BigDecimal(cart.getQuantity())));
        }

        String orderNo = OrderNoUtil.generate();
        order.setOrderNo(orderNo);
        order.setTotalPrice(total);
        order.setStatus("pending");
        orderDao.insert(order);

        for (Integer cartId : cartIds) {
            Cart cart = cartDao.selectWithProduct(order.getUserId())
                    .stream().filter(c -> c.getId().equals(cartId)).findFirst().orElse(null);
            if (cart == null) continue;
            Product product = productDao.selectById(cart.getProductId());

            OrderItem item = new OrderItem();
            item.setOrderId(order.getId());
            item.setProductId(product.getId());
            item.setProductName(product.getName());
            item.setProductPrice(product.getPrice());
            item.setQuantity(cart.getQuantity());
            item.setTotalPrice(product.getPrice().multiply(new BigDecimal(cart.getQuantity())));
            orderItemDao.insert(item);

            productDao.updateStock(product.getId(), cart.getQuantity());
            cartDao.deleteById(cartId);
        }

        return true;
    }

    @Override
    public boolean updateStatus(Integer id, String status) {
        Order order = new Order();
        order.setId(id);
        order.setStatus(status);
        if ("paid".equals(status)) {
            order.setPayTime(new Date());
        }
        return orderDao.updateStatus(order) > 0;
    }

    @Override
    @Transactional
    public boolean cancel(Integer id) {
        Order order = orderDao.selectById(id);
        if (order == null || !"pending".equals(order.getStatus())) {
            return false;
        }
        order.setStatus("cancelled");
        orderDao.updateStatus(order);

        List<OrderItem> items = orderItemDao.selectByOrderId(id);
        for (OrderItem item : items) {
            Product product = productDao.selectById(item.getProductId());
            if (product != null) {
                product.setStock(product.getStock() + item.getQuantity());
                productDao.update(product);
            }
        }
        return true;
    }
}
