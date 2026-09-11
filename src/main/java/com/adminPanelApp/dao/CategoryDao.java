package com.adminPanelApp.dao;

import com.adminPanelApp.model.Category;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class CategoryDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void saveCategory(Category category) {
        getSession().saveOrUpdate(category);
    }

    @SuppressWarnings("unchecked")
    public List<Category> getAllCategories() {
        return getSession().createQuery("from Category").list();
    }

    @SuppressWarnings("unchecked")
    public List<Category> getCategoriesByPage(int firstResult) {
        Query query = getSession().createQuery("from Category");
        query.setFirstResult(firstResult);
        query.setMaxResults(5);
        return query.list();
    }

    public Category getCategoryById(Long id) {
        return (Category) getSession().get(Category.class, id);
    }

    public void deleteCategory(Long id) {
        Category category = getCategoryById(id);

        if (category != null) {
            getSession().delete(category);
        }
    }
}
