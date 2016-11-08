package com.galaxy.common.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;


/**
 * Created by cat on 2016/7/13.
 */
public class AjaxSessionFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
            ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;

//        String path = httpServletRequest.getContextPath();
//        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//        String remoteAddress=request.getRemoteAddr();
//        String servletPath=httpServletRequest.getServletPath();
//        String realPath=request.getRealPath("/");
//        String remoteUser=httpServletRequest.getRemoteUser();
        String requestURI = httpServletRequest.getRequestURI();
//        System.out.println("path:"+path+"<br>");
//        System.out.println("basePath:"+basePath+"<br>");
//        System.out.println("remoteAddr:"+remoteAddress+"<br>");
//        System.out.println("servletPath:"+servletPath+"<br>");
//        System.out.println("realPath:"+realPath+"<br>");
//        System.out.println("remoteUser:"+remoteUser+"<br>");
//        System.out.println("requestURI:"+requestURI+"<br>");

        String s2 = "";
        if (requestURI.indexOf(".do") != -1) {
            if (requestURI.indexOf("?") == -1) {
                s2 = requestURI.substring(requestURI.indexOf(".") + 1, requestURI.length());
                if (s2.indexOf("JSESSIONID") != -1) {
                    String s3 = s2.substring(0,s2.indexOf("JSESSIONID"));
                    s2 = s3.substring(s3.indexOf(".") + 1, s3.length());
                    s2 = s2.replaceAll(";","");
                }
            } else if (requestURI.indexOf("?") != -1) {
                String s1 = requestURI.substring(0, requestURI.indexOf("?"));
                s2 = s1.substring(s1.indexOf(".") + 1, s1.length());

                if (s2.indexOf("JSESSIONID") != -1) {
                    String s3 = s2.substring(0,s2.indexOf("JSESSIONID"));
                    s2 = s3.substring(s3.indexOf(".") + 1, s3.length());
                }
                s2 = s2.replaceAll(";","");
            }
        }
        //      if (httpServletRequest.getSession().getAttribute("user") == null) {
        if ("do".equals(s2)) {
            if (!SecurityUtils.getSubject().isAuthenticated()) {
                //判断session里是否有用户信息
                if (httpServletRequest.getHeader("x-requested-with") != null
                        && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                    //如果是ajax请求响应头会有，x-requested-with
                    httpServletResponse.setHeader("sessionstatus", "timeout");//在响应头设置session状态
                    return;
                }

            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }


}
