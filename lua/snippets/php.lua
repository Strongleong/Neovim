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
  s("log", fmt("\\SakhCom\\Core\\Debug\\Logger::getInstance()->log('{}', ${});", {i(1, 'Debug'), i(0) })),
  s("acl",
    fmt(
      [[
      env()->getResponse()->setJsonResponse(true);
      env()->getResponse()->setAjaxDebuggingEnabled(true);
      env()->getResponse()->setContent([${}]);
      env()->getResponse()->send();
      env()->shutdown();
      ]],
      { i(0) }
    )
  ),
  s("show_errors", {
    t({"ini_set('display_errors', '1');", "" }),
    t({"ini_set('display_startup_errors', '1');", "" }),
    t({"error_reporting(E_ALL);                ", "" })
  }),
}
