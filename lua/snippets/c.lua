return {
  s("div", {
    t('/******'), l(l._1:gsub(".", "*"), 1), t({ "******",  "" }),
    t(' *     '), i(1, "comment"),           t({ "     *",  "" }),
    t(' ******'), l(l._1:gsub(".", "*"), 1), t({ "******/", "" }),
  })
}
