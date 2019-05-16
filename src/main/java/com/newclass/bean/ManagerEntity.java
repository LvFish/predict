package com.newclass.bean;

import javax.persistence.*;

/**
 * Created by liujiawang on 2019/5/15.
 */
@Entity
@Table(name = "manager", schema = "predict", catalog = "")
public class ManagerEntity {
    private int managerId;
    private String password;
    private String managerName;

    @Id
    @Column(name = "manager_id", nullable = false)
    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    @Basic
    @Column(name = "password", nullable = true, length = 255)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "manager_name", nullable = true, length = 255)
    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ManagerEntity that = (ManagerEntity) o;

        if (managerId != that.managerId) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (managerName != null ? !managerName.equals(that.managerName) : that.managerName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = managerId;
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (managerName != null ? managerName.hashCode() : 0);
        return result;
    }
}
