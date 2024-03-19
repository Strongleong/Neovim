return {
  s(
    "main",
    fmt([[
    #!/usr/bin/env python3

    def main():
        {}


    if __name__ == "__main__":
        main()
    ]], { i(0, "pass") })
  );
}
