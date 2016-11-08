package com.galaxy.modules.sys.dict.domain;

import com.galaxy.common.persistence.DataEntity;

/**
 * Created by cat on 2016/10/27.
 */
public class DictType extends DataEntity<DictType> {
    private String text;
    private String vname;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getVname() {
        return vname;
    }

    public void setVname(String vname) {
        this.vname = vname;
    }

}
