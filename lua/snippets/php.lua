return {
  s(
    "lzget",
    fmta(
      [[
      /** @var <> $<> */
      private <> $<>;

      /**
       * @return <>
       */
      protected function get<>()
      {
          if ($this->><> === null) {
              $this->><> = new <>();
          }

          return $this->><>;
      }
      ]],
      {
        i(1, "Type"),
        i(2, "var"),
        rep(1),
        rep(2),
        rep(1),
        rep(1),
        rep(2),
        rep(2),
        rep(1),
        rep(2),
      }
    )
  ),
  s("pre",
    fmt(
      [[
      echo '<pre>';
      var_dump({});
      echo '</pre>';
      die;
      ]],
      { i(0) }
    )
  ),
  s("log", fmt("Logger::getInstance()->log(${});", { i(0) })),
}
