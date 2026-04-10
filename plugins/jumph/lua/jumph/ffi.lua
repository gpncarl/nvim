local ffi = require('ffi')
local C = ffi.C

-- FFI definitions
ffi.cdef([[
  typedef int32_t linenr_T;
  typedef unsigned char char_u;
  typedef struct regprog regprog_T;
  typedef int colnr_T;

  typedef struct {
    linenr_T lnum;
    colnr_T col;
  } lpos_T;
]])

ffi.cdef([[
  typedef struct {
    regprog_T *regprog;
    lpos_T startpos[10];
    lpos_T endpos[10];
    colnr_T rmm_matchcol;
    int rmm_ic;
    colnr_T rmm_maxcol;
  } regmmatch_T;
]])

ffi.cdef([[
  typedef struct {} Error;
  typedef struct window_S win_T;
  typedef struct file_buffer buf_T;

  buf_T *find_buffer_by_handle(int buffer, Error *err);
  win_T *find_window_by_handle(int window, Error *err);

  regprog_T *vim_regcomp(char_u *expr_arg, int re_flags);
  int ignorecase(char_u *pat);

  long vim_regexec_multi(regmmatch_T *rmp, win_T *win, buf_T *buf,
    linenr_T lnum, colnr_T col, void *dummy_ptr, int *timed_out);
]])

ffi.cdef([[colnr_T ml_get_buf_len(buf_T *buf, linenr_T lnum);]])

local Cchar_u_VLA = ffi.typeof('char_u[?]')
local Cregmmatch_T = ffi.typeof('regmmatch_T')

-- Must stay referenced to avoid GC during vim_regexec_multi
local Cpattern

local function get_buf_len(buf, lnum)
  return tonumber(C.ml_get_buf_len(buf, lnum))
end

local function build_regmatch(pat)
  Cpattern = Cchar_u_VLA(#pat + 1)
  ffi.copy(Cpattern, pat)
  local regprog = C.vim_regcomp(Cpattern, vim.o.magic and 1 or 0)
  if regprog == nil then
    return
  end
  local regm = Cregmmatch_T()
  regm.regprog = regprog
  regm.rmm_ic = C.ignorecase(Cpattern)
  regm.rmm_maxcol = 0
  return regm
end

return {
  ffi = ffi,
  C = C,
  build_regmatch = build_regmatch,
  get_buf_len = get_buf_len,
}
