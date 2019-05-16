package com.newclass.util;

import java.util.HashMap;
import java.util.Map;

/**
 * 存放全局变量
 * Created by sl on 16-3-3.
 */
public class GlobalVariable {
    Map<String , String> map;

    private void init() {
        if(this.map == null) {
            this.map = new HashMap<String , String>();
        }

        this.map.put("assetsPath", "/newclass/assets");
        this.map.put("commonPath", "/newclass/common");
        this.map.put("rootPath", "/newclass");
        this.map.put("requestPath","http://localhost:8080/newclass");
    }

    public Map<String , String> getAll() {
        this.init();
        return this.map;
    }
}
