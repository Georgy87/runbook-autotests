package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestReporter;

import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Comparator;
import java.util.Optional;
import java.util.stream.Stream;

final class RunbookDescriptionReporter {

    private RunbookDescriptionReporter() {
    }

    static void publishAnnotation(TestInfo testInfo, TestReporter testReporter) {
        Optional<RunbookDescription> description = testInfo.getTestMethod()
            .map(method -> method.getAnnotation(RunbookDescription.class));

        description.ifPresent(value -> {
            testReporter.publishEntry("description.id", value.id());
            testReporter.publishEntry("description.title", value.title());
            testReporter.publishEntry("description.given", value.given());
            testReporter.publishEntry("description.action", value.action());
            testReporter.publishEntry("description.expected", value.expected());
            testReporter.publishEntry("description.sql", value.sql());
        });
    }

    static void writeReports(
        Class<?> testClass,
        Path markdownReportPath,
        Path htmlReportPath,
        String title,
        String sourceDocument
    ) throws IOException {
        List<Method> methods = Stream.of(testClass.getDeclaredMethods())
            .filter(method -> method.isAnnotationPresent(RunbookDescription.class))
            .sorted(Comparator
                .comparingInt((Method method) -> method.getAnnotation(RunbookDescription.class).order())
                .thenComparing(method -> method.getAnnotation(RunbookDescription.class).id()))
            .toList();

        writeMarkdownReport(markdownReportPath, title, sourceDocument, methods);
        writeHtmlReport(htmlReportPath, title, sourceDocument, methods);
    }

    private static void writeMarkdownReport(
        Path reportPath,
        String title,
        String sourceDocument,
        List<Method> methods
    ) throws IOException {
        Files.createDirectories(reportPath.getParent());

        StringBuilder report = new StringBuilder()
            .append("# ")
            .append(title)
            .append("\n\n")
            .append("Источник: `")
            .append(sourceDocument)
            .append("`\n\n")
            .append("Аннотация в коде: `@RunbookDescription`\n\n");

        methods.forEach(method -> appendMarkdownDescription(report, method));

        Files.writeString(reportPath, report.toString());
    }

    private static void writeHtmlReport(
        Path reportPath,
        String title,
        String sourceDocument,
        List<Method> methods
    ) throws IOException {
        Files.createDirectories(reportPath.getParent());

        StringBuilder report = new StringBuilder()
            .append("""
                <!doctype html>
                <html lang="ru">
                <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>""")
            .append(escapeHtml(title))
            .append("""
                </title>
                  <style>
                    :root {
                      color-scheme: light;
                      --bg: #f6f2ea;
                      --panel: #fffaf0;
                      --ink: #24201a;
                      --muted: #756a5b;
                      --line: #ded2bf;
                      --accent: #a24721;
                      --code-bg: #211f1c;
                      --code-ink: #f8efe0;
                    }
                    body {
                      margin: 0;
                      background: var(--bg);
                      color: var(--ink);
                      font: 16px/1.55 Georgia, "Times New Roman", serif;
                    }
                    main {
                      max-width: 1060px;
                      margin: 0 auto;
                      padding: 40px 24px 64px;
                    }
                    header {
                      border-bottom: 2px solid var(--line);
                      margin-bottom: 28px;
                      padding-bottom: 20px;
                    }
                    h1 {
                      font-size: clamp(32px, 5vw, 56px);
                      line-height: 1;
                      margin: 0 0 16px;
                      letter-spacing: -0.04em;
                    }
                    .meta {
                      color: var(--muted);
                      font-family: "Avenir Next", "Segoe UI", sans-serif;
                    }
                    .scenario {
                      background: var(--panel);
                      border: 1px solid var(--line);
                      border-radius: 18px;
                      box-shadow: 0 20px 45px rgba(64, 45, 24, 0.08);
                      margin: 22px 0;
                      overflow: hidden;
                    }
                    .scenario-header {
                      display: flex;
                      gap: 16px;
                      justify-content: space-between;
                      align-items: flex-start;
                      padding: 22px 24px;
                      border-bottom: 1px solid var(--line);
                    }
                    .scenario h2 {
                      margin: 0;
                      font-size: 24px;
                      line-height: 1.15;
                    }
                    .badge {
                      flex: none;
                      border: 1px solid color-mix(in srgb, var(--accent), #fff 45%);
                      border-radius: 999px;
                      color: var(--accent);
                      font: 700 12px/1 "Avenir Next", "Segoe UI", sans-serif;
                      letter-spacing: 0.08em;
                      padding: 8px 10px;
                      text-transform: uppercase;
                    }
                    .scenario-body {
                      display: grid;
                      gap: 18px;
                      padding: 22px 24px 24px;
                    }
                    .field-label {
                      color: var(--accent);
                      font: 700 13px/1.2 "Avenir Next", "Segoe UI", sans-serif;
                      letter-spacing: 0.08em;
                      margin: 0 0 5px;
                      text-transform: uppercase;
                    }
                    p {
                      margin: 0;
                    }
                    code {
                      font-family: "JetBrains Mono", "SFMono-Regular", Consolas, monospace;
                    }
                    pre {
                      background: var(--code-bg);
                      border-radius: 14px;
                      color: var(--code-ink);
                      margin: 6px 0 0;
                      overflow: auto;
                      padding: 16px;
                      white-space: pre;
                    }
                  </style>
                </head>
                <body>
                <main>
                  <header>
                    <h1>""")
            .append(escapeHtml(title))
            .append("</h1>\n")
            .append("    <div class=\"meta\">Источник: <code>")
            .append(escapeHtml(sourceDocument))
            .append("</code></div>\n")
            .append("    <div class=\"meta\">Аннотация в коде: <code>@RunbookDescription</code></div>\n")
            .append("  </header>\n");

        methods.forEach(method -> appendHtmlDescription(report, method));

        report
            .append("""
                </main>
                </body>
                </html>
                """);

        Files.writeString(reportPath, report.toString());
    }

