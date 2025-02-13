return {
  s("div", {
    t('/******'), l(l._1:gsub(".", "*"), 1), t({ "******", "" }),
    t(' *     '), i(1, "comment"), t({ "     *", "" }),
    t(' ******'), l(l._1:gsub(".", "*"), 1), t({ "******/", "" }),
  }),

  s("hello_world",
    fmt(
      [[
      #include <stdio.h>

      int main(void) {
        printf("56\n");
        return 0;
      }
      ]],
      { i(1, "Hello, World!") },
      { delimiters = "56" }
    )
  )
}
