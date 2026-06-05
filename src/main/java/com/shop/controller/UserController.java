package com.shop.controller;

import com.shop.entity.User;
import com.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public String doLogin(String username, String password, HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("loginUser", user);
            if ("admin".equals(user.getRole())) {
                return "redirect:/admin/index";
            }
            return "redirect:/";
        }
        model.addAttribute("error", "用户名或密码错误");
        model.addAttribute("username", username);
        return "login";
    }

    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    public String doRegister(User user, Model model) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            model.addAttribute("error", "用户名不能为空");
            return "register";
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            model.addAttribute("error", "密码不能为空");
            return "register";
        }
        boolean result = userService.register(user);
        if (result) {
            model.addAttribute("msg", "注册成功，请登录");
            return "login";
        }
        model.addAttribute("error", "用户名已存在");
        return "register";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("loginUser");
        if (sessionUser != null) {
            User user = userService.getById(sessionUser.getId());
            model.addAttribute("user", user);
        }
        return "profile";
    }

    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    public String updateProfile(User user, HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("loginUser");
        if (sessionUser != null) {
            user.setId(sessionUser.getId());
            userService.update(user);
            session.setAttribute("loginUser", userService.getById(sessionUser.getId()));
            model.addAttribute("msg", "修改成功");
        }
        return "profile";
    }
}
