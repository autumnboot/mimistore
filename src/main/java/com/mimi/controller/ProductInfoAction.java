package com.mimi.controller;

import com.github.pagehelper.PageInfo;
import com.mimi.mapper.ProductInfoMapper;
import com.mimi.pojo.ProductInfo;
import com.mimi.pojo.vo.ProductInfoVo;
import com.mimi.service.impl.ProductInfoServiceImpl;
import com.mimi.utils.FileNameUtil;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/prod")
public class ProductInfoAction {
    public static final int PAGE_SIZE = 5;

    //异步上传图片名称
    String saveFileName = "";
    //界面层应有业务逻辑层对象
    @Autowired
    ProductInfoServiceImpl productInfoService;

    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request){
        List<ProductInfo> list = productInfoService.getAll();
        request.setAttribute("list",list);
        return "product";
    }
    //显示第一页的五条数据
    @RequestMapping("/split")
    public String split(HttpServletRequest request){
        PageInfo info = null;
        Object vo = request.getSession().getAttribute("prodVo");
        if(vo != null) {
            info = productInfoService.pageCondition((ProductInfoVo) vo, PAGE_SIZE);
            //清空vo
            request.getSession().removeAttribute("prodVo");
        }else {
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        request.setAttribute("info",info);
        return "product";
    }

    //ajax分页翻页处理
    @ResponseBody
    @RequestMapping("/ajaxSplit")
    public void ajaxSplit(ProductInfoVo vo, HttpSession session){
        //获取页面数据
        PageInfo info = productInfoService.pageCondition(vo,PAGE_SIZE);
        session.setAttribute("info",info);
    }
    //多条件查询
    @ResponseBody
    @RequestMapping("/condition")
    public void condition(ProductInfoVo vo,HttpSession session){
        List<ProductInfo> list = productInfoService.selectCondition(vo);
        session.setAttribute("list",list);
    }

    //异步ajax文件上传
    @ResponseBody
    @RequestMapping("/ajaxImg")
    public Object ajxImg(MultipartFile pimage,HttpServletRequest request){
    //    上面的pimage需与addproduct.jsp中的file标签的name属性名一致
    //    获取生成的UUID + 图片后缀名
        saveFileName = FileNameUtil.getUUIDFileName() + FileNameUtil.getFileType(pimage.getOriginalFilename());
    //    得到图片存储的路径
        String path = request.getServletContext().getRealPath("/image_big");
    //    转存
        try {
            pimage.transferTo(new File(path + File.separator + saveFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //返回客户端JSON对象以在页面回显图片
        JSONObject object = new JSONObject();
        //imgurl是addproduct.jsp中的obj对象的一函数
        object.put("imgurl",saveFileName);
        return object.toString();
    }

    @RequestMapping("/save")
    public String save(ProductInfo info,HttpServletRequest request){
        info.setpImage(saveFileName);
        info.setpDate(new Date());
        int num = -1;
        try {
            num = productInfoService.save(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(num > 0){
            request.setAttribute("msg","增加成功！");
        }else {
            request.setAttribute("msg","增加失败！");
        }
        //清空变量值，为下次增加或修改做准备
        saveFileName = "";
        //增加成功后应重新访问数据库，所以应跳转至分页显示的action上
        return "forward:/prod/split.action";
    }

    @RequestMapping("/one")
    public String one(int pid, ProductInfoVo vo, Model model, HttpSession session){
        ProductInfo info = productInfoService.getById(pid);
        model.addAttribute("prod",info);
        //将条件及页码放入session域中，供更新结束后读取
        session.setAttribute("prodVo",vo);
        return "forward:/prod/split.action";
    }
    @RequestMapping("update")
    public String update(ProductInfo info,HttpServletRequest request){
        //如果有上传过图片则saveFileName有值；
        //如果没有上传过则应使用update.jsp中隐藏表单域提交的pImage名称
        if(!saveFileName.equals("")){
            info.setpImage(saveFileName);
        }
        int num = -1;
        try {
            num = productInfoService.update(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(num > 0){
            request.setAttribute("msg","更新成功！");
        }else {
            request.setAttribute("msg","更新失败！");
        }
        //处理完更新后，saveFileName可能有值
        saveFileName = "";
        return "forward:/prod/split.action";
    }

    @RequestMapping("delete")
    public String delete(int pid, ProductInfoVo vo, HttpServletRequest request){
        int num = -1;
        try {
            num = productInfoService.delete(pid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0){
            request.setAttribute("msg","删除成功！");
            request.getSession().setAttribute("deleteVo",vo);
        }else {
            request.setAttribute("msg","删除失败！");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }

    @ResponseBody
    @RequestMapping(value = "/deleteAjaxSplit",produces = "text/html;charset = UTF-8")
    public Object deleteAjaxSplit(HttpServletRequest request){
        PageInfo info = null;
        Object vo = request.getSession().getAttribute("deleteVo");
        if(vo != null) {
            info = productInfoService.pageCondition((ProductInfoVo) vo, PAGE_SIZE);
            //清空vo
            request.getSession().removeAttribute("deleteVo");
        }else {
            //取第一页数据
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
            request.getSession().setAttribute("info",info);
            return request.getAttribute("msg");
    }

    //批量删除
    @RequestMapping("/deleteBatch")
    public String deleteBatch(String pids,ProductInfoVo vo, HttpServletRequest request){
        //分割字符串
        String []pidarr = pids.split(",");

        //删除可能会出错，例如已被加入订单
        try {
            int num = productInfoService.deleteBatch(pidarr);
            if(num > 0){
                request.setAttribute("msg","批量删除成功！");
                request.getSession().setAttribute("deleteVo",vo);
            }else {
                request.setAttribute("msg","批量删除失败！");
            }
        } catch (Exception e) {
            request.setAttribute("msg","商品不可删除！");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }


}










