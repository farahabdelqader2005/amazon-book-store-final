package com.adminPanelApp.service;

import com.adminPanelApp.dao.AuthorDao;
import com.adminPanelApp.model.Author;
import com.adminPanelApp.model.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AuthorService {

    @Autowired
    private AuthorDao authorDao;

    public List<Author> getAllAuthors() {
        return authorDao.getAllAuthors();
    }

    public Author getAuthorById(Long id) {
        return authorDao.getAuthorById(id);
    }

    public void saveAuthor(Author author) {
        authorDao.saveAuthor(author);
    }

    public boolean deleteAuthor(Long id) {
        Author author = authorDao.getAuthorById(id);

        if (author == null) {
            return false;
        }

        for (Book book : author.getBooks()) {
            book.getAuthors().remove(author);
        }

        author.getBooks().clear();
        authorDao.deleteAuthor(id);

        return true;
    }
}
