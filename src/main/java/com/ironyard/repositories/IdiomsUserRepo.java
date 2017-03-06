package com.ironyard.repositories;

import com.ironyard.data.IdiomUser;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by osmanidris on 2/10/17.
 */
public interface IdiomsUserRepo extends CrudRepository<IdiomUser, Long> {
    public IdiomUser findByUsernameAndPassword(String username, String password);
    @Query("select i from IdiomUser i where i.notifyMe=1")
    public Iterable<IdiomUser> findUsersToBeNotified();
}
