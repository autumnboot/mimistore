package com.mimi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mimi.mapper.ProductInfoMapper;
import com.mimi.pojo.ProductInfo;
import com.mimi.pojo.ProductInfoExample;
import com.mimi.pojo.vo.ProductInfoVo;
import com.mimi.service.ProductInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {
    //业务逻辑层应有数据访问层对象
    @Autowired
    ProductInfoMapper productInfoMapper;

    @Override
    public List<ProductInfo> getAll() {
        return productInfoMapper.selectByExample(null);
    }

    @Override
    public int save(ProductInfo info) {
        return productInfoMapper.insert(info);
    }

    @Override
    public ProductInfo getById(int pid) {
        return productInfoMapper.selectByPrimaryKey(pid);
    }

    @Override
    public int update(ProductInfo info) {
        return productInfoMapper.updateByPrimaryKey(info);
    }

    @Override
    public int delete(int pid) {
        return productInfoMapper.deleteByPrimaryKey(pid);
    }

    @Override
    public int deleteBatch(String[] ids) {
        return productInfoMapper.deleteBatch(ids);
    }

    @Override
    public List<ProductInfo> selectCondition(ProductInfoVo vo) {

        return productInfoMapper.selectCondition(vo);
    }

    @Override
    public PageInfo<ProductInfo> pageCondition(ProductInfoVo vo, int pageSize) {
        //取出集合之前，设置PageHelper.startPage()属性
        PageHelper.startPage(vo.getPageNum(),pageSize);
        List<ProductInfo> list = productInfoMapper.selectCondition(vo);
        return new PageInfo<>(list);
    }

    //select * from product_info limit 5,5 起始记录序号=（（当前页-1）*每页条数），每页条数

    public PageInfo splitPage(int pageNum,int pageSize) {
        //分页插件使用PageHelper工具类
        //在取得结果集之前设置PageHelper.startPage
        PageHelper.startPage(pageNum,pageSize);

        //将查询结果List封装进PageInfo
        //有条件的查询需要创建ProductInfoExample对象
        ProductInfoExample example = new ProductInfoExample();

        //为方便展示，设置为按主键降序
        //select * from product_info order by p_id desc
        example.setOrderByClause("p_id desc");

        List<ProductInfo> list = productInfoMapper.selectByExample(example);

        //将结果集封装进PageInfo
        PageInfo<ProductInfo> pageInfo = new PageInfo<>(list);

        return pageInfo;
    }
}


