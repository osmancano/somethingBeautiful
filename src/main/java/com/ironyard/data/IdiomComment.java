package com.ironyard.data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.util.Date;

/**
 * Created by osmanidris on 3/5/17.
 */
@Entity
public class IdiomComment {
    @Id
    @GeneratedValue
    private Long id;
    private String comment;
    private Date commentDate;
    @ManyToOne
    private IdiomUser user;

    public IdiomComment() {
    }

    public IdiomComment(String comment, IdiomUser user) {
        this.comment = comment;
        this.user = user;
        this.commentDate = new Date();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public IdiomUser getUser() {
        return user;
    }

    public void setUser(IdiomUser user) {
        this.user = user;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
}
