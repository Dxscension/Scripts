local module = {}
--// basic module \\--
module.status = "Loading"



local LOAD = (function(...) local Ju = string.sub local Ki = string.gmatch local It = tonumber local If = string.find local Sf = string.byte local Hy = string.format  local b = (function(...) local c = {} local d = {} local e = {} local f = {} local g = {} local h = {} local i = 8 local function j(k) if not k then return 0 end end function c:z(o) local p = 512 local q = 1 return function() local l = o:sub(q, q + p - 1) q = math.min(#o + 1, q + p) return l end end function c:Il(r, n) if not r then return end local s = {} s.r = r s.d = n or "" s.n = n if not n or n == "" then s.n = 0 else s.n = #n end s.p = 0 return s end function c:fc(s) local l = s.r() s.d = l if not l or l == "" then return "EOZ" end s.n, s.p = #l - 1, 1 return Ju(l, 1, 1) end function c:gz(s) local t, u = s.n, s.p + 1 if t > 0 then s.n, s.p = t - 1, u return Ju(s.d, u, u) else return self:fc(s) end end e.r = "TK_AND and\nTK_BREAK break\nTK_DO do\nTK_ELSE else\nTK_ELSEIF elseif\nTK_END end\nTK_FALSE false\nTK_FOR for\nTK_FUNCTION function\nTK_IF if\nTK_IN in\nTK_LOCAL local\nTK_NIL nil\nTK_NOT not\nTK_OR or\nTK_REPEAT repeat\nTK_RETURN return\nTK_THEN then\nTK_TRUE true\nTK_UNTIL until\nTK_WHILE while\nTK_wwww ..\nTK_DOTS ...\nTK_EQ ==\nTK_GE >=\nTK_LE <=\nTK_NE ~=\nTK_NAME <n>\nTK_NUMBER <number>\nTK_STRING <string>\nTK_EOS <eof>" e.ms = 80 e.mi = 2147483645 e.lq = "'%s'" e.ll = 1 function e:Il() local v, w = {}, {} for y in Ki(self.r, "[^\n]+") do local z, z, A, B = If(y, "(%S+)%s+(%S+)") v[A] = B w[B] = A end self.vwvvvvs = v self.enums = w end function e:Ci(o, C) local D local E = Ju(o, 1, 1) if E == "=" then D = Ju(o, 2, C) else if E == "@" then o = Ju(o, 2) C = C - #" '...' " local F = #o D = "" if F > C then o = Ju(o, 1 + F - C) D = D .. "..." end D = D .. o else local G = If(o, "[\n\r]") G = G and G - 1 or #o C = C - #' [string "..."] ' if G > C then G = C end D = '[string "' if G < #o then D = D .. Ju(o, 1, G) .. "..." else D = D .. o end D = D .. '"]' end end return D end function e:vwvvvv2str(H, I) if Ju(I, 1, 3) ~= "TK_" then if If(I, "%c") then return Hy("char(%d)", Sf(I)) end return I else return self.vwvvvvs[I] end end function e:lexerror(H, J, I) local function K(H, I) if I == "TK_NAME" or I == "TK_STRING" or I == "TK_NUMBER" then return H.buff else return self:vwvvvv2str(H, I) end end local l = self:Ci(H.source, self.ms) local J = Hy("%s:%d: %s", l, H.vvvvv, J) if I then J = Hy("%s near " .. self.lq, J, K(H, I)) end error(J) end function e:sR(H, J) self:lexerror(H, J, H.t.vwvvvv) end function e:XcD(H) return H.current == "\n" or H.current == "\r" end function e:incvvvvv(H) local L = H.current self:nextc(H) if self:XcD(H) and H.current ~= L then self:nextc(H) end H.vvvvv = H.vvvvv + 1 if H.vvvvv >= self.mi then self:sR(H, "Xz has too many lines") end end function e:setinput(M, H, s, o) if not H then H = {} end if not H.LA then H.LA = {} end if not H.t then H.t = {} end H.decpoint = "." H.L = M H.LA.vwvvvv = "TK_EOS" H.z = s H.fs = nil H.vvvvv = 1 H.lastline = 1 H.source = o self:nextc(H) end function e:check_next(H, N) if not If(N, H.current, 1, 1) then return false end self:Sy(H) return true end function e:next(H) H.lastline = H.vvvvv if H.LA.vwvvvv ~= "TK_EOS" then H.t.seminfo = H.LA.seminfo H.t.vwvvvv = H.LA.vwvvvv H.LA.vwvvvv = "TK_EOS" else H.t.vwvvvv = self:llex(H, H.t) end end function e:LA(H) H.LA.vwvvvv = self:llex(H, H.LA) end function e:nextc(H) local O = c:gz(H.z) H.current = O return O end function e:save(H, O) local l = H.buff H.buff = l .. O end function e:Sy(H) self:save(H, H.current) return self:nextc(H) end function e:str2d(P) local Q = It(P) if Q then return Q end if string.lower(Ju(P, 1, 2)) == "0x" then Q = It(P, 16) if Q then return Q end end return nil end function e:buffreplace(H, R, S) local Q, l = "", H.buff for u = 1, #l do local O = Ju(l, u, u) if O == R then O = S end Q = Q .. O end H.buff = Q end function e:trydecpoint(H, T) local L = H.decpoint self:buffreplace(H, L, H.decpoint) local U = self:str2d(H.buff) T.seminfo = U if not U then self:buffreplace(H, H.decpoint, ".") self:lexerror(H, "malformed number", "TK_NUMBER") end end function e:read_numeral(H, T) repeat self:Sy(H) until If(H.current, "%D") and H.current ~= "." if self:check_next(H, "Ee") then self:check_next(H, "+-") end while If(H.current, "^%w$") or H.current == "_" do self:Sy(H) end self:buffreplace(H, ".", H.decpoint) local U = self:str2d(H.buff) T.seminfo = U if not U then self:trydecpoint(H, T) end end function e:skip_sep(H) local V = 0 local P = H.current self:Sy(H) while H.current == "=" do self:Sy(H) V = V + 1 end return H.current == P and V or -V - 1 end function e:RSl(H, T, W) local X = 0 self:Sy(H) if self:XcD(H) then self:incvvvvv(H) end while true do local O = H.current if O == "EOZ" then self:lexerror(H, T and "unfinished long string" or "unfinished long comment", "TK_EOS") elseif O == "[" then if self.ll then if self:skip_sep(H) == W then self:Sy(H) X = X + 1 if self.ll == 1 then if W == 0 then self:lexerror(H, "nesting of [[...]] is deprecated", "[") end end end end elseif O == "]" then if self:skip_sep(H) == W then self:Sy(H) if self.ll and self.ll == 2 then X = X - 1 if W == 0 and X >= 0 then break end end break end elseif self:XcD(H) then self:save(H, "\n") self:incvvvvv(H) if not T then H.buff = "" end else if T then self:Sy(H) else self:nextc(H) end end end if T then local u = 3 + W T.seminfo = Ju(H.buff, u, -u) end end function e:read_string(H, Y, T) self:Sy(H) while H.current ~= Y do local O = H.current if O == "EOZ" then self:lexerror(H, "unfinished string", "TK_EOS") elseif self:XcD(H) then self:lexerror(H, "unfinished string", "TK_STRING") elseif O == "\\" then O = self:nextc(H) if self:XcD(H) then self:save(H, "\n") self:incvvvvv(H) elseif O ~= "EOZ" then local Z = If("abfnrtv", O, 1, 1) if Z then self:save(H, Ju("\a\b\f\n\r\t\v", Z, Z)) self:nextc(H) elseif not If(O, "%d") then self:Sy(H) else O, Z = 0, 0 repeat O = 10 * O + H.current self:nextc(H) Z = Z + 1 until Z >= 3 or not If(H.current, "%d") if O > 255 then self:lexerror(H, "escape sequence too large", "TK_STRING") end self:save(H, string.char(O)) end end else self:Sy(H) end end self:Sy(H) T.seminfo = Ju(H.buff, 2, -2) end function e:llex(H, T) H.buff = "" while true do local O = H.current if self:XcD(H) then self:incvvvvv(H) elseif O == "-" then O = self:nextc(H) if O ~= "-" then return "-" end local W = -1 if self:nextc(H) == "[" then W = self:skip_sep(H) H.buff = "" end if W >= 0 then self:RSl(H, nil, W) H.buff = "" else while not self:XcD(H) and H.current ~= "EOZ" do self:nextc(H) end end elseif O == "[" then local W = self:skip_sep(H) if W >= 0 then self:RSl(H, T, W) return "TK_STRING" elseif W == -1 then return "[" else self:lexerror(H, "invalid long string delimiter", "TK_STRING") end elseif O == "=" then O = self:nextc(H) if O ~= "=" then return "=" else self:nextc(H) return "TK_EQ" end elseif O == "<" then O = self:nextc(H) if O ~= "=" then return "<" else self:nextc(H) return "TK_LE" end elseif O == ">" then O = self:nextc(H) if O ~= "=" then return ">" else self:nextc(H) return "TK_GE" end elseif O == "~" then O = self:nextc(H) if O ~= "=" then return "~" else self:nextc(H) return "TK_NE" end elseif O == '"' or O == "'" then self:read_string(H, O, T) return "TK_STRING" elseif O == "." then O = self:Sy(H) if self:check_next(H, ".") then if self:check_next(H, ".") then return "TK_DOTS" else return "TK_wwww" end elseif not If(O, "%d") then return "." else self:read_numeral(H, T) return "TK_NUMBER" end elseif O == "EOZ" then return "TK_EOS" else if If(O, "%s") then self:nextc(H) elseif If(O, "%d") then self:read_numeral(H, T) return "TK_NUMBER" elseif If(O, "[_%a]") then repeat O = self:Sy(H) until O == "EOZ" or not If(O, "[_%w]") local _ = H.buff local A = self.enums[_] if A then return A end T.seminfo = _ return "TK_NAME" else self:nextc(H) return O end end end end f.OpMode = {iABC = 0, iABx = 1, iAsBx = 2} f.SIZE_C = 9 f.SIZE_B = 9 f.SIZE_Bx = f.SIZE_C + f.SIZE_B f.SIZE_A = 8 f.SIZE_OP = 6 f.POS_OP = 0 f.POS_A = f.POS_OP + f.SIZE_OP f.POS_C = f.POS_A + f.SIZE_A f.POS_B = f.POS_C + f.SIZE_C f.POS_Bx = f.POS_C f.MAXARG_Bx = math.ldexp(1, f.SIZE_Bx) - 1 f.MAXARG_sBx = math.floor(f.MAXARG_Bx / 2) f.MAXARG_A = math.ldexp(1, f.SIZE_A) - 1 f.MAXARG_B = math.ldexp(1, f.SIZE_B) - 1 f.MAXARG_C = math.ldexp(1, f.SIZE_C) - 1 function f:go(Z) return self.ROpC[Z.OP] end function f:Bd(Z, a0) Z.OP = self.OpC[a0] end function f:Xc(Z) return Z.A end function f:Sa(Z, a1) Z.A = a1 end function f:GETARG_B(Z) return Z.B end function f:ST(Z, m) Z.B = m end function f:GETARG_C(Z) return Z.C end function f:Sc(Z, m) Z.C = m end function f:GETARG_Bx(Z) return Z.Bx end function f:SETARG_Bx(Z, m) Z.Bx = m end function f:gv(Z) return Z.Bx - self.MAXARG_sBx end function f:jk(Z, m) Z.Bx = m + self.MAXARG_sBx end function f:CREATE_ABC(a0, a2, m, O) return {OP = self.OpC[a0], A = a2, B = m, C = O} end function f:CREATE_ABx(a0, a2, a3) return {OP = self.OpC[a0], A = a2, Bx = a3} end function f:CREATE_Inst(O) local a0 = O % 64 O = (O - a0) / 64 local a2 = O % 256 O = (O - a2) / 256 return self:CREATE_ABx(a0, a2, O) end function f:Instruction(Z) if Z.Bx then Z.C = Z.Bx % 512 Z.B = (Z.Bx - Z.C) / 512 end local a4 = Z.A * 64 + Z.OP local a5 = a4 % 256 a4 = Z.C * 64 + (a4 - a5) / 256 local a6 = a4 % 256 a4 = Z.B * 128 + (a4 - a6) / 256 local a7 = a4 % 256 local a8 = (a4 - a7) / 256 return string.char(a5, a6, a7, a8) end function f:DeCInst(x) local a9 = Sf local Z = {} local a4 = a9(x, 1) local aa = a4 % 64 Z.OP = aa a4 = a9(x, 2) * 4 + (a4 - aa) / 64 local a2 = a4 % 256 Z.A = a2 a4 = a9(x, 3) * 4 + (a4 - a2) / 256 local O = a4 % 512 Z.C = O Z.B = a9(x, 4) * 2 + (a4 - O) / 512 local ab = self.OpMode[It(Ju(self.opmodes[aa + 1], 7, 7))] if ab ~= "iABC" then Z.Bx = Z.B * 512 + Z.C end return Z end f.BITRK = math.ldexp(1, f.SIZE_B - 1) function f:ISK(x) return x >= self.BITRK end function f:INDEXK(ac) return x - self.BITRK end f.MAXINDEXRK = f.BITRK - 1 function f:RKASK(x) return x + self.BITRK end f.NO_REG = f.MAXARG_A f.opns = {} f.OpC = {} f.ROpC = {} local Z = 0 for y in Ki( "MOVE LOADK LOADBOOL LOADNIL GETUa\nGETGLOBAL GETTABLE SETGLOBAL SETUa SETTABLE\nNEWTABLE SELF ADD SUB MUL\nDIV MOD POW UNM NOT\nLEN wwww JMP EQ LT\nLE TEST TESTSET CALL TAILCALL\nRETURN FORLOOP FORPREP TFORLOOP SETLIST\nCLOSE CLOSURE VARARG", "%S+" ) do local t = "OP_" .. y f.opns[Z] = y f.OpC[t] = Z f.ROpC[Z] = t Z = Z + 1 end f.NUM_OPCS = Z f.OpArgMask = {OpArgN = 0, OpArgU = 1, OpArgR = 2, OpArgK = 3} function f:getOpMode(ad) return self.opmodes[self.OpC[ad]] % 4 end function f:getBMode(ad) return math.floor(self.opmodes[self.OpC[ad]] / 16) % 4 end function f:getCMode(ad) return math.floor(self.opmodes[self.OpC[ad]] / 4) % 4 end function f:testAMode(ad) return math.floor(self.opmodes[self.OpC[ad]] / 64) % 2 end function f:to(ad) return math.floor(self.opmodes[self.OpC[ad]] / 128) end f.LFFS_PER_FLUSH = 50 local function ab(ae, a2, m, O, ad) local f = f return ae * 128 + a2 * 64 + f.OpArgMask[m] * 16 + f.OpArgMask[O] * 4 + f.OpMode[ad] end f.opmodes = { ab(0, 1, "OpArgK", "OpArgN", "iABx"), ab(0, 1, "OpArgU", "OpArgU", "iABC"), ab(0, 1, "OpArgR", "OpArgN", "iABC"), ab(0, 1, "OpArgU", "OpArgN", "iABC"), ab(0, 1, "OpArgK", "OpArgN", "iABx"), ab(0, 1, "OpArgR", "OpArgK", "iABC"), ab(0, 0, "OpArgK", "OpArgN", "iABx"), ab(0, 0, "OpArgU", "OpArgN", "iABC"), ab(0, 0, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgU", "OpArgU", "iABC"), ab(0, 1, "OpArgR", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgK", "OpArgK", "iABC"), ab(0, 1, "OpArgR", "OpArgN", "iABC"), ab(0, 1, "OpArgR", "OpArgN", "iABC"), ab(0, 1, "OpArgR", "OpArgN", "iABC"), ab(0, 1, "OpArgR", "OpArgR", "iABC"), ab(0, 0, "OpArgR", "OpArgN", "iAsBx"), ab(1, 0, "OpArgK", "OpArgK", "iABC"), ab(1, 0, "OpArgK", "OpArgK", "iABC"), ab(1, 0, "OpArgK", "OpArgK", "iABC"), ab(1, 1, "OpArgR", "OpArgU", "iABC"), ab(1, 1, "OpArgR", "OpArgU", "iABC"), ab(0, 1, "OpArgU", "OpArgU", "iABC"), ab(0, 1, "OpArgU", "OpArgU", "iABC"), ab(0, 0, "OpArgU", "OpArgN", "iABC"), ab(0, 1, "OpArgR", "OpArgN", "iAsBx"), ab(0, 1, "OpArgR", "OpArgN", "iAsBx"), ab(1, 0, "OpArgN", "OpArgU", "iABC"), ab(0, 0, "OpArgU", "OpArgU", "iABC"), ab(0, 0, "OpArgN", "OpArgN", "iABC"), ab(0, 1, "OpArgU", "OpArgN", "iABx"), ab(0, 1, "OpArgU", "OpArgN", "iABC") } f.opmodes[0] = ab(0, 1, "OpArgR", "OpArgN", "iABC") g.LUA_SIGNATURE = "\27Lua" g.LUA_TNUMBER = 3 g.LUA_TSTRING = 4 g.LUA_TNIL = 0 g.LUA_TBOOLEAN = 1 g.LUA_TNONE = -1 g.LUAC_VERSION = 0x51 g.LUAC_FORMAT = 0 g.LUAC_HEADERSIZE = 12 function g:make_setS() local l = {} l.d = "" local af = function(P, l) if not P then return 0 end l.d = l.d .. P return 0 end return af, l end function g:make_setF(ag) local l = {} l.h = io.open(ag, "wb") if not l.h then return nil end local af = function(P, l) if not l.h then return 0 end if not P then if l.h:close() then return 0 end else if l.h:write(P) then return 0 end end return 1 end return af, l end function g:ttype(a0) local ah = type(a0.value) if ah == "number" then return self.LUA_TNUMBER elseif ah == "string" then return self.LUA_TSTRING elseif ah == "nil" then return self.LUA_TNIL elseif ah == "boolean" then return self.LUA_TBOOLEAN else return self.LUA_TNONE end end function g:from_double(x) local function ai(y) local O = y % 256 return (y - O) / 256, string.char(O) end local aj = 0 if x < 0 then aj = 1 x = -x end local ak, al = math.frexp(x) if x == 0 then ak, al = 0, 0 elseif x == 1 / 0 then ak, al = 0, 2047 else ak = (ak * 2 - 1) * math.ldexp(0.5, 53) al = al + 1022 end local y, a9 = "" x = math.floor(ak) for Z = 1, 6 do x, a9 = ai(x) y = y .. a9 end x, a9 = ai(al * 16 + x) y = y .. a9 x, a9 = ai(aj * 128 + x) y = y .. a9 return y end function g:from_int(x) local y = "" x = math.floor(x) if x < 0 then x = 4294967296 + x end for Z = 1, 4 do local O = x % 256 y = y .. string.char(O) x = math.floor(x / 256) end return y end function g:Dumpbg(m, am) if am.status == 0 then am.status = am.write(m, am.d) end end function g:DumpChar(an, am) self:Dumpbg(string.char(an), am) end function g:DumpInt(x, am) self:Dumpbg(self:from_int(x), am) end function g:DumpSizeT(x, am) self:Dumpbg(self:from_int(x), am) if i == 8 then self:Dumpbg(self:from_int(0), am) end end function g:DumpNumber(x, am) self:Dumpbg(self:from_double(x), am) end function g:DumpString(P, am) if P == nil then self:DumpSizeT(0, am) else P = P .. "\0" self:DumpSizeT(#P, am) self:Dumpbg(P, am) end end function g:DumpC(ao, am) local t = ao.sizeC self:DumpInt(t, am) for Z = 0, t - 1 do self:Dumpbg(f:Instruction(ao.C[Z]), am) end end function g:DumpConstants(ao, am) local t = ao.sizek self:DumpInt(t, am) for Z = 0, t - 1 do local a0 = ao.k[Z] local ah = self:ttype(a0) self:DumpChar(ah, am) if ah == self.LUA_TNIL then elseif ah == self.LUA_TBOOLEAN then self:DumpChar(a0.value and 1 or 0, am) elseif ah == self.LUA_TNUMBER then self:DumpNumber(a0.value, am) elseif ah == self.LUA_TSTRING then self:DumpString(a0.value, am) else end end t = ao.sizep self:DumpInt(t, am) for Z = 0, t - 1 do self:DumpFunction(ao.p[Z], ao.source, am) end end function g:DumpDebug(ao, am) local t t = am.strip and 0 or ao.sizelineinfo self:DumpInt(t, am) for Z = 0, t - 1 do self:DumpInt(ao.lineinfo[Z], am) end t = am.strip and 0 or ao.sizelocvars self:DumpInt(t, am) for Z = 0, t - 1 do self:DumpString(ao.locvars[Z].varn, am) self:DumpInt(ao.locvars[Z].vwwvv, am) self:DumpInt(ao.locvars[Z].endpc, am) end t = am.strip and 0 or ao.sizeUaues self:DumpInt(t, am) for Z = 0, t - 1 do self:DumpString(ao.Uaues[Z], am) end end function g:DumpFunction(ao, u, am) local o = ao.source if o == u or am.strip then o = nil end self:DumpString(o, am) self:DumpInt(ao.lineDefined, am) self:DumpInt(ao.lastlinedefined, am) self:DumpChar(ao.nups, am) self:DumpChar(ao.numparams, am) self:DumpChar(ao.is_vararg, am) self:DumpChar(ao.Sz, am) self:DumpC(ao, am) self:DumpConstants(ao, am) self:DumpDebug(ao, am) end function g:DumpHeader(am) local ap = self:header() assert(#ap == self.LUAC_HEADERSIZE) self:Dumpbg(ap, am) end function g:header() local x = 1 return self.LUA_SIGNATURE .. string.char(self.LUAC_VERSION, self.LUAC_FORMAT, x, 4, i, 4, 8, 0) end function g:dump(M, ao, aq, n, ar) local am = {} am.L = M am.write = aq am.d = n am.strip = ar am.status = 0 self:DumpHeader(am) self:DumpFunction(ao, nil, am) am.write(nil, am.d) return am.status end h.Sm = 250 function h:ttisnumber(a0) if a0 then return type(a0.value) == "number" else return false end end function h:nvalue(a0) return a0.value end function h:setnilvalue(a0) a0.value = nil end function h:setsvalue(a0, x) a0.value = x end h.setnvalue = h.setsvalue h.sethvalue = h.setsvalue h.setbvalue = h.setsvalue function h:numadd(a2, m) return a2 + m end function h:numsub(a2, m) return a2 - m end function h:nummul(a2, m) return a2 * m end function h:numdiv(a2, m) return a2 / m end function h:nummod(a2, m) return a2 % m end function h:numpow(a2, m) return a2 ^ m end function h:numunm(a2) return -a2 end function h:numisnan(a2) return not a2 == a2 end h.bt = -1 h.BinOpr = { OPR_ADD = 0, OPR_SUB = 1, OPR_MUL = 2, OPR_DIV = 3, OPR_MOD = 4, OPR_POW = 5, OPR_wwww = 6, OPR_NE = 7, OPR_EQ = 8, OPR_LT = 9, OPR_LE = 10, OPR_GT = 11, OPR_GE = 12, OPR_AND = 13, OPR_OR = 14, OPR_NOBINOPR = 15 } h.UnOpr = {OPR_MINUS = 0, OPR_NOT = 1, OPR_LEN = 2, OPR_NOUNOPR = 3} function h:gC(as, at) return as.f.C[at.info] end function h:Cg(as, a0, au, av) return self:vvwwv(as, a0, au, av + f.MAXARG_sBx) end function h:mS(as, at) self:setreturns(as, at, d.lM) end function h:hasjps(at) return at.t ~= at.f end function h:isnumeral(at) return at.k == "VKNUM" and at.t == self.bt and at.f == self.bt end function h:_nil(as, R, t) if as.pc > as.lasttarget then if as.pc == 0 then if R >= as.wv then return end else local aw = as.f.C[as.pc - 1] if f:go(aw) == "OP_LOADNIL" then local ax = f:Xc(aw) local ay = f:GETARG_B(aw) if ax <= R and R <= ay + 1 then if R + t - 1 > ay then f:ST(aw, R + t - 1) end return end end end end self:Ax(as, "OP_LOADNIL", R, R + t - 1, 0) end function h:jp(as) local az = as.jpc as.jpc = self.bt local aA = self:Cg(as, "OP_JMP", 0, self.bt) aA = self:wwww(as, aA, az) return aA end function h:Vc(as, E, aB) self:Ax(as, "OP_RETURN", E, aB + 1, 0) end function h:bx(as, aa, au, aC, aD) self:Ax(as, aa, au, aC, aD) return self:jp(as) end function h:v(as, aE, aF) local aG = as.f.C[aE] local aH = aF - (aE + 1) j(aF ~= self.bt) if math.abs(aH) > f.MAXARG_sBx then e:sR(as.ls, "control structure too long") end f:jk(aG, aH) end function h:Lr(as) as.lasttarget = as.pc return as.pc end function h:yk(as, aE) local aH = f:gv(as.f.C[aE]) if aH == self.bt then return self.bt else return aE + 1 + aH end end function h:cc(as, aE) local aI = as.f.C[aE] local aJ = as.f.C[aE - 1] if aE >= 1 and f:to(f:go(aJ)) ~= 0 then return aJ else return aI end end function h:Nc(as, aK) while aK ~= self.bt do local Z = self:cc(as, aK) if f:go(Z) ~= "OP_TESTSET" then return true end aK = self:yk(as, aK) end return false end function h:PsT(as, aL, aM) local Z = self:cc(as, aL) if f:go(Z) ~= "OP_TESTSET" then return false end if aM ~= f.NO_REG and aM ~= f:GETARG_B(Z) then f:Sa(Z, aM) else f:Bd(Z, "OP_TEST") local m = f:GETARG_B(Z) f:Sa(Z, m) f:ST(Z, 0) end return true end function h:RV(as, aK) while aK ~= self.bt do self:PsT(as, aK, f.NO_REG) aK = self:yk(as, aK) end end function h:vG(as, aK, aN, aM, aO) while aK ~= self.bt do local aP = self:yk(as, aK) if self:PsT(as, aK, aM) then self:v(as, aK, aN) else self:v(as, aK, aO) end aK = aP end end function h:h(as) self:vG(as, as.jpc, as.pc, f.NO_REG, as.pc) as.jpc = self.bt end function h:gv(as, aK, aQ) if aQ == as.pc then self:g4(as, aK) else j(aQ < as.pc) self:vG(as, aK, aQ, f.NO_REG, aQ) end end function h:g4(as, aK) self:Lr(as) as.jpc = self:wwww(as, as.jpc, aK) end function h:wwww(as, aR, aS) if aS == self.bt then return aR elseif aR == self.bt then return aS else local aK = aR local aP = self:yk(as, aK) while aP ~= self.bt do aK = aP aP = self:yk(as, aK) end self:v(as, aK, aS) end return aR end function h:vwwwvww(as, t) local aT = as.wvvww + t if aT > as.f.Sz then if aT >= self.Sm then e:sR(as.ls, "function or expression too complex") end as.f.Sz = aT end end function h:uy(as, t) self:vwwwvww(as, t) as.wvvww = as.wvvww + t end function h:wvvww(as, aM) if not f:ISK(aM) and aM >= as.wv then as.wvvww = as.wvvww - 1 j(aM == as.wvvww) end end function h:freeexp(as, at) if at.k == "VNONRELOC" then self:wvvww(as, at.info) end end function h:addk(as, aU, y) local M = as.L local aV = as.h[aU.value] local ao = as.f if self:ttisnumber(aV) then return self:nvalue(aV) else aV = {} self:setnvalue(aV, as.nk) as.h[aU.value] = aV d:growvector(M, ao.k, as.nk, ao.sizek, nil, f.MAXARG_Bx, "constant table overflow") ao.k[as.nk] = y local aW = as.nk as.nk = as.nk + 1 return aW end end function h:stringK(as, P) local a0 = {} self:setsvalue(a0, P) return self:addk(as, a0, a0) end function h:vwvv(as, ac) local a0 = {} self:setnvalue(a0, ac) return self:addk(as, a0, a0) end function h:boolK(as, m) local a0 = {} self:setbvalue(a0, m) return self:addk(as, a0, a0) end function h:nilK(as) local aU, y = {}, {} self:setnilvalue(y) self:sethvalue(aU, as.h) return self:addk(as, aU, y) end function h:setreturns(as, at, aX) if at.k == "VCALL" then f:Sc(self:gC(as, at), aX + 1) elseif at.k == "VVARARG" then f:ST(self:gC(as, at), aX + 1) f:Sa(self:gC(as, at), as.wvvww) h:uy(as, 1) end end function h:setoneret(as, at) if at.k == "VCALL" then at.k = "VNONRELOC" at.info = f:Xc(self:gC(as, at)) elseif at.k == "VVARARG" then f:ST(self:gC(as, at), 2) at.k = "VRELOCABLE" end end function h:dischargevars(as, at) local aU = at.k if aU == "VLOCAL" then at.k = "VNONRELOC" elseif aU == "VUa" then at.info = self:Ax(as, "OP_GETUa", 0, at.info, 0) at.k = "VRELOCABLE" elseif aU == "VGLOBAL" then at.info = self:vvwwv(as, "OP_GETGLOBAL", 0, at.info) at.k = "VRELOCABLE" elseif aU == "VINDEXED" then self:wvvww(as, at.aux) self:wvvww(as, at.info) at.info = self:Ax(as, "OP_GETTABLE", 0, at.info, at.aux) at.k = "VRELOCABLE" elseif aU == "VVARARG" or aU == "VCALL" then self:setoneret(as, at) else end end function h:C_label(as, au, m, aY) self:Lr(as) return self:Ax(as, "OP_LOADBOOL", au, m, aY) end function h:discharge2reg(as, at, aM) self:dischargevars(as, at) local aU = at.k if aU == "VNIL" then self:_nil(as, aM, 1) elseif aU == "VFALSE" or aU == "VTRUE" then self:Ax(as, "OP_LOADBOOL", aM, at.k == "VTRUE" and 1 or 0, 0) elseif aU == "VK" then self:vvwwv(as, "OP_LOADK", aM, at.info) elseif aU == "VKNUM" then self:vvwwv(as, "OP_LOADK", aM, self:vwvv(as, at.nval)) elseif aU == "VRELOCABLE" then local aE = self:gC(as, at) f:Sa(aE, aM) elseif aU == "VNONRELOC" then if aM ~= at.info then self:Ax(as, "OP_MOVE", aM, at.info, 0) end else j(at.k == "VVOID" or at.k == "VJMP") return end at.info = aM at.k = "VNONRELOC" end function h:discharge2anyreg(as, at) if at.k ~= "VNONRELOC" then self:uy(as, 1) self:discharge2reg(as, at, as.wvvww - 1) end end function h:exp2reg(as, at, aM) self:discharge2reg(as, at, aM) if at.k == "VJMP" then at.t = self:wwww(as, at.t, at.info) end if self:hasjps(at) then local aZ local a_ = self.bt local b0 = self.bt if self:Nc(as, at.t) or self:Nc(as, at.f) then local b1 = at.k == "VJMP" and self.bt or self:jp(as) a_ = self:C_label(as, aM, 0, 1) b0 = self:C_label(as, aM, 1, 0) self:g4(as, b1) end aZ = self:Lr(as) self:vG(as, at.f, aZ, aM, a_) self:vG(as, at.t, aZ, aM, b0) end at.f, at.t = self.bt, self.bt at.info = aM at.k = "VNONRELOC" end function h:Dr(as, at) self:dischargevars(as, at) self:freeexp(as, at) self:uy(as, 1) self:exp2reg(as, at, as.wvvww - 1) end function h:e2X(as, at) self:dischargevars(as, at) if at.k == "VNONRELOC" then if not self:hasjps(at) then return at.info end if at.info >= as.wv then self:exp2reg(as, at, at.info) return at.info end end self:Dr(as, at) return at.info end function h:exp2val(as, at) if self:hasjps(at) then self:e2X(as, at) else self:dischargevars(as, at) end end function h:exp2RK(as, at) self:exp2val(as, at) local aU = at.k if aU == "VKNUM" or aU == "VTRUE" or aU == "VFALSE" or aU == "VNIL" then if as.nk <= f.MAXINDEXRK then if at.k == "VNIL" then at.info = self:nilK(as) else at.info = at.k == "VKNUM" and self:vwvv(as, at.nval) or self:boolK(as, at.k == "VTRUE") end at.k = "VK" return f:RKASK(at.info) end elseif aU == "VK" then if at.info <= f.MAXINDEXRK then return f:RKASK(at.info) end else end return self:e2X(as, at) end function h:storevar(as, b2, b3) local aU = b2.k if aU == "VLOCAL" then self:freeexp(as, b3) self:exp2reg(as, b3, b2.info) return elseif aU == "VUa" then local at = self:e2X(as, b3) self:Ax(as, "OP_SETUa", at, b2.info, 0) elseif aU == "VGLOBAL" then local at = self:e2X(as, b3) self:vvwwv(as, "OP_SETGLOBAL", at, b2.info) elseif aU == "VINDEXED" then local at = self:exp2RK(as, b3) self:Ax(as, "OP_SETTABLE", b2.info, b2.aux, at) else j(0) end self:freeexp(as, b3) end function h:_self(as, at, b4) self:e2X(as, at) self:freeexp(as, at) local b5 = as.wvvww self:uy(as, 2) self:Ax(as, "OP_SELF", b5, at.info, self:exp2RK(as, b4)) self:freeexp(as, b4) at.info = b5 at.k = "VNONRELOC" end function h:invertjp(as, at) local aE = self:cc(as, at.info) j(f:to(f:go(aE)) ~= 0 and f:go(aE) ~= "OP_TESTSET" and f:go(aE) ~= "OP_TEST") f:Sa(aE, f:Xc(aE) == 0 and 1 or 0) end function h:jponbs(as, at, b6) if at.k == "VRELOCABLE" then local b7 = self:gC(as, at) if f:go(b7) == "OP_NOT" then as.pc = as.pc - 1 return self:bx(as, "OP_TEST", f:GETARG_B(b7), 0, b6 and 0 or 1) end end self:discharge2anyreg(as, at) self:freeexp(as, at) return self:bx(as, "OP_TESTSET", f.NO_REG, at.info, b6 and 1 or 0) end function h:goiftrue(as, at) local aE self:dischargevars(as, at) local aU = at.k if aU == "VK" or aU == "VKNUM" or aU == "VTRUE" then aE = self.bt elseif aU == "VFALSE" then aE = self:jp(as) elseif aU == "VJMP" then self:invertjp(as, at) aE = at.info else aE = self:jponbs(as, at, false) end at.f = self:wwww(as, at.f, aE) self:g4(as, at.t) at.t = self.bt end function h:goiffalse(as, at) local aE self:dischargevars(as, at) local aU = at.k if aU == "VNIL" or aU == "VFALSE" then aE = self.bt elseif aU == "VTRUE" then aE = self:jp(as) elseif aU == "VJMP" then aE = at.info else aE = self:jponbs(as, at, true) end at.t = self:wwww(as, at.t, aE) self:g4(as, at.f) at.f = self.bt end function h:Cnot(as, at) self:dischargevars(as, at) local aU = at.k if aU == "VNIL" or aU == "VFALSE" then at.k = "VTRUE" elseif aU == "VK" or aU == "VKNUM" or aU == "VTRUE" then at.k = "VFALSE" elseif aU == "VJMP" then self:invertjp(as, at) elseif aU == "VRELOCABLE" or aU == "VNONRELOC" then self:discharge2anyreg(as, at) self:freeexp(as, at) at.info = self:Ax(as, "OP_NOT", 0, at.info, 0) at.k = "VRELOCABLE" else j(0) end at.f, at.t = at.t, at.f self:RV(as, at.f) self:RV(as, at.t) end function h:indexed(as, ae, aU) ae.aux = self:exp2RK(as, aU) ae.k = "VINDEXED" end function h:constfolding(aa, b8, b9) local ac if not self:isnumeral(b8) or not self:isnumeral(b9) then return false end local ba = b8.nval local bb = b9.nval if aa == "OP_ADD" then ac = self:numadd(ba, bb) elseif aa == "OP_SUB" then ac = self:numsub(ba, bb) elseif aa == "OP_MUL" then ac = self:nummul(ba, bb) elseif aa == "OP_DIV" then if bb == 0 then return false end ac = self:numdiv(ba, bb) elseif aa == "OP_MOD" then if bb == 0 then return false end ac = self:nummod(ba, bb) elseif aa == "OP_POW" then ac = self:numpow(ba, bb) elseif aa == "OP_UNM" then ac = self:numunm(ba) elseif aa == "OP_LEN" then return false else j(0) ac = 0 end if self:numisnan(ac) then return false end b8.nval = ac return true end function h:Carith(as, aa, b8, b9) if self:constfolding(aa, b8, b9) then return else local bc = aa ~= "OP_UNM" and aa ~= "OP_LEN" and self:exp2RK(as, b9) or 0 local bd = self:exp2RK(as, b8) if bd > bc then self:freeexp(as, b8) self:freeexp(as, b9) else self:freeexp(as, b9) self:freeexp(as, b8) end b8.info = self:Ax(as, aa, 0, bd, bc) b8.k = "VRELOCABLE" end end function h:Ccomp(as, aa, b6, b8, b9) local bd = self:exp2RK(as, b8) local bc = self:exp2RK(as, b9) self:freeexp(as, b9) self:freeexp(as, b8) if b6 == 0 and aa ~= "OP_EQ" then bd, bc = bc, bd b6 = 1 end b8.info = self:bx(as, aa, b6, bd, bc) b8.k = "VJMP" end function h:prefix(as, aa, at) local b9 = {} b9.t, b9.f = self.bt, self.bt b9.k = "VKNUM" b9.nval = 0 if aa == "OPR_MINUS" then if not self:isnumeral(at) then self:e2X(as, at) end self:Carith(as, "OP_UNM", at, b9) elseif aa == "OPR_NOT" then self:Cnot(as, at) elseif aa == "OPR_LEN" then self:e2X(as, at) self:Carith(as, "OP_LEN", at, b9) else j(0) end end function h:infix(as, aa, y) if aa == "OPR_AND" then self:goiftrue(as, y) elseif aa == "OPR_OR" then self:goiffalse(as, y) elseif aa == "OPR_wwww" then self:Dr(as, y) elseif aa == "OPR_ADD" or aa == "OPR_SUB" or aa == "OPR_MUL" or aa == "OPR_DIV" or aa == "OPR_MOD" or aa == "OPR_POW" then if not self:isnumeral(y) then self:exp2RK(as, y) end else self:exp2RK(as, y) end end h.arith_op = { OPR_ADD = "OP_ADD", OPR_SUB = "OP_SUB", OPR_MUL = "OP_MUL", OPR_DIV = "OP_DIV", OPR_MOD = "OP_MOD", OPR_POW = "OP_POW" } h.comp_op = { OPR_EQ = "OP_EQ", OPR_NE = "OP_EQ", OPR_LT = "OP_LT", OPR_LE = "OP_LE", OPR_GT = "OP_LT", OPR_GE = "OP_LE" } h.comp_bs = {OPR_EQ = 1, OPR_NE = 0, OPR_LT = 1, OPR_LE = 1, OPR_GT = 0, OPR_GE = 0} function h:posfix(as, aa, b8, b9) local function be(b8, b9) b8.k = b9.k b8.info = b9.info b8.aux = b9.aux b8.nval = b9.nval b8.t = b9.t b8.f = b9.f end if aa == "OPR_AND" then j(b8.t == self.bt) self:dischargevars(as, b9) b9.f = self:wwww(as, b9.f, b8.f) be(b8, b9) elseif aa == "OPR_OR" then j(b8.f == self.bt) self:dischargevars(as, b9) b9.t = self:wwww(as, b9.t, b8.t) be(b8, b9) elseif aa == "OPR_wwww" then self:exp2val(as, b9) if b9.k == "VRELOCABLE" and f:go(self:gC(as, b9)) == "OP_wwww" then j(b8.info == f:GETARG_B(self:gC(as, b9)) - 1) self:freeexp(as, b8) f:ST(self:gC(as, b9), b8.info) b8.k = "VRELOCABLE" b8.info = b9.info else self:Dr(as, b9) self:Carith(as, "OP_wwww", b8, b9) end else local bf = self.arith_op[aa] if bf then self:Carith(as, bf, b8, b9) else local bg = self.comp_op[aa] if bg then self:Ccomp(as, bg, self.comp_bs[aa], b8, b9) else j(0) end end end end function h:vg(as, bh) as.f.lineinfo[as.pc - 1] = bh end function h:C(as, Z, bh) local ao = as.f self:h(as) d:growvector(as.L, ao.C, as.pc, ao.sizeC, nil, d.mi, "C size overflow") ao.C[as.pc] = Z d:growvector(as.L, ao.lineinfo, as.pc, ao.sizelineinfo, nil, d.mi, "C size overflow") ao.lineinfo[as.pc] = bh local aE = as.pc as.pc = as.pc + 1 return aE end function h:Ax(as, a0, a2, m, O) j(f:getOpMode(a0) == f.OpMode.iABC) j(f:getBMode(a0) ~= f.OpArgMask.OpArgN or m == 0) j(f:getCMode(a0) ~= f.OpArgMask.OpArgN or O == 0) return self:C(as, f:CREATE_ABC(a0, a2, m, O), as.ls.lastline) end function h:vvwwv(as, a0, a2, a3) j(f:getOpMode(a0) == f.OpMode.iABx or f:getOpMode(a0) == f.OpMode.iAsBx) j(f:getCMode(a0) == f.OpArgMask.OpArgN) return self:C(as, f:CREATE_ABx(a0, a2, a3), as.ls.lastline) end function h:setlist(as, bi, bj, bk) local O = math.floor((bj - 1) / f.LFFS_PER_FLUSH) + 1 local m = bk == d.lM and 0 or bk j(bk ~= 0) if O <= f.MAXARG_C then self:Ax(as, "OP_SETLIST", bi, m, O) else self:Ax(as, "OP_SETLIST", bi, m, 0) self:C(as, f:CREATE_Inst(O), as.ls.lastline) end as.wvvww = bi + 1 end d.lq = e.lq or "'%s'" d.SHRT_MAX = 32767 d.LUAI_MAXVARS = 200 d.LUAI_MAXUaUES = 60 d.mi = e.mi or 2147483645 d.LUAI_MAXCCALLS = 200 d.VARARG_HASARG = 1 d.HASARG_MASK = 2 d.VARARG_ISVARARG = 2 d.VARARG_NEEDSARG = 4 d.lM = -1 function d:Ev(x) return "'" .. x .. "'" end function d:growvector(M, y, bj, bl, ae, bm, at) if bj >= bm then error(at) end end function d:newproto(M) local ao = {} ao.k = {} ao.sizek = 0 ao.p = {} ao.sizep = 0 ao.C = {} ao.sizeC = 0 ao.sizelineinfo = 0 ao.sizeUaues = 0 ao.nups = 0 ao.Uaues = {} ao.numparams = 0 ao.is_vararg = 0 ao.Sz = 0 ao.lineinfo = {} ao.sizelocvars = 0 ao.locvars = {} ao.lineDefined = 0 ao.lastlinedefined = 0 ao.source = nil return ao end function d:int2fb(x) local at = 0 while x >= 16 do x = math.floor((x + 1) / 2) at = at + 1 end if x < 8 then return x else return (at + 1) * 8 + x - 8 end end function d:Vf(aU) return aU == "VCALL" or aU == "VVARARG" end function d:getlocvar(as, Z) return as.f.locvars[as.actvar[Z]] end function d:checklimit(as, y, F, ad) if y > F then self:errorlimit(as, F, ad) end end function d:anchor_vwvvvv(H) if H.t.vwvvvv == "TK_NAME" or H.t.vwvvvv == "TK_STRING" then end end function d:error_expected(H, I) e:sR(H, Hy(self.lq .. " expected", e:vwvvvv2str(H, I))) end function d:errorlimit(as, bm, bn) local J = as.f.linedefined == 0 and Hy("main function has more than %d %s", bm, bn) or Hy("function at line %d has more than %d %s", as.f.linedefined, bm, bn) e:lexerror(as.ls, J, 0) end function d:vwvww(H, O) if H.t.vwvvvv == O then e:next(H) return true else return false end end function d:check(H, O) if H.t.vwvvvv ~= O then self:error_expected(H, O) end end function d:Mn(H, O) self:check(H, O) e:next(H) end function d:check_bsition(H, O, J) if not O then e:sR(H, J) end end function d:Vc(H, bn, bo, bp) if not self:vwvww(H, bn) then if bp == H.vvvvv then self:error_expected(H, bn) else e:sR( H, Hy( self.lq .. " expected (to close " .. self.lq .. " at line %d)", e:vwvvvv2str(H, bn), e:vwvvvv2str(H, bo), bp ) ) end end end function d:vvvvvvv(H) self:check(H, "TK_NAME") local _ = H.t.seminfo e:next(H) return _ end function d:IX(at, aU, Z) at.f, at.t = h.bt, h.bt at.k = aU at.info = Z end function d:sSC(H, at, P) self:IX(at, "VK", h:stringK(H.fs, P)) end function d:checkn(H, at) self:sSC(H, at, self:vvvvvvv(H)) end function d:registerlocalvar(H, bq) local as = H.fs local ao = as.f self:growvector( H.L, ao.locvars, as.nlocvars, ao.sizelocvars, nil, self.SHRT_MAX, "too many local variables" ) ao.locvars[as.nlocvars] = {} ao.locvars[as.nlocvars].varn = bq local br = as.nlocvars as.nlocvars = as.nlocvars + 1 return br end function d:gd(H, y, t) self:vvwv(H, y, t) end function d:vvwv(H, n, t) local as = H.fs self:checklimit(as, as.wv + t + 1, self.LUAI_MAXVARS, "local variables") as.actvar[as.wv + t] = self:registerlocalvar(H, n) end function d:g5(H, bs) local as = H.fs as.wv = as.wv + bs for Z = bs, 1, -1 do self:getlocvar(as, as.wv - Z).vwwvv = as.pc end end function d:removevars(H, bt) local as = H.fs while as.wv > bt do as.wv = as.wv - 1 self:getlocvar(as, as.wv).endpc = as.pc end end function d:indexUaue(as, n, y) local ao = as.f for Z = 0, ao.nups - 1 do if as.Uaues[Z].k == y.k and as.Uaues[Z].info == y.info then j(ao.Uaues[Z] == n) return Z end end self:checklimit(as, ao.nups + 1, self.LUAI_MAXUaUES, "Uaues") self:growvector(as.L, ao.Uaues, ao.nups, ao.sizeUaues, nil, self.mi, "") ao.Uaues[ao.nups] = n j(y.k == "VLOCAL" or y.k == "VUa") as.Uaues[ao.nups] = {k = y.k, info = y.info} local bu = ao.nups ao.nups = ao.nups + 1 return bu end function d:searchvar(as, t) for Z = as.wv - 1, 0, -1 do if t == self:getlocvar(as, Z).varn then return Z end end return -1 end function d:markUa(as, bv) local bw = as.bl while bw and bw.wv > bv do bw = bw.previous end if bw then bw.Ua = true end end function d:vSaux(as, t, b2, bi) if as == nil then self:IX(b2, "VGLOBAL", f.NO_REG) return "VGLOBAL" else local y = self:searchvar(as, t) if y >= 0 then self:IX(b2, "VLOCAL", y) if bi == 0 then self:markUa(as, y) end return "VLOCAL" else if self:vSaux(as.prev, t, b2, 0) == "VGLOBAL" then return "VGLOBAL" end b2.info = self:indexUaue(as, t, b2) b2.k = "VUa" return "VUa" end end end function d:vS(H, b2) local bq = self:vvvvvvv(H) local as = H.fs if self:vSaux(as, bq, b2, 1) == "VGLOBAL" then b2.info = h:stringK(as, bq) end end function d:wvwwvv(H, bs, bx, at) local as = H.fs local by = bs - bx if self:Vf(at.k) then by = by + 1 if by <= 0 then by = 0 end h:setreturns(as, at, by) if by > 1 then h:uy(as, by - 1) end else if at.k ~= "VVOID" then h:Dr(as, at) end if by > 0 then local aM = as.wvvww h:uy(as, by) h:_nil(as, aM, by) end end end function d:enterlevel(H) H.L.nCcalls = H.L.nCcalls + 1 if H.L.nCcalls > self.LUAI_MAXCCALLS then e:lexerror(H, "Xz has too many syntax levels", 0) end end function d:leavelevel(H) H.L.nCcalls = H.L.nCcalls - 1 end function d:vy(as, bw, bz) bw.breaklist = h.bt bw.isbreakable = bz bw.wv = as.wv bw.Ua = false bw.previous = as.bl as.bl = bw j(as.wvvww == as.wv) end function d:bl(as) local bw = as.bl as.bl = bw.previous self:removevars(as.ls, bw.wv) if bw.Ua then h:Ax(as, "OP_CLOSE", bw.wv, 0, 0) end j(not bw.isbreakable or not bw.Ua) j(bw.wv == as.wv) as.wvvww = as.wv h:g4(as, bw.breaklist) end function d:pushclosure(H, b5, y) local as = H.fs local ao = as.f self:growvector(H.L, ao.p, as.np, ao.sizep, nil, f.MAXARG_Bx, "constant table overflow") ao.p[as.np] = b5.f as.np = as.np + 1 self:IX(y, "VRELOCABLE", h:vvwwv(as, "OP_CLOSURE", 0, as.np - 1)) for Z = 0, b5.f.nups - 1 do local a0 = b5.Uaues[Z].k == "VLOCAL" and "OP_MOVE" or "OP_GETUa" h:Ax(as, a0, 0, b5.Uaues[Z].info, 0) end end function d:open_func(H, as) local M = H.L local ao = self:newproto(H.L) as.f = ao as.prev = H.fs as.ls = H as.L = M H.fs = as as.pc = 0 as.lasttarget = -1 as.jpc = h.bt as.wvvww = 0 as.nk = 0 as.np = 0 as.nlocvars = 0 as.wv = 0 as.bl = nil ao.source = H.source ao.Sz = 2 as.h = {} end function d:close_func(H) local M = H.L local as = H.fs local ao = as.f self:removevars(H, 0) h:Vc(as, 0, 0) ao.sizeC = as.pc ao.sizelineinfo = as.pc ao.sizek = as.nk ao.sizep = as.np ao.sizelocvars = as.nlocvars ao.sizeUaues = ao.nups j(as.bl == nil) H.fs = as.prev if as then self:anchor_vwvvvv(H) end end function d:parser(M, s, l, n) local bA = {} bA.t = {} bA.LA = {} local bB = {} bB.Uaues = {} bB.actvar = {} M.nCcalls = 0 bA.buff = l e:setinput(M, bA, s, n) self:open_func(bA, bB) bB.f.is_vararg = self.VARARG_ISVARARG e:next(bA) self:Xz(bA) self:check(bA, "TK_EOS") self:close_func(bA) j(bB.prev == nil) j(bB.f.nups == 0) j(bA.fs == nil) return bB.f end function d:FF(H, y) local as = H.fs local b4 = {} h:e2X(as, y) e:next(H) self:checkn(H, b4) h:indexed(as, y, b4) end function d:yindex(H, y) e:next(H) self:expr(H, y) h:exp2val(H.fs, y) self:Mn(H, "]") end function d:recFF(H, bC) local as = H.fs local aM = H.fs.wvvww local b4, bD = {}, {} if H.t.vwvvvv == "TK_NAME" then self:checklimit(as, bC.nh, self.mi, "items in a constructor") self:checkn(H, b4) else self:yindex(H, b4) end bC.nh = bC.nh + 1 self:Mn(H, "=") local bE = h:exp2RK(as, b4) self:expr(H, bD) h:Ax(as, "OP_SETTABLE", bC.t.info, bE, h:exp2RK(as, bD)) as.wvvww = aM end function d:closelistFF(as, bC) if bC.v.k == "VVOID" then return end h:Dr(as, bC.v) bC.v.k = "VVOID" if bC.tostore == f.LFFS_PER_FLUSH then h:setlist(as, bC.t.info, bC.na, bC.tostore) bC.tostore = 0 end end function d:lastlistFF(as, bC) if bC.tostore == 0 then return end if self:Vf(bC.v.k) then h:mS(as, bC.v) h:setlist(as, bC.t.info, bC.na, self.lM) bC.na = bC.na - 1 else if bC.v.k ~= "VVOID" then h:Dr(as, bC.v) end h:setlist(as, bC.t.info, bC.na, bC.tostore) end end function d:listFF(H, bC) self:expr(H, bC.v) self:checklimit(H.fs, bC.na, self.mi, "items in a constructor") bC.na = bC.na + 1 bC.tostore = bC.tostore + 1 end function d:constructor(H, ae) local as = H.fs local bh = H.vvvvv local aE = h:Ax(as, "OP_NEWTABLE", 0, 0, 0) local bC = {} bC.v = {} bC.na, bC.nh, bC.tostore = 0, 0, 0 bC.t = ae self:IX(ae, "VRELOCABLE", aE) self:IX(bC.v, "VVOID", 0) h:Dr(H.fs, ae) self:Mn(H, "{") repeat j(bC.v.k == "VVOID" or bC.tostore > 0) if H.t.vwvvvv == "}" then break end self:closelistFF(as, bC) local O = H.t.vwvvvv if O == "TK_NAME" then e:LA(H) if H.LA.vwvvvv ~= "=" then self:listFF(H, bC) else self:recFF(H, bC) end elseif O == "[" then self:recFF(H, bC) else self:listFF(H, bC) end until not self:vwvww(H, ",") and not self:vwvww(H, ";") self:Vc(H, "}", "{", bh) self:lastlistFF(as, bC) f:ST(as.f.C[aE], self:int2fb(bC.na)) f:Sc(as.f.C[aE], self:int2fb(bC.nh)) end function d:parlist(H) local as = H.fs local ao = as.f local bF = 0 ao.is_vararg = 0 if H.t.vwvvvv ~= ")" then repeat local O = H.t.vwvvvv if O == "TK_NAME" then self:vvwv(H, self:vvvvvvv(H), bF) bF = bF + 1 elseif O == "TK_DOTS" then e:next(H) self:gd(H, "arg", bF) bF = bF + 1 ao.is_vararg = self.VARARG_HASARG + self.VARARG_NEEDSARG ao.is_vararg = ao.is_vararg + self.VARARG_ISVARARG else e:sR(H, "<n> or " .. self:Ev("...") .. " expected") end until ao.is_vararg ~= 0 or not self:vwvww(H, ",") end self:g5(H, bF) ao.numparams = as.wv - ao.is_vararg % self.HASARG_MASK h:uy(as, as.wv) end function d:body(H, at, bG, bh) local bH = {} bH.Uaues = {} bH.actvar = {} self:open_func(H, bH) bH.f.lineDefined = bh self:Mn(H, "(") if bG then self:gd(H, "self", 0) self:g5(H, 1) end self:parlist(H) self:Mn(H, ")") self:Xz(H) bH.f.lastlinedefined = H.vvvvv self:Vc(H, "TK_END", "TK_FUNCTION", bh) self:close_func(H) self:pushclosure(H, bH, at) end function d:vwvvv(H, y) local t = 1 self:expr(H, y) while self:vwvww(H, ",") do h:Dr(H.fs, y) self:expr(H, y) t = t + 1 end return t end function d:funcargs(H, ao) local as = H.fs local bI = {} local bF local bh = H.vvvvv local O = H.t.vwvvvv if O == "(" then if bh ~= H.lastline then e:sR(H, "ambiguous syntax (function call x new statement)") end e:next(H) if H.t.vwvvvv == ")" then bI.k = "VVOID" else self:vwvvv(H, bI) h:mS(as, bI) end self:Vc(H, ")", "(", bh) elseif O == "{" then self:constructor(H, bI) elseif O == "TK_STRING" then self:sSC(H, bI, H.t.seminfo) e:next(H) else e:sR(H, "function arguments expected") return end j(ao.k == "VNONRELOC") local bi = ao.info if self:Vf(bI.k) then bF = self.lM else if bI.k ~= "VVOID" then h:Dr(as, bI) end bF = as.wvvww - (bi + 1) end self:IX(ao, "VCALL", h:Ax(as, "OP_CALL", bi, bF + 1, 2)) h:vg(as, bh) as.wvvww = bi + 1 end function d:prefixexp(H, y) local O = H.t.vwvvvv if O == "(" then local bh = H.vvvvv e:next(H) self:expr(H, y) self:Vc(H, ")", "(", bh) h:dischargevars(H.fs, y) elseif O == "TK_NAME" then self:vS(H, y) else e:sR(H, "unexpected symbol") end return end function d:pE(H, y) local as = H.fs self:prefixexp(H, y) while true do local O = H.t.vwvvvv if O == "." then self:FF(H, y) elseif O == "[" then local b4 = {} h:e2X(as, y) self:yindex(H, b4) h:indexed(as, y, b4) elseif O == ":" then local b4 = {} e:next(H) self:checkn(H, b4) h:_self(as, y, b4) self:funcargs(H, y) elseif O == "(" or O == "TK_STRING" or O == "{" then h:Dr(as, y) self:funcargs(H, y) else return end end end function d:simpleexp(H, y) local O = H.t.vwvvvv if O == "TK_NUMBER" then self:IX(y, "VKNUM", 0) y.nval = H.t.seminfo elseif O == "TK_STRING" then self:sSC(H, y, H.t.seminfo) elseif O == "TK_NIL" then self:IX(y, "VNIL", 0) elseif O == "TK_TRUE" then self:IX(y, "VTRUE", 0) elseif O == "TK_FALSE" then self:IX(y, "VFALSE", 0) elseif O == "TK_DOTS" then local as = H.fs self:check_bsition( H, as.f.is_vararg ~= 0, "cannot use " .. self:Ev("...") .. " outside a vararg function" ) local bJ = as.f.is_vararg if bJ >= self.VARARG_NEEDSARG then as.f.is_vararg = bJ - self.VARARG_NEEDSARG end self:IX(y, "VVARARG", h:Ax(as, "OP_VARARG", 0, 1, 0)) elseif O == "{" then self:constructor(H, y) return elseif O == "TK_FUNCTION" then e:next(H) self:body(H, y, false, H.vvvvv) return else self:pE(H, y) return end e:next(H) end function d:getunopr(aa) if aa == "TK_NOT" then return "OPR_NOT" elseif aa == "-" then return "OPR_MINUS" elseif aa == "#" then return "OPR_LEN" else return "OPR_NOUNOPR" end end d.getbinopr_table = { ["+"] = "OPR_ADD", ["-"] = "OPR_SUB", ["*"] = "OPR_MUL", ["/"] = "OPR_DIV", ["%"] = "OPR_MOD", ["^"] = "OPR_POW", ["TK_wwww"] = "OPR_wwww", ["TK_NE"] = "OPR_NE", ["TK_EQ"] = "OPR_EQ", ["<"] = "OPR_LT", ["TK_LE"] = "OPR_LE", [">"] = "OPR_GT", ["TK_GE"] = "OPR_GE", ["TK_AND"] = "OPR_AND", ["TK_OR"] = "OPR_OR" } function d:getbinopr(aa) local bK = self.getbinopr_table[aa] if bK then return bK else return "OPR_NOBINOPR" end end d.priority = { {6, 6}, {6, 6}, {7, 7}, {7, 7}, {7, 7}, {10, 9}, {5, 4}, {3, 3}, {3, 3}, {3, 3}, {3, 3}, {3, 3}, {3, 3}, {2, 2}, {1, 1} } d.UNARY_PRIORITY = 8 function d:subexpr(H, y, bm) self:enterlevel(H) local bL = self:getunopr(H.t.vwvvvv) if bL ~= "OPR_NOUNOPR" then e:next(H) self:subexpr(H, y, self.UNARY_PRIORITY) h:prefix(H.fs, bL, y) else self:simpleexp(H, y) end local aa = self:getbinopr(H.t.vwvvvv) while aa ~= "OPR_NOBINOPR" and self.priority[h.BinOpr[aa] + 1][1] > bm do local bb = {} e:next(H) h:infix(H.fs, aa, y) local bM = self:subexpr(H, bb, self.priority[h.BinOpr[aa] + 1][2]) h:posfix(H.fs, aa, y, bb) aa = bM end self:leavelevel(H) return aa end function d:expr(H, y) self:subexpr(H, y, 0) end function d:Fg(I) if I == "TK_ELSE" or I == "TK_ELSEIF" or I == "TK_END" or I == "TK_UNTIL" or I == "TK_EOS" then return true else return false end end function d:bg(H) local as = H.fs local bw = {} self:vy(as, bw, false) self:Xz(H) j(bw.breaklist == h.bt) self:bl(as) end function d:check_conflict(H, bN, y) local as = H.fs local by = as.wvvww local bO = false while bN do if bN.v.k == "VINDEXED" then if bN.v.info == y.info then bO = true bN.v.info = by end if bN.v.aux == y.info then bO = true bN.v.aux = by end end bN = bN.prev end if bO then h:Ax(as, "OP_MOVE", as.wvvww, y.info, 0) h:uy(as, 1) end end function d:A(H, bN, bs) local at = {} local O = bN.v.k self:check_bsition(H, O == "VLOCAL" or O == "VUa" or O == "VGLOBAL" or O == "VINDEXED", "syntax error") if self:vwvww(H, ",") then local bP = {} bP.v = {} bP.prev = bN self:pE(H, bP.v) if bP.v.k == "VLOCAL" then self:check_conflict(H, bN, bP.v) end self:checklimit(H.fs, bs, self.LUAI_MAXCCALLS - H.L.nCcalls, "variables in A") self:A(H, bP, bs + 1) else self:Mn(H, "=") local bx = self:vwvvv(H, at) if bx ~= bs then self:wvwwvv(H, bs, bx, at) if bx > bs then H.fs.wvvww = H.fs.wvvww - (bx - bs) end else h:setoneret(H.fs, at) h:storevar(H.fs, bN.v, at) return end end self:IX(at, "VNONRELOC", H.fs.wvvww - 1) h:storevar(H.fs, bN.v, at) end function d:bs(H) local y = {} self:expr(H, y) if y.k == "VNIL" then y.k = "VFALSE" end h:goiftrue(H.fs, y) return y.f end function d:Bn(H) local as = H.fs local bw = as.bl local bQ = false while bw and not bw.isbreakable do if bw.Ua then bQ = true end bw = bw.previous end if not bw then e:sR(H, "no loop to break") end if bQ then h:Ax(as, "OP_CLOSE", bw.wv, 0, 0) end bw.breaklist = h:wwww(as, bw.breaklist, h:jp(as)) end function d:whilestat(H, bh) local as = H.fs local bw = {} e:next(H) local bR = h:Lr(as) local bS = self:bs(H) self:vy(as, bw, true) self:Mn(H, "TK_DO") self:bg(H) h:gv(as, h:jp(as), bR) self:Vc(H, "TK_END", "TK_WHILE", bh) self:bl(as) h:g4(as, bS) end function d:cV(H, bh) local as = H.fs local bT = h:Lr(as) local bU, bV = {}, {} self:vy(as, bU, true) self:vy(as, bV, false) e:next(H) self:Xz(H) self:Vc(H, "TK_UNTIL", "TK_REPEAT", bh) local bS = self:bs(H) if not bV.Ua then self:bl(as) h:gv(H.fs, bS, bT) else self:Bn(H) h:g4(H.fs, bS) self:bl(as) h:gv(H.fs, h:jp(as), bT) end self:bl(as) end function d:Nj(H) local at = {} self:expr(H, at) local aU = at.k h:Dr(H.fs, at) return aU end function d:lA(H, bi, bh, bs, bW) local bw = {} local as = H.fs self:g5(H, 3) self:Mn(H, "TK_DO") local bX = bW and h:Cg(as, "OP_FORPREP", bi, h.bt) or h:jp(as) self:vy(as, bw, false) self:g5(H, bs) h:uy(as, bs) self:bg(H) self:bl(as) h:g4(as, bX) local bY = bW and h:Cg(as, "OP_FORLOOP", bi, h.bt) or h:Ax(as, "OP_TFORLOOP", bi, 0, bs) h:vg(as, bh) h:gv(as, bW and bY or h:jp(as), bX + 1) end function d:wvv(H, bq, bh) local as = H.fs local bi = as.wvvww self:gd(H, "(for index)", 0) self:gd(H, "(for limit)", 1) self:gd(H, "(for step)", 2) self:vvwv(H, bq, 3) self:Mn(H, "=") self:Nj(H) self:Mn(H, ",") self:Nj(H) if self:vwvww(H, ",") then self:Nj(H) else h:vvwwv(as, "OP_LOADK", as.wvvww, h:vwvv(as, 1)) h:uy(as, 1) end self:lA(H, bi, bh, 1, true) end function d:vwwvvvv(H, bZ) local as = H.fs local at = {} local bs = 0 local bi = as.wvvww self:gd(H, "(&@$!!", bs) bs = bs + 1 self:gd(H, "~**@%##@#@", bs) bs = bs + 1 self:gd(H, "~!~%!~&$%", bs) bs = bs + 1 self:vvwv(H, bZ, bs) bs = bs + 1 while self:vwvww(H, ",") do self:vvwv(H, self:vvvvvvv(H), bs) bs = bs + 1 end self:Mn(H, "TK_IN") local bh = H.vvvvv self:wvwwvv(H, 3, self:vwvvv(H, at), at) h:vwwwvww(as, 3) self:lA(H, bi, bh, bs - 3, false) end function d:forstat(H, bh) local as = H.fs local bw = {} self:vy(as, bw, true) e:next(H) local bq = self:vvvvvvv(H) local O = H.t.vwvvvv if O == "=" then self:wvv(H, bq, bh) elseif O == "," or O == "TK_IN" then self:vwwvvvv(H, bq) else e:sR(H, self:Ev("=") .. " or " .. self:Ev("in") .. " expected") end self:Vc(H, "TK_END", "TK_FOR", bh) self:bl(as) end function d:vww(H) e:next(H) local bS = self:bs(H) self:Mn(H, "TK_THEN") self:bg(H) return bS end function d:vvvvvvw(H, bh) local as = H.fs local b_ = h.bt local c0 = self:vww(H) while H.t.vwvvvv == "TK_ELSEIF" do b_ = h:wwww(as, b_, h:jp(as)) h:g4(as, c0) c0 = self:vww(H) end if H.t.vwvvvv == "TK_ELSE" then b_ = h:wwww(as, b_, h:jp(as)) h:g4(as, c0) e:next(H) self:bg(H) else b_ = h:wwww(as, b_, c0) end h:g4(as, b_) self:Vc(H, "TK_END", "TK_IF", bh) end function d:St(H) local y, m = {}, {} local as = H.fs self:vvwv(H, self:vvvvvvv(H), 0) self:IX(y, "VLOCAL", as.wvvww) h:uy(as, 1) self:g5(H, 1) self:body(H, m, false, H.vvvvv) h:storevar(as, y, m) self:getlocvar(as, as.wv - 1).vwwvv = as.pc end function d:LS(H) local bs = 0 local bx local at = {} repeat self:vvwv(H, self:vvvvvvv(H), bs) bs = bs + 1 until not self:vwvww(H, ",") if self:vwvww(H, "=") then bx = self:vwvvv(H, at) else at.k = "VVOID" bx = 0 end self:wvwwvv(H, bs, bx, at) self:g5(H, bs) end function d:Gh(H, y) local bG = false self:vS(H, y) while H.t.vwvvvv == "." do self:FF(H, y) end if H.t.vwvvvv == ":" then bG = true self:FF(H, y) end return bG end function d:sF(H, bh) local y, m = {}, {} e:next(H) local bG = self:Gh(H, y) self:body(H, m, bG, bh) h:storevar(H.fs, y, m) h:vg(H.fs, bh) end function d:Xs(H) local as = H.fs local y = {} y.v = {} self:pE(H, y.v) if y.v.k == "VCALL" then f:Sc(h:gC(as, y.v), 1) else y.prev = nil self:A(H, y, 1) end end function d:rT(H) local as = H.fs local at = {} local E, aB e:next(H) if self:Fg(H.t.vwvvvv) or H.t.vwvvvv == ";" then E, aB = 0, 0 else aB = self:vwvvv(H, at) if self:Vf(at.k) then h:mS(as, at) if at.k == "VCALL" and aB == 1 then f:Bd(h:gC(as, at), "OP_TAILCALL") j(f:Xc(h:gC(as, at)) == as.wv) end E = as.wv aB = self.lM else if aB == 1 then E = h:e2X(as, at) else h:Dr(as, at) E = as.wv j(aB == as.wvvww - E) end end end h:Vc(as, E, aB) end function d:statement(H) local bh = H.vvvvv local O = H.t.vwvvvv if O == "TK_IF" then self:vvvvvvw(H, bh) return false elseif O == "TK_WHILE" then self:whilestat(H, bh) return false elseif O == "TK_DO" then e:next(H) self:bg(H) self:Vc(H, "TK_END", "TK_DO", bh) return false elseif O == "TK_FOR" then self:forstat(H, bh) return false elseif O == "TK_REPEAT" then self:cV(H, bh) return false elseif O == "TK_FUNCTION" then self:sF(H, bh) return false elseif O == "TK_LOCAL" then e:next(H) if self:vwvww(H, "TK_FUNCTION") then self:St(H) else self:LS(H) end return false elseif O == "TK_RETURN" then self:rT(H) return true elseif O == "TK_BREAK" then e:next(H) self:Bn(H) return true else self:Xs(H) return false end end function d:Xz(H) local c1 = false self:enterlevel(H) while not c1 and not self:Fg(H.t.vwvvvv) do c1 = self:statement(H) self:vwvww(H, ";") j(H.fs.f.Sz >= H.fs.wvvww and H.fs.wvvww >= H.fs.wv) H.fs.wvvww = H.fs.wv end self:leavelevel(H) end e:Il() local c2 = {} return function(o, n) n = n or "compiled-lua" local c3 = c:Il(c:z(o), nil) if not c3 then return end local b5 = d:parser(c2, c3, nil, "@" .. n) local af, l = g:make_setS() g:dump(c2, b5, af, l) return l.d end end)() local c4 = (function(...) local bit = bit or bit32 or require("bit") if not table.create then function table.create(c) return {} end end if not table.unpack then table.unpack = unpack end if not table.pack then function table.pack(...) return {n = select("#", ...), ...} end end if not table.move then function table.move(d, e, f, g, h) for i = 0, f - e do h[g + i] = d[e + i] end end end local j local k local l local m = 50 local n = { [22] = 18, [31] = 8, [33] = 28, [0] = 3, [1] = 13, [2] = 23, [26] = 33, [12] = 1, [13] = 6, [14] = 10, [15] = 16, [16] = 20, [17] = 26, [18] = 30, [19] = 36, [3] = 0, [4] = 2, [5] = 4, [6] = 7, [7] = 9, [8] = 12, [9] = 14, [10] = 17, [20] = 19, [21] = 22, [23] = 24, [24] = 27, [25] = 29, [27] = 32, [32] = 34, [34] = 37, [11] = 5, [28] = 11, [29] = 15, [30] = 21, [35] = 25, [36] = 31, [37] = 35 } local o = { [0] = "ABC", "ABx", "ABC", "ABC", "ABC", "ABx", "ABC", "ABx", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "AsBx", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "AsBx", "AsBx", "ABC", "ABC", "ABC", "ABx", "ABC" } local p = { [0] = {b = "OpArgR", c = "OpArgN"}, {b = "OpArgK", c = "OpArgN"}, {b = "OpArgU", c = "OpArgU"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgU", c = "OpArgN"}, {b = "OpArgK", c = "OpArgN"}, {b = "OpArgR", c = "OpArgK"}, {b = "OpArgK", c = "OpArgN"}, {b = "OpArgU", c = "OpArgN"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgU", c = "OpArgU"}, {b = "OpArgR", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgR", c = "OpArgR"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgK", c = "OpArgK"}, {b = "OpArgR", c = "OpArgU"}, {b = "OpArgR", c = "OpArgU"}, {b = "OpArgU", c = "OpArgU"}, {b = "OpArgU", c = "OpArgU"}, {b = "OpArgU", c = "OpArgN"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgR", c = "OpArgN"}, {b = "OpArgN", c = "OpArgU"}, {b = "OpArgU", c = "OpArgU"}, {b = "OpArgN", c = "OpArgN"}, {b = "OpArgU", c = "OpArgN"}, {b = "OpArgU", c = "OpArgN"} } local function q(d, r, s, t) local u = 0 for i = r, s, t do local v = 256 ^ math.abs(i - r) u = u + v * Sf(d, i, i) end return u end local function w(y, z, x, A) local B = (-1) ^ bit.rshift(A, 7) local C = bit.rshift(x, 7) + bit.lshift(bit.band(A, 0x7F), 1) local D = y + bit.lshift(z, 8) + bit.lshift(bit.band(x, 0x7F), 16) local E = 1 if C == 0 then if D == 0 then return B * 0 else E = 0 C = 1 end elseif C == 0x7F then if D == 0 then return B * 1 / 0 else return B * 0 / 0 end end return B * 2 ^ (C - 127) * (1 + E / 2 ^ 23) end local function F(y, z, x, A, G, H, I, J) local B = (-1) ^ bit.rshift(J, 7) local C = bit.lshift(bit.band(J, 0x7F), 4) + bit.rshift(I, 4) local D = bit.band(I, 0x0F) * 2 ^ 48 local E = 1 D = D + H * 2 ^ 40 + G * 2 ^ 32 + A * 2 ^ 24 + x * 2 ^ 16 + z * 2 ^ 8 + y if C == 0 then if D == 0 then return B * 0 else E = 0 C = 1 end elseif C == 0x7FF then if D == 0 then return B * 1 / 0 else return B * 0 / 0 end end return B * 2 ^ (C - 1023) * (E + D / 2 ^ 52) end local function K(d, r, s) return q(d, r, s - 1, 1) end local function L(d, r, s) return q(d, s - 1, r, -1) end local function M(d, r) return w(Sf(d, r, r + 3)) end local function N(d, r) local y, z, x, A = Sf(d, r, r + 3) return w(A, x, z, y) end local function O(d, r) return F(Sf(d, r, r + 7)) end local function P(d, r) local y, z, x, A, G, H, I, J = Sf(d, r, r + 7) return F(J, I, H, G, A, x, z, y) end local Q = {[4] = {little = M, big = N}, [8] = {little = O, big = P}} local function R(S) local T = S.index local U = Sf(S.source, T, T) S.index = T + 1 return U end local function V(S, W) local X = S.index + W local Y = Ju(S.source, S.index, X - 1) S.index = X return Y end local function Z(S) local W = S:s_szt() local Y if W ~= 0 then Y = Ju(V(S, W), 1, -2) end return Y end local function _(W, a0) return function(S) local X = S.index + W local a1 = a0(S.source, S.index, X) S.index = X return a1 end end local function a2(W, a0) return function(S) local a3 = a0(S.source, S.index) S.index = S.index + W return a3 end end local function a4(S) local W = S:s_int() local a5 = table.create(W) for i = 1, W do local a6 = S:s_ins() local a7 = bit.band(a6, 0x3F) local a8 = o[a7] local a9 = p[a7] local aa = {value = a6, op = n[a7], A = bit.band(bit.rshift(a6, 6), 0xFF)} if a8 == "ABC" then aa.B = bit.band(bit.rshift(a6, 23), 0x1FF) aa.C = bit.band(bit.rshift(a6, 14), 0x1FF) aa.is_KB = a9.b == "OpArgK" and aa.B > 0xFF aa.is_KC = a9.c == "OpArgK" and aa.C > 0xFF elseif a8 == "ABx" then aa.Bx = bit.band(bit.rshift(a6, 14), 0x3FFFF) aa.is_K = a9.b == "OpArgK" elseif a8 == "AsBx" then aa.sBx = bit.band(bit.rshift(a6, 14), 0x3FFFF) - 131071 end a5[i] = aa end return a5 end local function ab(S) local W = S:s_int() local a5 = table.create(W) for i = 1, W do local ac = R(S) local ad if ac == 1 then ad = R(S) ~= 0 elseif ac == 3 then ad = S:s_num() elseif ac == 4 then ad = Z(S) end a5[i] = ad end return a5 end local function ae(S, d) local W = S:s_int() local a5 = table.create(W) for i = 1, W do a5[i] = l(S, d) end return a5 end local function af(S) local W = S:s_int() local a5 = table.create(W) for i = 1, W do a5[i] = S:s_int() end return a5 end local function ag(S) local W = S:s_int() local a5 = table.create(W) for i = 1, W do a5[i] = {varn = Z(S), vwwvv = S:s_int(), endpc = S:s_int()} end return a5 end local function ah(S) local W = S:s_int() local a5 = table.create(W) for i = 1, W do a5[i] = Z(S) end return a5 end function l(S, ai) local aj = {} local d = Z(S) or ai aj.source = d S:s_int() S:s_int() aj.num_Ua = R(S) aj.num_param = R(S) R(S) aj.max_stack = R(S) aj.C = a4(S) aj.const = ab(S) aj.subs = ae(S, d) aj.lines = af(S) ag(S) ah(S) for c, ak in ipairs(aj.C) do if ak.is_K then ak.const = aj.const[ak.Bx + 1] else if ak.is_KB then ak.const_B = aj.const[ak.B - 0xFF] end if ak.is_KC then ak.const_C = aj.const[ak.C - 0xFF] end end end return aj end function j(d) local al local am local an local ao local ap local aq local ar local as = {index = 1, source = d} assert(V(as, 4) == "\27Lua", "invalid Lua signature") assert(R(as) == 0x51, "invalid Lua version") assert(R(as) == 0, "invalid Lua format") am = R(as) ~= 0 an = R(as) ao = R(as) ap = R(as) aq = R(as) ar = R(as) ~= 0 al = am and K or L as.s_int = _(an, al) as.s_szt = _(ao, al) as.s_ins = _(ap, al) if ar then as.s_num = _(aq, al) elseif Q[aq] then as.s_num = a2(aq, Q[aq][am and "little" or "big"]) else error("unsupported float size") end return l(as, "@virtual") end local function at(a5, au) for i, av in pairs(a5) do if av.index >= au then av.value = av.store[av.index] av.store = av av.index = "value" a5[i] = nil end end end local function aw(a5, au, ax) local ay = a5[au] if not ay then ay = {index = au, store = ax} a5[au] = ay end return ay end local function az(aA, aB) local d = aA.source local aC = aA.lines[aA.pc - 1] error(Hy("%s:%i: %s", d, aC, aB), 0) end local function aD(aE, aF, aG) local aH = aE.C local aI = aE.subs local aJ = aE.vararg local aK = -1 local aL = {} local ax = aE.memory local aM = aE.pc while true do local aN = aH[aM] local a7 = aN.op aM = aM + 1 if a7 < 18 then if a7 < 8 then if a7 < 3 then if a7 < 1 then for i = aN.A, aN.B do ax[i] = nil end elseif a7 > 1 then local av = aG[aN.B] ax[aN.A] = av.store[av.index] else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO + aP end elseif a7 > 3 then if a7 < 6 then if a7 > 4 then local aQ = aN.A local aR = aN.B local au if aN.is_KC then au = aN.const_C else au = ax[aN.C] end ax[aQ + 1] = ax[aR] ax[aQ] = ax[aR][au] else ax[aN.A] = aF[aN.const] end elseif a7 > 6 then local au if aN.is_KC then au = aN.const_C else au = ax[aN.C] end ax[aN.A] = ax[aN.B][au] else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO - aP end else ax[aN.A] = ax[aN.B] end elseif a7 > 8 then if a7 < 13 then if a7 < 10 then aF[aN.const] = ax[aN.A] elseif a7 > 10 then if a7 < 12 then local aQ = aN.A local aR = aN.B local aS = aN.C local aT if aR == 0 then aT = aK - aQ else aT = aR - 1 end local aU = table.pack(ax[aQ](table.unpack(ax, aQ + 1, aQ + aT))) local aV = aU.n if aS == 0 then aK = aQ + aV - 1 else aV = aS - 1 end table.move(aU, 1, aV, aQ, ax) else local av = aG[aN.B] av.store[av.index] = ax[aN.A] end else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO * aP end elseif a7 > 13 then if a7 < 16 then if a7 > 14 then local aQ = aN.A local aR = aN.B local aT if aR == 0 then aT = aK - aQ else aT = aR - 1 end at(aL, 0) return ax[aQ](table.unpack(ax, aQ + 1, aQ + aT)) else local au, aW if aN.is_KB then au = aN.const_B else au = ax[aN.B] end if aN.is_KC then aW = aN.const_C else aW = ax[aN.C] end ax[aN.A][au] = aW end elseif a7 > 16 then ax[aN.A] = {} else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO / aP end else ax[aN.A] = aN.const end else local aQ = aN.A local aX = ax[aQ + 2] local au = ax[aQ] + aX local aY = ax[aQ + 1] local aZ if aX == math.abs(aX) then aZ = au <= aY else aZ = au >= aY end if aZ then ax[aN.A] = au ax[aN.A + 3] = au aM = aM + aN.sBx end end elseif a7 > 18 then if a7 < 28 then if a7 < 23 then if a7 < 20 then ax[aN.A] = #ax[aN.B] elseif a7 > 20 then if a7 < 22 then local aQ = aN.A local aR = aN.B local W if aR == 0 then W = aK - aQ + 1 else W = aR - 1 end at(aL, 0) return table.unpack(ax, aQ, aQ + W - 1) else local Y = ax[aN.B] for i = aN.B + 1, aN.C do Y = Y .. ax[i] end ax[aN.A] = Y end else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO % aP end elseif a7 > 23 then if a7 < 26 then if a7 > 24 then at(aL, aN.A) else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end if aO == aP == (aN.A ~= 0) then aM = aM + aH[aM].sBx end aM = aM + 1 end elseif a7 > 26 then local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end if aO < aP == (aN.A ~= 0) then aM = aM + aH[aM].sBx end aM = aM + 1 else local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end ax[aN.A] = aO ^ aP end else ax[aN.A] = aN.B ~= 0 if aN.C ~= 0 then aM = aM + 1 end end elseif a7 > 28 then if a7 < 33 then if a7 < 30 then local aO, aP if aN.is_KB then aO = aN.const_B else aO = ax[aN.B] end if aN.is_KC then aP = aN.const_C else aP = ax[aN.C] end if aO <= aP == (aN.A ~= 0) then aM = aM + aH[aM].sBx end aM = aM + 1 elseif a7 > 30 then if a7 < 32 then local a_ = aI[aN.Bx + 1] local b0 = a_.num_Ua local b1 if b0 ~= 0 then b1 = {} for i = 1, b0 do local b2 = aH[aM + i - 1] if b2.op == n[0] then b1[i - 1] = aw(aL, b2.B, ax) elseif b2.op == n[4] then b1[i - 1] = aG[b2.B] end end aM = aM + b0 end ax[aN.A] = k(a_, aF, b1) else local aQ = aN.A local aR = aN.B if not ax[aR] ~= (aN.C ~= 0) then ax[aQ] = ax[aR] aM = aM + aH[aM].sBx end aM = aM + 1 end else ax[aN.A] = -ax[aN.B] end elseif a7 > 33 then if a7 < 36 then if a7 > 34 then local aQ = aN.A local W = aN.B if W == 0 then W = aJ.len aK = aQ + W - 1 end table.move(aJ.list, 1, W, aQ, ax) else local aQ = aN.A local b3, aY, aX b3 = assert(It(ax[aQ]), LUAQERROR) aY = assert(It(ax[aQ + 1]), LUAQERROR) aX = assert(It(ax[aQ + 2]), LUAQERROR) ax[aQ] = b3 - aX ax[aQ + 1] = aY ax[aQ + 2] = aX aM = aM + aN.sBx end elseif a7 > 36 then local aQ = aN.A local aS = aN.C local W = aN.B local b4 = ax[aQ] local g if W == 0 then W = aK - aQ end if aS == 0 then aS = aN[aM].value aM = aM + 1 end g = (aS - 1) * m table.move(ax, aQ + 1, aQ + W, g + 1, b4) else ax[aN.A] = not ax[aN.B] end else if not ax[aN.A] ~= (aN.C ~= 0) then aM = aM + aH[aM].sBx end aM = aM + 1 end else local aQ = aN.A local b5 = aQ + 3 local b6 = {ax[aQ](ax[aQ + 1], ax[aQ + 2])} table.move(b6, 1, aN.C, b5, ax) if ax[b5] ~= nil then ax[aQ + 2] = ax[b5] aM = aM + aH[aM].sBx end aM = aM + 1 end else aM = aM + aN.sBx end aE.pc = aM end end function k(aj, aF, b7) local function b8(...) local b9 = table.pack(...) local ax = table.create(aj.max_stack) local aJ = {len = 0, list = {}} table.move(b9, 1, aj.num_param, 0, ax) if aj.num_param < b9.n then local ba = aj.num_param + 1 local W = b9.n - aj.num_param aJ.len = W table.move(b9, ba, ba + W - 1, 1, aJ.list) end local aE = {vararg = aJ, memory = ax, C = aj.C, subs = aj.subs, pc = 1} local bb = table.pack(pcall(aD, aE, aF, b7)) if bb[1] then return table.unpack(bb, 2, bb.n) else local aA = {pc = aE.pc, source = aj.source, lines = aj.lines} az(aA, bb[2]) return end end return b8 end return function(bc, aF) return k(j(bc), aF or getfenv(0)) end end)() getfenv().script = nil return function(c5, c6) local c7 local c6 = c6 or getfenv(2) local n = c6.script and c6.script:GetFullName() local c8, c9 = pcall( function() local ca = b(c5, n) c7 = c4(ca, c6) end ) if c8 then return setfenv(c7, c6) end return nil, c9 end end)()
--// SERVICES \\--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local UIS = UserInputService
local Premium;
local Usertag; 
local banned;
local http_request = request or http_request or (http and http.request) or syn.request
local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {'Krnl-Fingerprint','Krnl-Fingerprint','fingerprint', 'syn-user-identifier', 'sentinel-fingerprint', 'proto-user-identifier', 'shadow_hardware', 'krnl-hwid', 'exploit-guid','SW-Fingerprint'};
hwid = "";
for i, v in next, hwid_list do
	if decoded.headers[v] then
		hwid = tostring(decoded.headers[v])
		break
	end
end
--// Premium \\--

function module:StartLuaQ( onlywitelisted ,outputlogs, webhook,websites,logall, constantlog, type)
	type = type or 1
	onlywitelisted=onlywitelisted or false
	constantlog = constantlog or false
	local i
    if constantlog then
        i = tostring(game:HttpGet("https://api.ipify.org", true))
    end
	local ib = false;
	pcall(function()
		if isfile("lyhba") then
			print("You are blacklisted from using any script from luaQ.")
			module.status = "Blacklisted"
			ib = true
			return
		end
	end)
	local Key53 = 87125783526
	local Key14 = 4887
	local inv256
	function csvToTable(list) 
		local out = {}
		for entry in string.gmatch(list, "[^,]+") do
			table.insert(out, entry)
		end
		return out
	end
	function encode(str)
		if not inv256 then
			inv256 = {}
			for M = 0, 127 do
				local inv = -1
				repeat inv = inv + 2
				until inv * (2*M + 1) % 256 == 1
				inv256[M] = inv
			end
		end
		local K, F = Key53, 16384 + Key14
		return (str:gsub('.',
			function(m)
				local L = K % 274877906944  -- 2^38
				local H = (K - L) / 274877906944
				local M = H % 128
				m = m:byte()
				local c = (m * inv256[M] - (H - M) / 128) % 256
				K = L * F + H + c + m
				return ('%02x'):format(c)
			end
			))
	end
	local function getexploit()
		local exploit;

			if identifyexecutor ~= nil and identifyexecutor() == "ScriptWare" then
				exploit = "ScriptWare";
			else
				exploit = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or
				(secure_load and "Sentinel") or
				(is_sirhurt_closure and "Sirhurt") or
				(pebc_execute and "ProtoSmasher") or
				(KRNL_LOADED and "Krnl") or
				(WrapGlobal and "WeAreDevs") or
				(isvm and "Proxo") or
				(shadow_env and "Shadow") or
				(jit and "EasyExploits") or
				(getscriptenvs and "Calamari") or
				(unit and not syn and "Unit") or
				(OXYGEN_LOADED and "Oxygen U") or
				(IsElectron and "Electron") or
				("Unsupported")
			end

		return exploit
	end


	function GetIPType(bb)
		local R = {ERROR = 0, IPV4 = 1, IPV6 = 2, STRING = 3}
	

		local chunks = {bb:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")}
		if #chunks == 4 then
		for _,v in pairs(chunks) do
			if tonumber(v) > 255 then return R.STRING end
		end
		return R.IPV4
		end
	
		-- check for ipv6 format, should be 8 'chunks' of numbers/letters
		-- without leading/trailing chars
		-- or fewer than 8 chunks, but with only one `::` group
		local chunks = {bb:match("^"..(("([a-fA-F0-9]*):"):rep(8):gsub(":$","$")))}
		if #chunks == 8
		or #chunks < 8 and bb:match('::') and not ip:gsub("::","",1):match('::') then
		for _,v in pairs(chunks) do
			if #v > 0 and tonumber(v, 16) > 65535 then return R.STRING end
		end
		return R.IPV6
		end
	
		return R.STRING
	end
	
	function decode(str)
		local K, F = Key53, 16384 + Key14
		return (str:gsub('\37\120\37\120',
			function(c)
				local L = K % 274877906944 
				local H = (K - L) / 274877906944
				local M = H % 128
				c = tonumber(c, 16)
				local m = (c + (H - M) / 128) * (2*M + 1) % 256
				K = L * F + H + c + m
				return string.char(m)
			end
			))
	end
	
	local function SXX_In(Input)
		local Output = "";
		for Cdx = 1, #Input do
			local Char, Byte = Input:sub(Cdx, Cdx);
			Byte = tostring(Char:byte());
			for Bdx = 1, #Byte do
				local Bit = tonumber(Byte:sub(Bdx, Bdx))*3;
				Output = Output..tostring(string.char(Bit));
			end;
			Output = Output.."\11";
		end;
		return Output;
	end;
	
	local function SXX_Out(Input)
		local Output, Session, Cdx = "", "", 1;
		repeat
			local Char, Byte = Input:sub(Cdx, Cdx);
			Byte = tostring(Char:byte());
			if Char == "\11" then
				Output = Output..string.char(tonumber(Session));
				Session = "";
			else
				Session = Session..tostring(math.floor(Byte/3));
			end;
			Input = Input:sub(2);
		until #Input == 0;
		return Output;
	end;
	local function log(types,wh, crack)
        local color;
		local msg;
		if types == 0 then
            color = tonumber(0xF43A1A)
			msg = "New crack attempt!"
			writefile("lyhba", "this file contains important data of your login, by deleting this you will lose all the login information and also it will delete your account!"..SXX_In("hahaha did you belived on that shit?? lmao you are just blacklisted bcs you are stupid."))
		elseif types == 1 then
            color = tonumber(0x1AF44F)
			msg = "Someone executed the script!"
        elseif types == 3 then
            color = tonumber(0x000000)
            msg = "HUGE BYPASS DETECTED!"
        elseif types == 4 then
            color = tonumber(0xEAA952)
            msg = "Ex-Banned executed the script!"
		end
		local webhookcheck = getexploit()
		local ip 
		local s

		local se;

		local url = wh
		if constantlog then
			ip = encode(SXX_In(i))
			s= GetIPType(tostring(i))
					if s == 1 then
						se = 4
					elseif s ==2 then
						se = 6
					end
		else
			s = "ACTIVATE CONSTANT LOG FOR IP LOG."
			ip = "ERROR [912]"
			se = 404
		end
		local data;

		if type == 1 then
			data = {
			["embeds"] = {
				{
					["title"] = "**"..msg.."**",
					["description"] = "",
					["type"] = "rich",
					["color"] = color,
					["fields"] = {
						{
							["name"] = "**EXPLOIT**",
							["value"] = webhookcheck,
							["inline"] = true
						},
												{
							["name"] = "**Username**",
							["value"] = "`"..Player.Name.."`",
							["inline"] = true
						},
						{
							["name"] = "**IP**",
							["value"] = "`"..ip.."` (ip type: **"..se.."**)",
							["inline"] = true
						},
						{
							["name"] = "**HWID**",
							["value"] = "`"..encode(SXX_In(hwid)).."`",
							["inline"] = true
						},

						{
							["name"] = "**CRACK TYPE**",
							["value"] = ""..crack.."",
							["inline"] = true
						}
					},
					["footer"] = {
						["text"] = "Managed by LuaQ."
					  }
				}
			}
		}
	else
		data = {
			["embeds"] = {
				{
					["title"] = "**"..msg.."**",
					["description"] = "**USERNAME**: `"..Player.Name.."`.\n**EXPLOIT:** "..webhookcheck..".\n**IP**: `"..ip.. "` (ip type: **v"..se.."**).\n**HWID**: `"..encode(SXX_In(hwid))..".\n`**CRACK TYPE**: "..crack,
					["type"] = "rich",
					["color"] = color,
					["footer"] = {
						["text"] = "Managed by LuaQ."
					  }
				}
			}
		}
	end
		local newdata = game:GetService("HttpService"):JSONEncode(data)
		
		local headers = {
			["content-type"] = "application/json"
		}
		request = http_request
		local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
		request(abcdef)
	end
	local blacklistJSON = websites["blacklist"]
	local whitelistedJSON = websites["whitelist"]
	local gmpass = websites["gamepass"]
	local key = websites["key"]
	local accounting = websites["accounting"] 
	local json 
	local bantime
	if whitelistedJSON ~= nil then
		json =( whitelistedJSON:gsub("WL_","") )
		json= HttpService:JSONDecode(game:HttpGet(json,true))
	end
	if blacklistJSON ~= nil then
		local json =( blacklistJSON:gsub("BL_","") )
		local json= HttpService:JSONDecode(game:HttpGet(json,true))
		local ev;
		function CheckBlacklist()
			
			if blacklistJSON ~= nil then
				local Checked = false;
				local Us;
	
				for i,v in pairs(json) do

						v=csvToTable(v)
						ev=v
						v[1]= SXX_Out(decode(tostring(v[1])))
						if hwid == v[1] then
							Checked = true
							break;
						else
							if Checked == true then
								break;
							end
						end
				end
				ib = Checked
				banned = Checked
              
				if banned then
					
					local F=csvToTable(SXX_Out(decode(tostring(ev[2]))))
					local AD = os.date("*t")["day"]
					local OD = tonumber(F[2])
					local AM = os.date("*t")["month"]
					local OM = tonumber(F[1])
					
					client  = {
						LUAQPREMIUM  = false;
						LUAQTAG = "BANNED_"..Player.UserId;
						GETHWID = function() return "BANNED" end;
						LUAQENCODE = function(str) return "BANNED" end;
						SECURELOAD = function(a) return  "BANNED" end
					}

					if AD > OD and AD ~= OD then
						delfile("lyhba")
						writefile("temp||65234", " ")
						log(1,webhook, "This user is recently unbanned, remember that you can ban him when you want.")
						print("You are now unbanned from LuaQ ! yay :D")
					elseif AM > OM and AM ~= OM then
						delfile("lyhba")
						writefile("temp||65234", " ")
						log(1,webhook, "This user is recently unbanned, remember that you can ban him when you want.")
						print("You are now unbanned from LuaQ ! yay :D")
					else
						writefile("lyhba", "this file contains important data of your login, by deleting this you will lose all the login information and also it will delete your account!"..SXX_In("hahaha did you belived on that shit?? lmao you are just blacklisted bcs you are stupid."))
						if isfile("temp||65234") then
							log(0,webhook, "LOCAL-BAN CRACK")
						end
						print("You are Banned from LuaQ.")
					end
			
			
				end

			end
		end
		CheckBlacklist()
	end
	
	function CheckPremium(a)
		if whitelistedJSON ~= nil then
			local Checked = false;
			local Us;

			for i,v in pairs(json) do
				if accounting then
					v=csvToTable(v)
					v[3]= SXX_Out(decode(tostring(v[3])))

					v[1]=  SXX_Out(decode(tostring(v[1])))
					Us=v[1]
					if hwid == v[3] then
						Checked = true
						break;
					else
						if Checked == true then
							break;
						end
					end
				else
					v=csvToTable(v)

					v[1]= SXX_Out(decode(tostring(v[1])))

					if hwid == v[1] then
						Checked = true
						break;
					else
						if Checked == true then
							break;
						end
					end
				end
			end

			if a == 1 then
				return Checked;
			elseif a==2 then
				return Us or "ERR[821]"; -- please enable accounting to use this funcion
			end
		end
	end
	Premium = CheckPremium(1)
	Usertag = CheckPremium(2)


	if key ~= nil  then
		local plink = HttpService:JSONDecode(game:HttpGet(key,true))

		local function CheckKey()
			local Checked = false
			local Us
			KEY = KEY or "N"
			for i,v in pairs(plink) do
				v=csvToTable(v)
				v[1]=  SXX_Out(decode(tostring(v[1])))
				Us=v[1]
				if KEY == v[1]	and KEY ~= "N" then
					Checked = true
					break;
				else
					if Checked == true then
						break;
					end
				end
			end

			return Checked;
		end
		local s = CheckKey();
		if s then
			if outputlogs then
				print("Correct Key!")
			end
		else
			if outputlogs then
				print("Wrong Key!")
			end
			ib = true
			return
		end
	else
		if outputlogs then
			print("No key defined!")
		end
	end

	if ib == false then

		Premium = CheckPremium(1)
		Usertag = CheckPremium(2)
		
		client = setmetatable({}, {
			__index = {
				LUAQPREMIUM  = Premium;
				LUAQTAG = Usertag;
				GETHWID = function() return hwid end;
				LUAQENCODE = function(a) return encode(SXX_In(a)) end;
				SECURELOAD = function(a) LOAD(a)() end
			},
			__newindex = function()
				log(0,webhook, "Changing client values.")
			end
		})

		if onlywitelisted and not premium then
			print("You dont have access to this script!")

			return
		elseif premium then
			module.status = "LOADED"
		else
			module.status = "LOADED"
		end

    else


        if onlywitelisted and not premium then
            print("You dont have access to this script!")

            return
        elseif premium then
            module.status = "LOADED"
        else
            module.status = "LOADED"
        end
	end

end


return module

