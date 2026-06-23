package com.shop.service.impl;

import com.shop.dao.AddressDao;
import com.shop.entity.Address;
import com.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressDao addressDao;

    @Override
    public List<Address> getByUserId(Integer userId) {
        return addressDao.selectByUserId(userId);
    }

    @Override
    public Address getById(Integer id) {
        return addressDao.selectById(id);
    }

    @Override
    public Address getDefault(Integer userId) {
        return addressDao.selectDefaultByUserId(userId);
    }

    @Override
    public boolean add(Address address) {
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            addressDao.clearDefault(address.getUserId());
        }
        return addressDao.insert(address) > 0;
    }

    @Override
    public boolean update(Address address) {
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            addressDao.clearDefault(address.getUserId());
        }
        return addressDao.update(address) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        return addressDao.deleteById(id) > 0;
    }
}
