local M = {}

M.spread = function(template)
    local result = {}
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end

M.countWords = function(string)
    local _, n = string:gsub("%S+", "")
    return n
end

M.split = function(inputstr, sep)
    local res = {}

    if sep == nil then
        sep = "%s"
    end

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(res, str)
    end

    return res
end

M.is_windows = vim.uv.os_uname().sysname == "Windows_NT"

M.find_git_root = function (filepath)
  local function get_folder_from_filepath(fp)
    return fp:match("(.*/)")
  end

  filepath = get_folder_from_filepath(filepath)

  -- The Git command to find the top-level directory
  local git_cmd = "git -C " .. filepath .. " rev-parse --show-toplevel"

  -- Execute the Git command
  local git_root = vim.fn.system(git_cmd)

  -- Handling errors (if the file is not in a Git repository or other issues)
  if vim.v.shell_error ~= 0 then
    print("NeogitRel: Error finding Git root: " .. git_root)
    return nil
  end

  -- Trim any newlines from the output
  git_root = git_root:gsub("%s+", "")

  return git_root
end

M.open_neogit_from_current_file = function (opts)
  opts = opts or {}
  local gitroot = M.find_git_root(vim.fn.expand("%:p"))
  if gitroot == nil then
    print("NeogitRel: Not in a git repo")
    return
  end

  -- Prepare options
  opts = vim.tbl_extend("force", { cwd = gitroot }, opts)

  require "neogit".open(opts)
end

return M
