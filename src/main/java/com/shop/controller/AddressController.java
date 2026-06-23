package com.shop.controller;

import com.shop.entity.Address;
import com.shop.entity.User;
import com.shop.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        model.addAttribute("addresses", addressService.getByUserId(user.getId()));
        return "address_list";
    }

    @RequestMapping("/addPage")
    public String addPage() {
        return "address_form";
    }

    @RequestMapping("/editPage/{id}")
    public String editPage(@PathVariable Integer id, Model model) {
        model.addAttribute("address", addressService.getById(id));
        return "address_form";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String save(Address address, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        address.setUserId(user.getId());
        if (address.getIsDefault() == null) address.setIsDefault(0);
        if (address.getId() != null && address.getId() > 0) {
            addressService.update(address);
        } else {
            addressService.add(address);
        }
        return "redirect:/address/list";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        addressService.delete(id);
        return "redirect:/address/list";
    }
}
