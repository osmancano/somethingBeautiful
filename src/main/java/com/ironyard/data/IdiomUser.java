package com.ironyard.data;

import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.List;

/**
 * Created by osmanidris on 2/10/17.
 */
@Entity
public class IdiomUser {
    @Id @GeneratedValue
    private Long ID;
    private String username;
    private String password;
    private String email;
    private Integer notifyMe;
    private String userImageFile;

    public IdiomUser(){}

    public IdiomUser(String username, String password, String email, String userImageFile){
        this.username = username;
        this.password = password;
        this.email = email;
        this.userImageFile = userImageFile;
        this.notifyMe = 0;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getNotifyMe() {
        return notifyMe;
    }

    public void setNotifyMe(Integer notifyMe) {
        this.notifyMe = notifyMe;
    }

    public Long getID() {
        return ID;
    }

    public void setID(Long ID) {
        this.ID = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserImageFile() {
        return userImageFile;
    }

    public void setUserImageFile(String userImageFile) {
        this.userImageFile = userImageFile;
    }
}
