package com.adminPanelApp.controller;

import com.adminPanelApp.model.Author;
import com.adminPanelApp.model.Book;
import com.adminPanelApp.model.BookDetails;
import com.adminPanelApp.model.Category;
import com.adminPanelApp.service.AuthorService;
import com.adminPanelApp.service.BookService;
import com.adminPanelApp.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AuthorService authorService;

    @GetMapping("/list")
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
        return "book-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        Book book = new Book();
        BookDetails bookDetails = new BookDetails();
        book.setBookDetails(bookDetails);

        model.addAttribute("book", book);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("authors", authorService.getAllAuthors());

        return "book-form";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") Long id,
                               Model model) {

        Book book = bookService.getBookById(id);

        if (book == null) {
            return "redirect:/books/list?error=notFound";
        }

        if (book.getBookDetails() == null) {
            BookDetails bookDetails = new BookDetails();
            book.setBookDetails(bookDetails);
        }

        model.addAttribute("book", book);
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("authors", authorService.getAllAuthors());

        return "book-form";
    }

    @GetMapping("/details")
    public String showBookDetails(@RequestParam("id") Long id,
                                  Model model) {

        Book book = bookService.getBookById(id);

        if (book == null) {
            return "redirect:/books/list?error=notFound";
        }

        model.addAttribute("book", book);
        return "book-details";
    }

    @PostMapping("/save")
    public String saveBook(
            @ModelAttribute("book") Book book,
            BindingResult bindingResult,
            @RequestParam(value = "categoryIds", required = false) Long[] categoryIds,
            @RequestParam(value = "authorIds", required = false) Long[] authorIds,
            Model model) {

        String title = book.getTitle();

        if (title == null || title.trim().isEmpty()) {
            bindingResult.rejectValue(
                    "title",
                    "book.title.required",
                    "Book title is required."
            );
        } else {
            book.setTitle(title.trim());

            if (book.getTitle().length() > 255) {
                bindingResult.rejectValue(
                        "title",
                        "book.title.length",
                        "Book title must not exceed 255 characters."
                );
            }
        }

        if (book.getPrice() == null) {
            bindingResult.rejectValue(
                    "price",
                    "book.price.required",
                    "Book price is required."
            );
        } else if (book.getPrice() <= 0) {
            bindingResult.rejectValue(
                    "price",
                    "book.price.invalid",
                    "Book price must be greater than zero."
            );
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.getAllCategories());
            model.addAttribute("authors", authorService.getAllAuthors());
            return "book-form";
        }

        List<Category> selectedCategories = new ArrayList<Category>();

        if (categoryIds != null) {
            for (Long categoryId : categoryIds) {
                Category category = categoryService.getCategoryById(categoryId);

                if (category != null) {
                    selectedCategories.add(category);
                }
            }
        }

        List<Author> selectedAuthors = new ArrayList<Author>();

        if (authorIds != null) {
            for (Long authorId : authorIds) {
                Author author = authorService.getAuthorById(authorId);

                if (author != null) {
                    selectedAuthors.add(author);
                }
            }
        }

        if (book.getId() == null) {
            book.setCategories(selectedCategories);
            book.setAuthors(selectedAuthors);

            if (book.getBookDetails() != null) {
                book.getBookDetails().setBook(book);
            }

            bookService.saveBook(book);
        } else {
            Book existingBook = bookService.getBookById(book.getId());

            if (existingBook == null) {
                return "redirect:/books/list?error=notFound";
            }

            existingBook.setTitle(book.getTitle());
            existingBook.setPrice(book.getPrice());
            existingBook.setCategories(selectedCategories);
            existingBook.setAuthors(selectedAuthors);

            if (book.getBookDetails() != null) {
                if (existingBook.getBookDetails() == null) {
                    existingBook.setBookDetails(book.getBookDetails());
                } else {
                    existingBook.getBookDetails().setIsbn(book.getBookDetails().getIsbn());
                    existingBook.getBookDetails().setPublicationDate(book.getBookDetails().getPublicationDate());
                    existingBook.getBookDetails().setPublisher(book.getBookDetails().getPublisher());
                    existingBook.getBookDetails().setNumberOfPages(book.getBookDetails().getNumberOfPages());
                    existingBook.getBookDetails().setLanguage(book.getBookDetails().getLanguage());
                }
            }

            bookService.saveBook(existingBook);
        }

        return "redirect:/books/list?success=saved";
    }

    @PostMapping("/delete")
    public String deleteBook(@RequestParam("id") Long id) {
        boolean deleted = bookService.deleteBook(id);

        if (!deleted) {
            return "redirect:/books/list?error=notFound";
        }

        return "redirect:/books/list?success=deleted";
    }
}
