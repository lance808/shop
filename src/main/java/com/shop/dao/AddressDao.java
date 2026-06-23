package com.shop.dao;

import com.shop.entity.Address;
import java.util.List;

public interface AddressDao {
    List<Address> selectByUserId(Integer userId);

    Address selectById(Integer id);

    Address selectDefaultByUserId(Integer userId);

    int insert(Address address);

    int update(Address address);

    int deleteById(Integer id);

    int clearDefault(Integer userId);
}
