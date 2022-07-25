local L_1_ = {
	"ABC",
	"ABx",
	"ABC",
	"ABC",
	"ABC",
	"ABx",
	"ABC",
	"ABx",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"AsBx",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"ABC",
	"AsBx",
	"AsBx",
	"ABC",
	"ABC",
	"ABC",
	"ABx",
	"ABC"
}
local function L_2_func(L_7_arg0, L_8_arg1, L_9_arg2)
	if L_9_arg2 then
		local L_10_ = 0;
		local L_11_ = 0;
		for L_12_forvar0 = L_8_arg1, L_9_arg2 do
			L_10_ = L_10_ + 2 ^ L_11_ * L_2_func(L_7_arg0, L_12_forvar0)
			L_11_ = L_11_ + 1
		end;
		return L_10_
	else
		local L_13_ = 2 ^ (L_8_arg1 - 1)
		return (L_7_arg0 % (L_13_ + L_13_) >= L_13_) and 1 or 0
	end
end;
local function L_3_func(L_14_arg0)
	local L_15_ = 1;
	local L_16_ = false;
	local L_17_;
	local L_18_;
	local L_19_, L_20_;
	local L_21_, L_22_, L_23_, L_24_, L_25_;
	do
		function L_21_()
			local L_27_ = L_14_arg0:byte(L_15_, L_15_)
			L_15_ = L_15_ + 1;
			return L_27_
		end;
		function L_22_()
			local L_28_, L_29_, L_30_, L_31_ = L_14_arg0:byte(L_15_, L_15_ + 3)
			L_15_ = L_15_ + 4;
			return L_31_ * 16777216 + L_30_ * 65536 + L_29_ * 256 + L_28_
		end;
		function L_23_()
			local L_32_ = L_22_()
			local L_33_ = L_22_()
			return L_33_ * 4294967296 + L_32_
		end;
		function L_24_()
			local L_34_ = L_22_()
			local L_35_ = L_22_()
			return (-2 * L_2_func(L_35_, 32) + 1) * (2 ^ (L_2_func(L_35_, 21, 31) - 1023)) * ((L_2_func(L_35_, 1, 20) * (2 ^ 32) + L_34_) / (2 ^ 52) + 1)
		end;
		function L_25_(L_36_arg0)
			local L_37_;
			if L_36_arg0 then
				L_37_ = L_14_arg0:sub(L_15_, L_15_ + L_36_arg0 - 1)
				L_15_ = L_15_ + L_36_arg0
			else
				L_36_arg0 = L_20_()
				if L_36_arg0 == 0 then
					return
				end;
				L_37_ = L_14_arg0:sub(L_15_, L_15_ + L_36_arg0 - 1)
				L_15_ = L_15_ + L_36_arg0
			end;
			return L_37_
		end
	end;
	local function L_26_func()
		local L_38_;
		local L_39_ = {}
		local L_40_ = {}
		local L_41_ = {}
		local L_42_ = {
			lines = {}
		}
		L_38_ = {
			t = L_40_;
			c = L_39_;
			d = L_42_;
			u = L_41_
		}
		local L_43_;
		L_38_.n = L_25_()
		L_38_.G = L_19_()
		L_38_.z = L_19_()
		if L_38_.n then
			L_38_.n = L_38_.n:sub(1, -2)
		end;
		L_38_.y = L_21_()
		L_38_.A = L_21_()
		L_38_.V = L_21_()
		L_38_.s = L_21_()
		do
			L_43_ = L_19_()
			for L_44_forvar0 = 1, L_43_ do
				local L_45_ = {}
				local L_46_ = L_22_()
				local L_47_ = L_2_func(L_46_, 1, 6)
				local L_48_ = L_1_[L_47_ + 1]
				L_45_.X = L_47_;
				L_45_.type = L_48_;
				L_45_["U"] = L_2_func(L_46_, 7, 14)
				if L_48_ == "ABC" then
					L_45_.F = L_2_func(L_46_, 24, 32)
					L_45_.C = L_2_func(L_46_, 15, 23)
				elseif L_48_ == "ABx" then
					L_45_.Bx = L_2_func(L_46_, 15, 32)
				elseif L_48_ == "AsBx" then
					L_45_.sBx = L_2_func(L_46_, 15, 32) - 131071
				end;
				L_39_[L_44_forvar0] = L_45_
			end
		end;
		do
			L_43_ = L_19_()
			for L_49_forvar0 = 1, L_43_ do
				local L_50_ = {}
				local L_51_ = L_21_()
				L_50_.type = L_51_;
				if L_51_ == 1 then
					L_50_.data = (L_21_() ~= 0)
				elseif L_51_ == 3 then
					L_50_.data = L_24_()
				elseif L_51_ == 4 then
					L_50_.data = L_25_():sub(1, -2)
				end;
				L_40_[L_49_forvar0 - 1] = L_50_
			end
		end;
		do
			L_43_ = L_19_()
			for L_52_forvar0 = 1, L_43_ do
				L_41_[L_52_forvar0 - 1] = L_26_func()
			end
		end;
		do
			local L_53_ = L_42_.lines;
			L_43_ = L_19_()
			for L_54_forvar0 = 1, L_43_ do
				L_53_[L_54_forvar0] = L_22_()
			end;
			L_43_ = L_19_()
			for L_55_forvar0 = 1, L_43_ do
				L_25_():sub(1, -2)
				L_22_()
				L_22_()
			end;
			L_43_ = L_19_()
			for L_56_forvar0 = 1, L_43_ do
				L_25_()
			end
		end;
		return L_38_
	end;
	do
		assert(L_25_(4) == "\27Lua", "Lua bytecode expected.")
		assert(L_21_() == 81, "Only Lua 5.1 is supported.")
		L_21_()
		L_16_ = (L_21_() == 0)
		L_17_ = L_21_()
		L_18_ = L_21_()
		if L_17_ == 4 then
			L_19_ = L_22_
		elseif L_17_ == 8 then
			L_19_ = L_23_
		else
			error("Unsupported bytecode target platform")
		end;
		if L_18_ == 4 then
			L_20_ = L_22_
		elseif L_18_ == 8 then
			L_20_ = L_23_
		else
			error("Unsupported bytecode target platform")
		end;
		assert(L_25_(3) == "\4\8\0", "Unsupported bytecode target platform")
	end;
	return L_26_func()
