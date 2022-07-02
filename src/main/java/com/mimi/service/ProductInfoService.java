package com.mimi.service;

import com.github.pagehelper.PageInfo;
import com.mimi.pojo.ProductInfo;
import com.mimi.pojo.vo.ProductInfoVo;

import java.util.List;

public interface ProductInfoService {
    //查询所有商品
    List<ProductInfo> getAll();

    //分页功能实现
    PageInfo splitPage(int pageNum, int pageSize);

    //增加商品
    int save(ProductInfo info);

    //按主键查询商品
    ProductInfo getById(int pid);

    //更新商品
    int update(ProductInfo info);

    //删除单个商品
    int delete(int pid);

    //批量删除
    int deleteBatch(String []ids);

    //多条件查询
    List<ProductInfo> selectCondition(ProductInfoVo vo);

    //多条件分页查询
    //修改功能一般做新增处理，不修改原有代码
    public PageInfo pageCondition(ProductInfoVo vo,int pageSize);
}
