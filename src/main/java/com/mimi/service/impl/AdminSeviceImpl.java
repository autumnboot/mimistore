package com.mimi.service.impl;

import com.mimi.mapper.AdminMapper;
import com.mimi.pojo.Admin;
import com.mimi.pojo.AdminExample;
import com.mimi.service.AdminService;
import com.mimi.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminSeviceImpl implements AdminService {
    //业务逻辑层包含数据访问层对象
    @Autowired
    AdminMapper adminMapper;
    @Override
    public Admin login(String name, String pwd) {
        //根据传入的用户名到数据库中查询对象
        //条件查询需要借助AdminExample
        AdminExample example = new AdminExample();
        //添加用户名a_name条件
        example.createCriteria().andANameEqualTo(name);
        List<Admin> list = adminMapper.selectByExample(example);
        if(list.size() > 0){
            Admin admin = list.get(0);
            String MD5Pwd = MD5Util.getMD5(pwd);
            if(MD5Pwd.equals(admin.getaPass())){
                return admin;
            }
        }
        //查询到结果再比对密码
        return null;
    }
}