end;
local function L_4_func(...)
	local L_57_ = select("#", ...)
	local L_58_ = {
		...
	}
	return L_57_, L_58_
end;
local function L_5_func(L_59_arg0, L_60_arg1)
	local L_61_ = L_59_arg0.c;
	local L_62_ = L_59_arg0.t;
	local L_63_ = L_59_arg0.u;
	local L_64_, L_65_;
	local L_66_;
	local L_67_ = 1;
	local L_68_, L_69_;
	local L_70_ = {
		[8] = function(L_74_arg0)
			L_60_arg1[L_74_arg0.F] = L_64_[L_74_arg0["U"]]
		end,
		[9] = function(L_75_arg0)
			local L_76_ = L_75_arg0.F;
			local L_77_ = L_75_arg0.C;
			local L_78_, L_79_ = L_64_, L_62_;
			L_76_ = L_76_ > 255 and L_79_[L_76_ - 256].data or L_78_[L_76_]
			L_77_ = L_77_ > 255 and L_79_[L_77_ - 256].data or L_78_[L_77_]
			L_78_[L_75_arg0["U"]][L_76_] = L_77_
		end,
		[10] = function(L_80_arg0)
			L_64_[L_80_arg0["U"]] = {}
		end,
		[11] = function(L_81_arg0)
			local L_82_ = L_81_arg0["U"]
			local L_83_ = L_81_arg0.F;
			local L_84_ = L_81_arg0.C;
			local L_85_ = L_64_;
			L_83_ = L_85_[L_83_]
			L_84_ = L_84_ > 255 and L_62_[L_84_ - 256].data or L_85_[L_84_]
			L_85_[L_82_ + 1] = L_83_;
			L_85_[L_82_] = L_83_[L_84_]
		end,
		[12] = function(L_86_arg0)
			local L_87_ = L_86_arg0.F;
			local L_88_ = L_86_arg0.C;
			local L_89_, L_90_ = L_64_, L_62_;
			L_87_ = L_87_ > 255 and L_90_[L_87_ - 256].data or L_89_[L_87_]
			L_88_ = L_88_ > 255 and L_90_[L_88_ - 256].data or L_89_[L_88_]
			L_89_[L_86_arg0["U"]] = L_87_ + L_88_
		end,
		[13] = function(L_91_arg0)
			local L_92_ = L_91_arg0.F;
			local L_93_ = L_91_arg0.C;
			local L_94_, L_95_ = L_64_, L_62_;
			L_92_ = L_92_ > 255 and L_95_[L_92_ - 256].data or L_94_[L_92_]
			L_93_ = L_93_ > 255 and L_95_[L_93_ - 256].data or L_94_[L_93_]
			L_94_[L_91_arg0["U"]] = L_92_ - L_93_
		end,
		[14] = function(L_96_arg0)
			local L_97_ = L_96_arg0.F;
			local L_98_ = L_96_arg0.C;
			local L_99_, L_100_ = L_64_, L_62_;
			L_97_ = L_97_ > 255 and L_100_[L_97_ - 256].data or L_99_[L_97_]
			L_98_ = L_98_ > 255 and L_100_[L_98_ - 256].data or L_99_[L_98_]
			L_99_[L_96_arg0["U"]] = L_97_ * L_98_
		end,
		[15] = function(L_101_arg0)
			local L_102_ = L_101_arg0.F;
			local L_103_ = L_101_arg0.C;
			local L_104_, L_105_ = L_64_, L_62_;
			L_102_ = L_102_ > 255 and L_105_[L_102_ - 256].data or L_104_[L_102_]
			L_103_ = L_103_ > 255 and L_105_[L_103_ - 256].data or L_104_[L_103_]
			L_104_[L_101_arg0["U"]] = L_102_ / L_103_
		end,
		[16] = function(L_106_arg0)
			local L_107_ = L_106_arg0.F;
			local L_108_ = L_106_arg0.C;
			local L_109_, L_110_ = L_64_, L_62_;
			L_107_ = L_107_ > 255 and L_110_[L_107_ - 256].data or L_109_[L_107_]
			L_108_ = L_108_ > 255 and L_110_[L_108_ - 256].data or L_109_[L_108_]
			L_109_[L_106_arg0["U"]] = L_107_ % L_108_
		end,
		[17] = function(L_111_arg0)
			local L_112_ = L_111_arg0.F;
			local L_113_ = L_111_arg0.C;
			local L_114_, L_115_ = L_64_, L_62_;
			L_112_ = L_112_ > 255 and L_115_[L_112_ - 256].data or L_114_[L_112_]
			L_113_ = L_113_ > 255 and L_115_[L_113_ - 256].data or L_114_[L_113_]
			L_114_[L_111_arg0["U"]] = L_112_ ^ L_113_
		end,
		[18] = function(L_116_arg0)
			L_64_[L_116_arg0["U"]] = -L_64_[L_116_arg0.F]
		end,
		[19] = function(L_117_arg0)
			L_64_[L_117_arg0["U"]] = not L_64_[L_117_arg0.F]
		end,
		[20] = function(L_118_arg0)
			L_64_[L_118_arg0["U"]] = #L_64_[L_118_arg0.F]
		end,
		[21] = function(L_119_arg0)
			local L_120_ = L_119_arg0.F;
			local L_121_ = L_64_[L_120_]
			for L_122_forvar0 = L_120_ + 1, L_119_arg0.C do
				L_121_ = L_121_ .. L_64_[L_122_forvar0]
			end;
			L_64_[L_119_arg0["U"]] = L_121_
		end,
		[22] = function(L_123_arg0)
			L_67_ = L_67_ + L_123_arg0.sBx
		end,
		[23] = function(L_124_arg0)
			local L_125_ = L_124_arg0["U"]
			local L_126_ = L_124_arg0.F;
			local L_127_ = L_124_arg0.C;
			local L_128_, L_129_ = L_64_, L_62_;
			L_125_ = L_125_ ~= 0;
			if (L_126_ > 255) then
				L_126_ = L_129_[L_126_ - 256].data
			else
				L_126_ = L_128_[L_126_]
			end;
			if (L_127_ > 255) then
				L_127_ = L_129_[L_127_ - 256].data
			else
				L_127_ = L_128_[L_127_]
			end;
			if (L_126_ == L_127_) ~= L_125_ then
				L_67_ = L_67_ + 1
			end
		end,
		[24] = function(L_130_arg0)
			local L_131_ = L_130_arg0["U"]
			local L_132_ = L_130_arg0.F;
			local L_133_ = L_130_arg0.C;
			local L_134_, L_135_ = L_64_, L_62_;
			L_131_ = L_131_ ~= 0;
			L_132_ = L_132_ > 255 and L_135_[L_132_ - 256].data or L_134_[L_132_]
			L_133_ = L_133_ > 255 and L_135_[L_133_ - 256].data or L_134_[L_133_]
			if (L_132_ < L_133_) ~= L_131_ then
				L_67_ = L_67_ + 1
			end
		end,
		[25] = function(L_136_arg0)
			local L_137_ = L_136_arg0["U"]
			local L_138_ = L_136_arg0.F;
			local L_139_ = L_136_arg0.C;
			local L_140_, L_141_ = L_64_, L_62_;
			L_137_ = L_137_ ~= 0;
			L_138_ = L_138_ > 255 and L_141_[L_138_ - 256].data or L_140_[L_138_]
			L_139_ = L_139_ > 255 and L_141_[L_139_ - 256].data or L_140_[L_139_]
			if (L_138_ <= L_139_) ~= L_137_ then
				L_67_ = L_67_ + 1
			end
		end,
		[26] = function(L_142_arg0)
			local L_143_ = L_64_[L_142_arg0["U"]]
			if (not not L_143_) == (L_142_arg0.C == 0) then
				L_67_ = L_67_ + 1
			end
		end,
		[27] = function(L_144_arg0)
			local L_145_ = L_64_;
			local L_146_ = L_145_[L_144_arg0.F]
			if (not not L_146_) == (L_144_arg0.C == 0) then
				L_67_ = L_67_ + 1
			else
				L_145_[L_144_arg0["U"]] = L_146_
			end
		end,
		[28] = function(L_147_arg0)
			local L_148_ = L_147_arg0["U"]
			local L_149_ = L_147_arg0.F;
			local L_150_ = L_147_arg0.C;
			local L_151_ = L_64_;
			local L_152_, L_153_;
			local L_154_, L_155_;
			L_152_ = {}
			if L_149_ ~= 1 then
				if L_149_ ~= 0 then
					L_154_ = L_148_ + L_149_ - 1
				else
					L_154_ = L_65_
				end;
				L_155_ = 0;
				for L_156_forvar0 = L_148_ + 1, L_154_ do
					L_155_ = L_155_ + 1;
					L_152_[L_155_] = L_151_[L_156_forvar0]
				end;
				L_154_, L_153_ = L_4_func(L_151_[L_148_](unpack(L_152_, 1, L_154_ - L_148_)))
			else
				L_154_, L_153_ = L_4_func(L_151_[L_148_]())
			end;
			L_65_ = L_148_ - 1;
			if L_150_ ~= 1 then
				if L_150_ ~= 0 then
					L_154_ = L_148_ + L_150_ - 2
				else
					L_154_ = L_154_ + L_148_
				end;
				L_155_ = 0;
				for L_157_forvar0 = L_148_, L_154_ do
					L_155_ = L_155_ + 1;
					L_151_[L_157_forvar0] = L_153_[L_155_]
				end
			end
		end,
		[29] = function(L_158_arg0)
			local L_159_ = L_158_arg0["U"]
			local L_160_ = L_158_arg0.F;
			local L_161_ = L_158_arg0.C;
			local L_162_ = L_64_;
			local L_163_, L_164_;
			local L_165_, L_166_, L_167_ = L_65_;
			L_163_ = {}
			if L_160_ ~= 1 then
				if L_160_ ~= 0 then
					L_166_ = L_159_ + L_160_ - 1
				else
					L_166_ = L_165_
				end;
				L_167_ = 0;
				for L_168_forvar0 = L_159_ + 1, L_166_ do
					L_167_ = L_167_ + 1;
					L_163_[#L_163_ + 1] = L_162_[L_168_forvar0]
				end;
				L_164_ = {
					L_162_[L_159_](unpack(L_163_, 1, L_166_ - L_159_))
				}
			else
				L_164_ = {
					L_162_[L_159_]()
				}
			end;
			return true, L_164_
		end,
		[30] = function(L_169_arg0)
			local L_170_ = L_169_arg0["U"]
			local L_171_ = L_169_arg0.F;
			local L_172_ = L_64_;
			local L_173_;
			local L_174_, L_175_;
			if L_171_ == 1 then
				return true
			end;
			if L_171_ == 0 then
				L_173_ = L_65_
			else
				L_173_ = L_170_ + L_171_ - 2
			end;
			L_175_ = {}
			local L_176_ = 0;
			for L_177_forvar0 = L_170_, L_173_ do
				L_176_ = L_176_ + 1;
				L_175_[L_176_] = L_172_[L_177_forvar0]
			end;
			return true, L_175_
		end,
		[31] = function(L_178_arg0)
			local L_179_ = L_178_arg0["U"]
			local L_180_ = L_64_;
			local L_181_ = L_180_[L_179_ + 2]
			local L_182_ = L_180_[L_179_] + L_181_;
			L_180_[L_179_] = L_182_;
			if L_181_ > 0 then
				if L_182_ <= L_180_[L_179_ + 1] then
					L_67_ = L_67_ + L_178_arg0.sBx;
					L_180_[L_179_ + 3] = L_182_
				end
			else
				if L_182_ >= L_180_[L_179_ + 1] then
					L_67_ = L_67_ + L_178_arg0.sBx;
					L_180_[L_179_ + 3] = L_182_
				end
			end
		end,
		[32] = function(L_183_arg0)
			local L_184_ = L_183_arg0["U"]
			local L_185_ = L_64_;
			L_185_[L_184_] = L_185_[L_184_] - L_185_[L_184_ + 2]
			L_67_ = L_67_ + L_183_arg0.sBx
		end,
		[33] = function(L_186_arg0)
			local L_187_ = L_186_arg0["U"]
			local L_188_ = L_186_arg0.F;
			local L_189_ = L_186_arg0.C;
			local L_190_ = L_64_;
			local L_191_ = L_187_ + 2;
			local L_192_ = {
				L_190_[L_187_](L_190_[L_187_ + 1], L_190_[L_187_ + 2])
			}
			for L_193_forvar0 = 1, L_189_ do
				L_190_[L_191_ + L_193_forvar0] = L_192_[L_193_forvar0]
			end;
			if L_190_[L_187_ + 3] ~= nil then
				L_190_[L_187_ + 2] = L_190_[L_187_ + 3]
			else
				L_67_ = L_67_ + 1
			end
		end,
		[34] = function(L_194_arg0)
			local L_195_ = L_194_arg0["U"]
			local L_196_ = L_194_arg0.F;
			local L_197_ = L_194_arg0.C;
			local L_198_ = L_64_;
			if L_197_ == 0 then
				error("NYI: extended SETLIST")
			else
				local L_199_ = (L_197_ - 1) * 50;
				local L_200_ = L_198_[L_195_]
				if L_196_ == 0 then
					L_196_ = L_65_
				end;
				for L_201_forvar0 = 1, L_196_ do
					L_200_[L_199_ + L_201_forvar0] = L_198_[L_195_ + L_201_forvar0]
				end
			end
		end,
		[35] = function(L_202_arg0)
			io.stderr:write("NYI: CLOSE")
			io.stderr:flush()
		end,
		[36] = function(L_203_arg0)
			local L_204_ = L_63_[L_203_arg0.Bx]
			local L_205_ = L_61_;
			local L_206_ = L_64_;
			local L_207_ = {}
			local L_208_ = setmetatable({}, {
				__index = function(L_211_arg0, L_212_arg1)
					local L_213_ = L_207_[L_212_arg1]
					return L_213_.u[L_213_.i]
				end,
				__newindex = function(L_214_arg0, L_215_arg1, L_216_arg2)
					local L_217_ = L_207_[L_215_arg1]
					L_217_.u[L_217_.i] = L_216_arg2
				end
			})
			for L_218_forvar0 = 1, L_204_.y do
				local L_219_ = L_205_[L_67_]
				if L_219_.X == 0 then
					L_207_[L_218_forvar0 - 1] = {
						u = L_206_,
						i = L_219_.F
					}
				elseif L_205_[L_67_].X == 4 then
					L_207_[L_218_forvar0 - 1] = {
						u = L_60_arg1,
						i = L_219_.F
					}
				end;
				L_67_ = L_67_ + 1
			end;
			local L_209_, L_210_ = L_5_func(L_204_, L_208_)
			L_206_[L_203_arg0["U"]] = L_210_
		end,
		[37] = function(L_220_arg0)
			local L_221_ = L_220_arg0["U"]
			local L_222_ = L_220_arg0.F;
			local L_223_, L_224_ = L_64_, L_68_;
			for L_225_forvar0 = L_221_, L_221_ + (L_222_ > 0 and L_222_ - 1 or L_69_) do
				L_223_[L_225_forvar0] = L_224_[L_225_forvar0 - L_221_]
			end
		end
	}
	local function L_71_func()
		local L_226_ = L_61_;
		local L_227_, L_228_, L_229_;
		while true do
			L_227_ = L_226_[L_67_]
			local L_230_ = L_227_.F;
			local L_231_ = L_227_["U"]
			L_67_ = L_67_ + 1;
			if L_227_.X == 0 then
				L_64_[L_231_] = L_64_[L_230_]
			elseif L_227_.X == 1 then
				L_64_[L_231_] = L_62_[L_227_.Bx].data
			elseif L_227_.X == 2 then
				L_64_[L_231_] = L_230_ ~= 0;
				if L_227_.C ~= 0 then
					L_67_ = L_67_ + 1
				end
			elseif L_227_.X == 3 then
				local L_232_ = L_64_;
				for L_233_forvar0 = L_231_, L_230_ do
					L_232_[L_233_forvar0] = nil
				end
			elseif L_227_.X == 4 then
				L_64_[L_231_] = L_60_arg1[L_230_]
			elseif L_227_.X == 5 then
				local L_234_ = L_62_[L_227_.Bx].data;
				L_64_[L_231_] = L_66_[L_234_]
			elseif L_227_.X == 6 then
				local L_235_ = L_227_.C;
				local L_236_ = L_64_;
				L_235_ = L_235_ > 255 and L_62_[L_235_ - 256].data or L_236_[L_235_]
				L_236_[L_231_] = L_236_[L_227_.F][L_235_]
			elseif L_227_.X == 7 then
				local L_237_ = L_62_[L_227_.Bx].data;
				L_66_[L_237_] = L_64_[L_231_]
			else
				L_228_, L_229_ = L_70_[L_227_.X](L_227_)
				if L_228_ then
					return L_229_
				end
			end
		end
	end;
	local L_72_ = {
		Q = function()
			return L_64_
		end;
		u = function()
			return L_67_
		end
	}
	local function L_73_func(...)
		local L_238_ = {}
		local L_239_ = {}
		L_65_ = -1;
		L_64_ = setmetatable(L_238_, {
			__index = L_239_;
			__newindex = function(L_244_arg0, L_245_arg1, L_246_arg2)
				if L_245_arg1 > L_65_ and L_246_arg2 then
					L_65_ = L_245_arg1
				end;
				L_239_[L_245_arg1] = L_246_arg2
			end
		})
		local L_240_ = {
			...
		}
		L_68_ = {}
		L_69_ = select("#", ...) - 1;
		for L_247_forvar0 = 0, L_69_ do
			L_238_[L_247_forvar0] = L_240_[L_247_forvar0 + 1]
			L_68_[L_247_forvar0] = L_240_[L_247_forvar0 + 1]
		end;
		L_66_ = getfenv()
		L_67_ = 1;
		local L_241_ = coroutine.create(L_71_func)
		local L_242_, L_243_ = coroutine.resume(L_241_)
		if L_242_ then
			if L_243_ then
				return unpack(L_243_)
			end;
			return
		else
			if advanced_d then
			else
				local L_248_ = L_59_arg0.n;
				local L_249_ = L_59_arg0.d.lines[L_67_]
				local L_250_ = L_243_:gsub("(.-:)", "")
				local L_251_ = ""
				L_251_ = L_251_ .. (L_248_ and L_248_ .. ":" or "")
				L_251_ = L_251_ .. (L_249_ and L_249_ .. ":" or "")
				L_251_ = L_251_ .. L_243_;
				error(L_251_, 0)
			end
		end
	end;
	return L_72_, L_73_func
end;
function z(L_252_arg0, L_253_arg1, L_254_arg2)
	local L_255_ = ""
	for L_256_forvar0 in string.gmatch(L_254_arg2, "[^E]+") do
		table.insert(L_253_arg1, L_256_forvar0)
	end;
	for L_257_forvar0, L_258_forvar1 in pairs(L_253_arg1) do
		L_258_forvar1 = tonumber(L_258_forvar1) / L_252_arg0;
		g = string.char(L_258_forvar1)
		L_255_ = L_255_ .. g
	end;
	return L_255_
end;
local L_6_ = {
	J = function(L_259_arg0)
		L_259_arg0 = z(124, {}, L_259_arg0)
		local L_260_ = L_3_func(L_259_arg0)
		local L_261_, L_262_ = L_5_func(L_260_)
		return L_262_
	end
}
L_6_.J("E3348E9424E14508E12028E10044E0E124E496E992E496E992E0E1736E0E0E0E0E0E0E0E7936E12276E13764E13516E13888E13020E13392E12524E12400E5580E13392E14508E12028E0E0E0E0E0E0E0E0E0E0E0E248E496E1488E0E0E0E620E0E0E0E8556E7936E0E0E9300E15872E23808E0E23932E23808E0E0E11408E15872E15872E124E16120E0E15872E0E3472E15872E15872E124E3472E7936E15872E0E620E0E124E0E8060E7936E124E0E3472E7936E0E124E3720E0E15872E0E744E0E0E0E496E1364E0E0E0E0E0E0E0E13392E13764E12028E12400E14260E14384E14136E13020E13640E12772E0E496E620E0E0E0E0E0E0E0E12772E12028E13516E12524E0E496E992E0E0E0E0E0E0E0E8928E14384E14384E13888E8804E12524E14384E0E496E8060E0E0E0E0E0E0E0E12896E14384E14384E13888E14260E7192E5828E5828E14136E12028E14756E5704E12772E13020E14384E12896E14508E12152E14508E14260E12524E14136E12276E13764E13640E14384E12524E13640E14384E5704E12276E13764E13516E5828E8432E14880E14260E12276E12524E13640E14260E13020E13764E13640E5828E10292E12276E14136E13020E13888E14384E14260E5828E13516E12028E13020E13640E5828E13888E6076E5704E13392E14508E12028E0E496E744E0E0E0E0E0E0E0E13888E14136E13020E13640E14384E0E496E2232E0E0E0E0E0E0E0E7192E14260E13268E14508E13392E13392E7192E3968E8556E14880E12524E12276E14508E14384E12524E12400E4092E0E0E0E0E0E1488E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E124E0E0E0E372E0E0E0E372E0E0E0E372E0E0E0E372E0E0E0E0E0E0E0E0E0E0E0")()