    private static void appendMarkdownDescription(StringBuilder report, Method method) {
        RunbookDescription description = method.getAnnotation(RunbookDescription.class);

        report
            .append("## ")
            .append(description.id())
            .append(" - ")
            .append(description.title())
            .append("\n\n")
            .append("- Метод автотеста: `")
            .append(method.getName())
            .append("`\n")
            .append("- Дано: ")
            .append(description.given())
            .append("\n")
            .append("- Действие: ")
            .append(description.action())
            .append("\n")
            .append("- Ожидаемый результат: ")
            .append(description.expected())
            .append("\n\n")
            .append("```sql\n")
            .append(description.sql().strip())
            .append("\n```\n\n");
    }

    private static void appendHtmlDescription(StringBuilder report, Method method) {
        RunbookDescription description = method.getAnnotation(RunbookDescription.class);

        report
            .append("  <article class=\"scenario\">\n")
            .append("    <div class=\"scenario-header\">\n")
            .append("      <h2>")
            .append(escapeHtml(description.title()))
            .append("</h2>\n")
            .append("      <span class=\"badge\">")
            .append(escapeHtml(description.id()))
            .append("</span>\n")
            .append("    </div>\n")
            .append("    <div class=\"scenario-body\">\n")
            .append("      <section><div class=\"field-label\">Метод автотеста</div><p><code>")
            .append(escapeHtml(method.getName()))
            .append("</code></p></section>\n")
            .append("      <section><div class=\"field-label\">Дано</div><p>")
            .append(escapeHtml(description.given()))
            .append("</p></section>\n")
            .append("      <section><div class=\"field-label\">Действие</div><p>")
            .append(escapeHtml(description.action()))
            .append("</p></section>\n")
            .append("      <section><div class=\"field-label\">Ожидаемый результат</div><p>")
            .append(escapeHtml(description.expected()))
            .append("</p></section>\n")
            .append("      <section><div class=\"field-label\">SQL из runbook</div><pre><code>")
            .append(escapeHtml(description.sql().strip()))
            .append("</code></pre></section>\n")
            .append("    </div>\n")
            .append("  </article>\n");
    }

    private static String escapeHtml(String value) {
        return value
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
}
