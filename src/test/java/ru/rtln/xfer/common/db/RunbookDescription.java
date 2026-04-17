package ru.rtln.xfer.common.db;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@interface RunbookDescription {

    int order();

    String id();

    String title();

    String given();

    String action();

    String expected();

    String sql();
}
