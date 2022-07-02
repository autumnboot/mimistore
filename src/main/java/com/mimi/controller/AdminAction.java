package com.mimi.controller;
import com.mimi.pojo.Admin;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mimi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/admin")
public class AdminAction {
//界面层包含业务逻辑层对象
    @Autowired
    AdminService adminService;
    //登录判断并进行跳转
    @RequestMapping("/login")
    public String login(String name,String pwd,HttpServletRequest request){
        Admin admin = adminService.login(name,pwd);
        if(admin != null){
        //登录成功
            request.setAttribute("admin",admin);
            return "main";
        }else{
            //登陆失败
            request.setAttribute("errmsg","用户名或密码不正确！");
            return "login";
        }
    }
}
