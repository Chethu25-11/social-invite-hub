package com.socialinvitehub.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableWebMvc
@EnableTransactionManagement
@ComponentScan(basePackages = "com.socialinvitehub")
@PropertySource("classpath:connections.properties")
public class SocialConfig implements WebMvcConfigurer {

    @Autowired
    private Environment environment;
    @Bean
    public DataSource dataSource() {

        DriverManagerDataSource dataSource =
                new DriverManagerDataSource();

        dataSource.setDriverClassName(
                environment.getProperty(
                        "jdbc.driverClassName"));

        dataSource.setUrl(
                environment.getProperty(
                        "jdbc.url"));

        dataSource.setUsername(
                environment.getProperty(
                        "jdbc.username"));

        dataSource.setPassword(
                environment.getProperty(
                        "jdbc.password"));

        return dataSource;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {

        LocalContainerEntityManagerFactoryBean factory =
                new LocalContainerEntityManagerFactoryBean();

        factory.setDataSource(dataSource());

        factory.setPackagesToScan(
                "com.socialinvitehub.entity");

        factory.setJpaVendorAdapter(
                new HibernateJpaVendorAdapter());

        Properties properties =
                new Properties();

        properties.setProperty(
                "hibernate.dialect",
                environment.getProperty(
                        "hibernate.dialect"));

        properties.setProperty(
                "hibernate.show_sql",
                environment.getProperty(
                        "hibernate.show_sql"));

        properties.setProperty(
                "hibernate.hbm2ddl.auto",
                environment.getProperty(
                        "hibernate.hbm2ddl.auto"));

        factory.setJpaProperties(
                properties);

        return factory;
    }

    @Bean
    public ViewResolver viewResolver() {

        InternalResourceViewResolver resolver =
                new InternalResourceViewResolver();

        resolver.setPrefix("/WEB-INF/");
        resolver.setSuffix(".jsp");

        return resolver;
    }

    @Bean
    public PlatformTransactionManager transactionManager(
            EntityManagerFactory emf) {

        return new JpaTransactionManager(emf);
    }
}