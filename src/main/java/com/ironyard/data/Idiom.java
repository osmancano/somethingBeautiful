package com.ironyard.data;

import javax.persistence.*;
import java.util.List;

/**
 * Created by osmanidris on 3/5/17.
 */
@Entity
public class Idiom {
    @Id
    @GeneratedValue
    private Long id;
    private String idiomText;
    private Integer isNew;
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<IdiomComment> comments;

    public Idiom(){}
    public Idiom(String idiomText) {
        this.idiomText = idiomText;
        this.isNew = 0;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIdiomText() {
        return idiomText;
    }

    public void setIdiomText(String idiomText) {
        this.idiomText = idiomText;
    }

    public Integer getIsNew() {
        return isNew;
    }

    public void setIsNew(Integer aNew) {
        isNew = aNew;
    }

    public List<IdiomComment> getComments() {
        return comments;
    }

    public void setComments(List<IdiomComment> comments) {
        this.comments = comments;
    }
}
