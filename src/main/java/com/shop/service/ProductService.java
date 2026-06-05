package com.shop.service;

import com.shop.entity.Product;
import java.util.List;

public interface ProductService {
    Product getById(Integer id);

    List<Product> getAll();

    List<Product> getByCategoryId(Integer categoryId);

    List<Product> search(String keyword);

    List<Product> query(String name, Integer categoryId);

    boolean add(Product product);

    boolean update(Product product);

    boolean delete(Integer id);

    // 分页查询
    List<Product> getAll(int offset, int limit);

    int countAll();

    List<Product> getByCategoryId(Integer categoryId, int offset, int limit);

    int countByCategoryId(Integer categoryId);

    List<Product> search(String keyword, int offset, int limit);

    int countByKeyword(String keyword);
}
