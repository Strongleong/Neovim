return {
  s(
    "lz",
    fmta(
      [[
      /** @var <> $<> */
      private $<>;

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
        i(1, "Type"),   -- @var Type
        i(2, "var"),    --              name
        rep(2),         -- private Type
        rep(1),         -- @return Type
        rep(1),         -- getType()
        rep(2),         -- if $this->name
        rep(2),         -- $this->name =
        rep(1),         --               new Type
        rep(2),         -- return $this->name
      }
    )
  ),
  s(
    "lzz",
    fmta(
      [[
      /** @var <> $<> */
      private <> $<>;

      /**
       * @return <>
       */
      protected function get<>(): <>
      {
          if ($this->><> === null) {
              $this->><> = new <>();
          }

          return $this->><>;
      }
      ]],
      {
        i(1, "Type"), -- @var Type
        i(2, "var"),  --              name
        rep(1),       -- private Type
        rep(2),       --              name
        rep(1),       -- @return Type
        rep(1),       -- getType()
        rep(1),       --          : Type
        rep(2),       -- if $this->name
        rep(2),       -- $this->name =
        rep(1),       --               new Type
        rep(2),       -- return $this->name
      }
    )
  ),
  s(
    "lzn",
    fmta(
      [[
      /** @var <> $<> */
      private ?<> $<> = null;

      /**
       * @return <>
       */
      protected function get<>(): <>
      {
          if ($this->><> === null) {
              $this->><> = new <>();
          }

          return $this->><>;
      }
      ]],
      {
        i(1, "Type"), -- @var ?Type
        i(2, "var"),  --              name
        rep(1),       -- private ?Type
        rep(2),       --              name
        rep(1),       -- @return Type
        rep(1),       -- getType()
        rep(1),       --          : Type
        rep(2),       -- if $this->name
        rep(2),       -- $this->name =
        rep(1),       --               new Type
        rep(2),       -- return $this->name
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
