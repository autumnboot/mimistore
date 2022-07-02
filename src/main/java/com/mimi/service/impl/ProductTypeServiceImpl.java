package com.mimi.service.impl;

import com.mimi.mapper.ProductTypeMapper;
import com.mimi.pojo.ProductType;
import com.mimi.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {

    //业务逻辑层要有数据访问层对象
    @Autowired
    ProductTypeMapper productTypeMapper;

    @Override
    public List<ProductType> getAll() {
        return productTypeMapper.selectByExample(null);
    }
}
