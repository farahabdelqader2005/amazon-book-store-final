package com.adminPanelApp.service;

import com.adminPanelApp.dao.BookDao;
import com.adminPanelApp.model.Author;
import com.adminPanelApp.model.Book;
import com.adminPanelApp.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BookService {

    @Autowired
    private BookDao bookDao;

    public List<Book> getAllBooks() {
        List<Book> books = bookDao.getAllBooks();

        for (Book book : books) {
            book.getCategories().size();
            book.getAuthors().size();
        }

        return books;
    }

    public Book getBookById(Long id) {
        Book book = bookDao.getBookById(id);

        if (book != null) {
            book.getCategories().size();
            book.getAuthors().size();
        }

        return book;
    }

    public void saveBook(Book book) {
        bookDao.saveBook(book);
    }

    public boolean deleteBook(Long id) {
        Book book = bookDao.getBookById(id);

        if (book == null) {
            return false;
        }

        for (Category category : book.getCategories()) {
            category.getBooks().remove(book);
        }

        book.getCategories().clear();

        for (Author author : book.getAuthors()) {
            author.getBooks().remove(book);
        }

        book.getAuthors().clear();
        bookDao.deleteBook(id);

        return true;
    }
}
