package com.dorm.base;

import junit.framework.TestCase;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by wensheng on 15-5-20.
 */
public class BaseTestCase extends TestCase {

    protected static ApplicationContext context;

    @Override
    public void setUp() throws Exception {
        context = new ClassPathXmlApplicationContext("application-dev.xml");
        super.setUp();
    }


}
