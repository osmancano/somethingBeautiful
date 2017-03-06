package com.ironyard.repositories;

import com.ironyard.data.Idiom;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by osmanidris on 3/5/17.
 */
public interface IdiomRepo extends PagingAndSortingRepository<Idiom, Long> {
    @Query("select i from Idiom i where i.isNew=0")
    public Iterable<Idiom> findNewIdioms();
}
