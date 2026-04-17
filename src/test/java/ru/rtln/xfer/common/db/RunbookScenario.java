package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.TestReporter;

record RunbookScenario(
    String id,
    String title,
    String given,
    String action,
    String expected,
    String sql
) {

    void publish(TestReporter testReporter) {
        testReporter.publishEntry("scenario.id", id);
        testReporter.publishEntry("scenario.title", title);
        testReporter.publishEntry("scenario.given", given);
        testReporter.publishEntry("scenario.action", action);
        testReporter.publishEntry("scenario.expected", expected);
        testReporter.publishEntry("scenario.sql", sql);
    }

    String failurePrefix() {
        return id + " - " + title + ": ";
    }

    @Override
    public String toString() {
        return id + " - " + title;
    }
}
