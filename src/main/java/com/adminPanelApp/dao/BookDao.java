package com.adminPanelApp.dao;

import com.adminPanelApp.model.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class BookDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void saveBook(Book book) {
        getSession().saveOrUpdate(book);
    }

    @SuppressWarnings("unchecked")
    public List<Book> getAllBooks() {
        return getSession().createQuery("from Book").list();
    }

    public Book getBookById(Long id) {
        return (Book) getSession().get(Book.class, id);
    }

    public void deleteBook(Long id) {
        Book book = getBookById(id);

        if (book != null) {
            getSession().delete(book);
        }
    }
}
