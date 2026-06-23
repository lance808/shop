package com.shop.service.impl;

import com.shop.dao.ProductDao;
import com.shop.entity.Product;
import com.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public Product getById(Integer id) {
        return productDao.selectById(id);
    }

    @Override
    public List<Product> getAll() {
        return productDao.selectAll();
    }

    @Override
    public List<Product> getByCategoryId(Integer categoryId) {
        return productDao.selectByCategoryId(categoryId);
    }

    @Override
    public List<Product> search(String keyword) {
        return productDao.selectByKeyword(keyword);
    }

    @Override
    public List<Product> query(String name, Integer categoryId) {
        return productDao.selectWithCategory(name, categoryId);
    }

    @Override
    public boolean add(Product product) {
        return productDao.insert(product) > 0;
    }

    @Override
    public boolean update(Product product) {
        return productDao.update(product) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        return productDao.deleteById(id) > 0;
    }

    // ========== 分页查询 ==========

    @Override
    public List<Product> getAll(int offset, int limit) {
        return productDao.selectAllWithPage(offset, limit);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }

    @Override
    public List<Product> getByCategoryId(Integer categoryId, int offset, int limit) {
        return productDao.selectByCategoryIdWithPage(categoryId, offset, limit);
    }

    @Override
    public int countByCategoryId(Integer categoryId) {
        return productDao.countByCategoryId(categoryId);
    }

    @Override
    public List<Product> search(String keyword, int offset, int limit) {
        return productDao.selectByKeywordWithPage(keyword, offset, limit);
    }

    @Override
    public int countByKeyword(String keyword) {
        return productDao.countByKeyword(keyword);
    }

    // ========== 后台统计 ==========

    @Override
    public int countByStatus(int status) {
        return productDao.countByStatus(status);
    }

    @Override
    public int sumSales() {
        return productDao.sumSales();
    }

    @Override
    public int sumStock() {
        return productDao.sumStock();
    }

    @Override
    public List<Product> getTopSales(int limit) {
        return productDao.selectTopSales(limit);
    }

    @Override
    public int countOrdersByStatus(String status) {
        return productDao.countOrdersByStatus(status);
    }

    @Override
    public java.math.BigDecimal sumOrderTotal() {
        return productDao.sumOrderTotal();
    }

    @Override
    public int countUsers() {
        return productDao.countUsers();
    }
}
