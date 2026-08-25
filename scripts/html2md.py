#!/usr/bin/env python3
"""Convert EUR-Lex CONVEX XHTML (formex-derived OJ HTML) to clean Markdown.

Preserves the full legal text in document order. Only presentation is mapped
to Markdown structure (headings, paragraphs, footnotes). No wording changes.

Usage: python3 scripts/html2md.py <input.html> <output.md>
"""
import re
import sys
from html.parser import HTMLParser

# p-class -> markdown prefix ('' = plain paragraph)
HEADING_MAP = {
    "oj-doc-ti": "## ",
    "oj-ti-section-1": "## ",
    "oj-ti-grseq-1": "## ",
    "oj-ti-section-2": "### ",
    "oj-ti-art": "### ",
    "oj-ti-art-first": "### ",
    "oj-sti-art": "",  # subtitle span inside article titles; handled inline
}

# NB: tables are NOT skipped — EUR-Lex renders recitals inside table cells
# (number column + text column). Only the OJ masthead is dropped.
SKIP_TAGS = {"script", "style", "head"}


class Converter(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.out = []
        self.skip_depth = 0
        self.p_class = ""      # class of the <p> currently being collected
        self.p_buf = []        # text of current paragraph
        self.in_p = False
        self.p_all_classes = []  # all classes of the <p> currently collected
        self.notes = []        # footnotes collected for end section

    # -- helpers ---------------------------------------------------------
    @staticmethod
    def _classes(attrs):
        for k, v in attrs:
            if k == "class":
                return v.split()
        return []

    def flush_p(self):
        if not self.in_p:
            return
        text = "".join(self.p_buf)
        text = re.sub(r"[ \t]+", " ", text).strip()
        self.in_p = False
        self.p_buf = []
        if not text:
            return
        cls = self.p_class
        if any(c.startswith("oj-hd-") for c in self.p_all_classes):
            return  # OJ masthead furniture
        if cls == "oj-note":
            tag = ""
            m = re.match(r"^(\d+)", text)
            if m:
                tag = m.group(1)
            self.notes.append(f"[^{tag}] {text}")
            return
        if cls == "oj-quotation":
            self.out.append("> " + text)
            return
        prefix = HEADING_MAP.get(cls, "")
        self.out.append(prefix + text)

    # -- parser events ----------------------------------------------------
    def handle_starttag(self, tag, attrs):
        classes = self._classes(attrs)
        if tag in SKIP_TAGS or self.skip_depth:
            if tag in SKIP_TAGS:
                self.skip_depth += 1
            return
        if tag == "hr":
            self.flush_p()
            self.out.append("---")
        elif tag == "p":
            self.flush_p()  # nested/unexpected: flush previous first
            self.in_p = True
            self.p_buf = []
            self.p_all_classes = classes
            self.p_class = next((c for c in classes if c in HEADING_MAP or
                                 c in ("oj-normal", "oj-note", "oj-quotation")), "")
            if not self.p_class and classes:
                # unknown paragraph class: keep as plain text
                self.p_class = ""
        elif tag in ("span", "b", "strong", "em", "i", "sup", "a", "br"):
            if tag == "br":
                self.p_buf.append(" ")

    def handle_startendtag(self, tag, attrs):
        if tag == "hr" and not self.skip_depth:
            self.flush_p()
            self.out.append("---")

    def handle_endtag(self, tag):
        if tag in SKIP_TAGS:
            self.skip_depth -= 1
            return
        if self.skip_depth:
            return
        if tag == "p":
            self.flush_p()

    def handle_data(self, data):
        if self.skip_depth:
            return
        if self.in_p:
            self.p_buf.append(data)
        else:
            # whitespace between blocks only
            pass

    def result(self):
        self.flush_p()
        # Merge standalone enumeration markers "(4)" with the following
        # paragraph — EUR-Lex renders recitals as number-cell + text-cell.
        merged = []
        i = 0
        while i < len(self.out):
            cur = self.out[i]
            if re.fullmatch(r"\(\d+\)", cur.strip()) and i + 1 < len(self.out):
                nxt = self.out[i + 1].strip()
                if nxt and not nxt.startswith("---"):
                    merged.append(cur.strip() + " " + nxt)
                    i += 2
                    continue
            merged.append(cur)
            i += 1
        body = "\n\n".join(merged)
        md = body
        if self.notes:
            md += "\n\n---\n\n## Footnotes\n\n" + "\n\n".join(self.notes)
        md = re.sub(r"\n{4,}", "\n\n\n", md)
        return md.strip() + "\n"


def main():
    src, dst = sys.argv[1], sys.argv[2]
    with open(src, encoding="utf-8") as f:
        html = f.read()
    conv = Converter()
    conv.feed(html)
    header = (
        "<!-- Converted from official EUR-Lex / Publications Office XHTML.\n"
        "     Source: see corpus/SOURCES.md. Legal wording preserved verbatim;\n"
        "     conversion affects layout only. Raw HTML kept alongside this file. -->\n\n"
    )
    with open(dst, "w", encoding="utf-8") as f:
        f.write(header + conv.result())
    print(f"{src} -> {dst}")


if __name__ == "__main__":
    main()
