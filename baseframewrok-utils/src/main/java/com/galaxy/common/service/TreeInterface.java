package com.galaxy.common.service;

/**
 * Created by cat on 2016/11/1.
 */
public interface TreeInterface<T> extends BaseInterface<T> {
    public void save(T entity);
}
