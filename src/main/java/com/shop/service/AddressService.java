package com.shop.service;

import com.shop.entity.Address;
import java.util.List;

public interface AddressService {
    List<Address> getByUserId(Integer userId);

    Address getById(Integer id);

    Address getDefault(Integer userId);

    boolean add(Address address);

    boolean update(Address address);

    boolean delete(Integer id);
}
