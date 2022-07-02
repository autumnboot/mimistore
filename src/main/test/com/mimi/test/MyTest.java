package com.mimi.test;

import com.google.protobuf.ValueOrBuilder;
import com.mimi.mapper.ProductInfoMapper;
import com.mimi.pojo.ProductInfo;
import com.mimi.pojo.vo.ProductInfoVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext_dao.xml","classpath:applicationContext_service.xml"})
public class MyTest {
    @Autowired
    ProductInfoMapper mapper;
    @Test
    public void testSelectCondition(){
        //ProductInfoVo vo = new ProductInfoVo();
        ////vo.setProductName("4");
        //vo.setProductType(3);
        //List<ProductInfo> list = mapper.selectCondition(vo);
        //list.forEach(ProductInfo -> System.out.println(ProductInfo));
        //int i = 0;int n = 0;int p = 0;
        //i = 10/3;
        //n = 15/2;
        //p = 13/5;
        //System.out.println("i"+i+"n"+n+"p"+p);


    }
}
