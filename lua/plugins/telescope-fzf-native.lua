return {
  'nvim-telescope/telescope-fzf-native.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
}
