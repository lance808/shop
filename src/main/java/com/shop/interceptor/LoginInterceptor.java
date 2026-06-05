package com.shop.interceptor;

import com.shop.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return false;
        }
        return true;
    }
}
