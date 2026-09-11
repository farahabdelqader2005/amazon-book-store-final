package com.adminPanelApp.dao;

import com.adminPanelApp.model.Author;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AuthorDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void saveAuthor(Author author) {
        getSession().saveOrUpdate(author);
    }

    @SuppressWarnings("unchecked")
    public List<Author> getAllAuthors() {
        return getSession().createQuery("from Author").list();
    }

    public Author getAuthorById(Long id) {
        return (Author) getSession().get(Author.class, id);
    }

    public void deleteAuthor(Long id) {
        Author author = getAuthorById(id);

        if (author != null) {
            getSession().delete(author);
        }
    }
}
