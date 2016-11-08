package com.galaxy.common.service;

import com.galaxy.common.persistence.Page;

import java.util.List;

/**
 * Created by cat on 2016/11/1.
 */
public interface BaseInterface<T> {
    public T get(String id);

    public T get(T entity);

    public List<T> findList(T entity);

    public Page<T> findPage(Page<T> page, T entity);

    public void save(T entity);

    public void delete(T entity);
}
