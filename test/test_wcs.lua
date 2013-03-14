local lunit = require "lunit"
local tutil = require "utils"
local TEST_CASE, skip = tutil.TEST_CASE, tutil.skip

local IS_WINDOWS = package.config:sub(1,1) == '\\'
if not IS_WINDOWS then
  local _ENV = TEST_CASE('WCS')
  test = skip"windows only tests"
  return lunit.run()
end

local function self_test(wcs)
  local assert = lunit.assert
  local assert_nil = lunit.assert_nil
  local assert_equal = lunit.assert_equal

  -- assert_nil(wcs.wcstoansi(nil))
  -- assert_nil(wcs.ansitowcs(nil))

  assert_equal("", wcs.wcstoansi(""))
  assert_equal("", wcs.ansitowcs(""))

  local str = "D\0�\0m\0�\0�\0�\0�\0�\0�\0g\0�\0l\0"
  local res = "DemonicAngel"
  assert(wcs.wcstooem(str) == res)



  local str = "D\0�\0m\0�\0�\0�\0�\0�\0�\0g\0�\0l\0"
  local res = "DemonicAngel"
  assert(wcs.wcstoansi(str) == res)

  local str = "D\0�\0m\0�\0�\0�\0�\0�\0�\0g\0�\0l\0"
  local res = "DemonicAngel"
  assert(wcs.wcstooem(str) == res)

  local str = "\68\235\109\243\241\236\231\196\241\103\233\108"
  local res = "\68\0\59\4\109\0\67\4\65\4\60\4\55\4\20\4\65\4\103\0\57\4\108\0"
  assert(wcs.ansitowcs(str) == res)

  local str = "\68\137\109\162\164\141\135\142\164\103\130\108"
  local res = "\68\0\25\4\109\0\50\4\52\4\29\4\23\4\30\4\52\4\103\0\18\4\108\0"
  assert(wcs.oemtowcs(str) == res)

  -- iconv
  local utf8 = "\65\111\32\108\111\110\103\101\44\32\97\111\32\108\117\97\114"
  .. "\10\78\111\32\114\105\111\32\117\109\97\32\118\101\108\97\10\83\101\114"
  .. "\101\110\97\32\97\32\112\97\115\115\97\114\44\10\81\117\101\32\195\169\32"
  .. "\113\117\101\32\109\101\32\114\101\118\101\108\97\10\10\78\195\163\111\32"
  .. "\115\101\105\44\32\109\97\115\32\109\117\101\32\115\101\114\10\84\111\114"
  .. "\110\111\117\45\115\101\45\109\101\32\101\115\116\114\97\110\104\111\44"
  .. "\10\69\32\101\117\32\115\111\110\104\111\32\115\101\109\32\118\101\114\10"
  .. "\79\115\32\115\111\110\104\111\115\32\113\117\101\32\116\101\110\104\111"
  .. "\46\10\10\81\117\101\32\97\110\103\195\186\115\116\105\97\32\109\101\32"
  .. "\101\110\108\97\195\167\97\63\10\81\117\101\32\97\109\111\114\32\110\195"
  .. "\163\111\32\115\101\32\101\120\112\108\105\99\97\63\10\195\137\32\97\32"
  .. "\118\101\108\97\32\113\117\101\32\112\97\115\115\97\10\78\97\32\110\111"
  .. "\105\116\101\32\113\117\101\32\102\105\99\97\10\10\32\32\32\32\45\45\32"
  .. "\70\101\114\110\97\110\100\111\32\80\101\115\115\111\97\10"

  local utf16 = "\255\254\65\0\111\0\32\0\108\0\111\0\110\0\103\0\101\0\44\0\32"
  .. "\0\97\0\111\0\32\0\108\0\117\0\97\0\114\0\10\0\78\0\111\0\32\0\114\0\105"
  .. "\0\111\0\32\0\117\0\109\0\97\0\32\0\118\0\101\0\108\0\97\0\10\0\83\0\101"
  .. "\0\114\0\101\0\110\0\97\0\32\0\97\0\32\0\112\0\97\0\115\0\115\0\97\0\114"
  .. "\0\44\0\10\0\81\0\117\0\101\0\32\0\233\0\32\0\113\0\117\0\101\0\32\0\109"
  .. "\0\101\0\32\0\114\0\101\0\118\0\101\0\108\0\97\0\10\0\10\0\78\0\227\0\111"
  .. "\0\32\0\115\0\101\0\105\0\44\0\32\0\109\0\97\0\115\0\32\0\109\0\117\0\101"
  .. "\0\32\0\115\0\101\0\114\0\10\0\84\0\111\0\114\0\110\0\111\0\117\0\45\0\115"
  .. "\0\101\0\45\0\109\0\101\0\32\0\101\0\115\0\116\0\114\0\97\0\110\0\104\0"
  .. "\111\0\44\0\10\0\69\0\32\0\101\0\117\0\32\0\115\0\111\0\110\0\104\0\111"
  .. "\0\32\0\115\0\101\0\109\0\32\0\118\0\101\0\114\0\10\0\79\0\115\0\32\0\115"
  .. "\0\111\0\110\0\104\0\111\0\115\0\32\0\113\0\117\0\101\0\32\0\116\0\101\0"
  .. "\110\0\104\0\111\0\46\0\10\0\10\0\81\0\117\0\101\0\32\0\97\0\110\0\103\0"
  .. "\250\0\115\0\116\0\105\0\97\0\32\0\109\0\101\0\32\0\101\0\110\0\108\0\97"
  .. "\0\231\0\97\0\63\0\10\0\81\0\117\0\101\0\32\0\97\0\109\0\111\0\114\0\32"
  .. "\0\110\0\227\0\111\0\32\0\115\0\101\0\32\0\101\0\120\0\112\0\108\0\105\0"
  .. "\99\0\97\0\63\0\10\0\201\0\32\0\97\0\32\0\118\0\101\0\108\0\97\0\32\0\113"
  .. "\0\117\0\101\0\32\0\112\0\97\0\115\0\115\0\97\0\10\0\78\0\97\0\32\0\110"
  .. "\0\111\0\105\0\116\0\101\0\32\0\113\0\117\0\101\0\32\0\102\0\105\0\99\0"
  .. "\97\0\10\0\10\0\32\0\32\0\32\0\32\0\45\0\45\0\32\0\70\0\101\0\114\0\110"
  .. "\0\97\0\110\0\100\0\111\0\32\0\80\0\101\0\115\0\115\0\111\0\97\0\10\0"

  assert(utf16:sub(3) == wcs.utf8towcs(utf8))         -- without bom
  assert(utf8         == wcs.wcstoutf8(utf16:sub(3))) -- without bom
end

local function prequire(...)
  local ok, mod = pcall(require, ...)
  if not ok then return nil, mod end
  return mod
end

local _ENV = TEST_CASE('WCS ffi')
if not prequire"ffi" then test = skip"ffi module not found" else 

local wcs

function setup() wcs = require "path.win32.wcs".load("ffi") end

function test() self_test(wcs) end

end

local _ENV = TEST_CASE('WCS alien')
if not prequire"alien" then test = skip"alien module not found" else 

local wcs

function setup() wcs = require "path.win32.wcs".load("alien") end

function test() self_test(wcs) end

end

local _ENV = TEST_CASE('WCS afx')
if not prequire"afx" then test = skip"afx module not found" else 

local wcs

function setup() wcs = require "path.win32.wcs".load("afx") end

function test() self_test(wcs) end

end

if not LUNIT_RUN then lunit.run() end