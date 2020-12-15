--[[
Copyright (c) 2009 Muhammad Lukman Nasaruddin (ai-chan) ~ Traduzido e Actualizado por Leinad4Mind ~

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Automation script: Criar Gradiente/制作色彩梯度
]]

script_name = "制作色彩梯度"
script_description = "制作渐变色字幕"
script_author = "ai-chan"
script_version = "1.3"
script_modified = "25 Sep. 2012"
script_translator = "由Leinad4Mind修改并翻译为葡语，桃径汉化"

include("karaskel.lua")

if not gradient then gradient = {} end
gradient.conf = {
	[1] = { class = "label"; x = 0; y = 0; height = 1; width = 5; label = string.format("%s %s 由 %s 编写 (更新于 %s)\n%s\n", script_name, script_version, script_author, script_modified, script_translator) }
	,
	[3] = { label = "应用于"; class = "label"; x = 0; y = 1; height = 1; width = 1 }
	,
	[4] = { name = "applyto"; class = "dropdown"; x = 1; y = 1; height = 1; width = 4; items = { }; value = nil }
	,
	[5] = { label = "样式"; class = "label"; x = 0; y = 2; height = 1; width = 1 }
	,
	[6] = { name = "mode"; class = "dropdown"; x = 1; y = 2; height = 1; width = 4;
		items = { "平滑渐变（横向）", "平滑渐变（纵向）", "按字符渐变", "按音节渐变" }; value = "平滑渐变（横向）"
	}
	,
	[8] = { label = "单色占据的像素数（平滑渐变模式）"; class = "label"; x = 0; y = 3; height = 1; width = 3 }
	,
	[9] = { name = "stripx"; class = "intedit"; x = 3; y = 3; height = 1; width = 2; min = 1; max = 100; value = 10 }
	,
	[10] = { label = "卡拉OK效果"; class = "label"; x = 0; y = 4; height = 1; width = 1 }
	,
	[11] = { name = "karamode"; class = "dropdown"; x = 1; y = 4; height = 1; width = 4;
		items = { "原字幕卡拉OK效果", "不应用卡拉OK效果", "\\k", "\\kf", "\\ko" }; value = "原字幕卡拉OK效果"
    }
	,
	[12] = { label = "主要填充颜色"; class = "label"; x = 1; y = 5; height = 1; width = 1 }
	,
	[13] = { name = "primary_mode"; class = "dropdown"; x = 1; y = 6; height = 1; width = 1;
		items = { }; value = "忽略"
    }
    ,
	[14] = { label = "次要填充颜色"; class = "label"; x = 2; y = 5; height = 1; width = 1 }
	,
	[15] = { name = "secondary_mode"; class = "dropdown"; x = 2; y = 6; height = 1; width = 1;
		items = { }; value = "忽略"
    }
	,
	[16] = { label = "边框颜色"; class = "label"; x = 3; y = 5; height = 1; width = 1 }
	,
	[17] = { name = "outline_mode"; class = "dropdown"; x = 3; y = 6; height = 1; width = 1;
		items = { }; value = "忽略"
    }
	,
	[18] = { label = "阴影颜色"; class = "label"; x = 4; y = 5; height = 1; width = 1 }
	,
	[19] = { name = "shadow_mode"; class = "dropdown"; x = 4; y = 6; height = 1; width = 1;
		items = { }; value = "忽略"
    }
	,
	[20] = { label = "颜色"; class = "label"; x = 0; y = 6; height = 1; width = 1 }
	,
	[21] = { label = "颜色 1"; class = "label"; x = 0; y = 7; height = 1; width = 1 }
	,
	[22] = { name = "primary_color1"; class = "color"; x =1; y = 7; height = 1; width = 1 }
	,
	[23] = { name = "secondary_color1"; class = "color"; x = 2; y = 7; height = 1; width = 1 }
	,
	[24] = { name = "outline_color1"; class = "color"; x = 3; y = 7; height = 1; width = 1 }
	,
	[25] = { name = "shadow_color1"; class = "color"; x = 4; y = 7; height = 1; width = 1 }
	,
	[26] = { label = "颜色 2"; class = "label"; x = 0; y = 8; height = 1; width = 1 }
	,
	[27] = { name = "primary_color2"; class = "color"; x = 1; y = 8; height = 1; width = 1 }
	,
	[28] = { name = "secondary_color2"; class = "color"; x = 2; y = 8; height = 1; width = 1 }
	,
	[29] = { name = "outline_color2"; class = "color"; x = 3; y = 8; height = 1; width = 1 }
	,
	[30] = { name = "shadow_color2"; class = "color"; x = 4; y = 8; height = 1; width = 1 }
	,
	[31] = { label = "颜色 3"; class = "label"; x = 0; y = 9; height = 1; width = 1 }
	,
	[32] = { name = "primary_color3"; class = "color"; x = 1; y = 9; height = 1; width = 1 }
	,
	[33] = { name = "secondary_color3"; class = "color"; x = 2; y = 9; height = 1; width = 1 }
	,
	[34] = { name = "outline_color3"; class = "color"; x = 3; y = 9; height = 1; width = 1 }
	,
	[35] = { name = "shadow_color3"; class = "color"; x = 4; y = 9; height = 1; width = 1 }
}

gradient.config_keys = { 4, 6, 9, 11, 13, 15, 17, 19 }
gradient.last_run = 0
gradient.color_comp_count = 3
gradient.colorkeys = { [1] = "primary"; [2] = "secondary"; [3] = "outline"; [4] = "shadow" }

function gradient.save_config(config)
    for _, i in ipairs(gradient.config_keys) do
        gradient.conf[i].value = config[gradient.conf[i].name]
    end
    for j = 1, gradient.color_comp_count do
    	local jk = 17 + 5*j
    	for k = jk, jk + 3 do
     		gradient.conf[k].value = config[gradient.conf[k].name]
    	end
    end
end

function gradient.serialize_config(config)
    local scfg = string.format("%d ", gradient.last_run)
    for _, i in ipairs(gradient.config_keys) do
        scfg = scfg .. config[gradient.conf[i].name] .. string.char(2)
    end
    for j = 1, gradient.color_comp_count do
    	local jk = 17 + 5*j
    	for k = jk, jk + 3 do
     		scfg = scfg .. config[gradient.conf[k].name] .. string.char(2)
    	end
    end
    return string.trim(scfg)
end

function gradient.unserialize_config(scfg)
    local c = 0
    local cfgtime, scfg = string.headtail(string.trim(scfg))
    local keys_count = #gradient.config_keys
    if tonumber(cfgtime) > gradient.last_run then
        for g in string.gmatch(scfg, "[^"..string.char(2).."]+") do
            c = c + 1
            if c <= keys_count then
  	 		    gradient.conf[gradient.config_keys[c]].value = g
 		    else
 		        local kc = 20 + c - keys_count
 		        if kc % 5 == 1 then c, kc = c + 1, kc + 1 end
 		    	if not gradient.conf[kc] then gradient.append_color_components() end
  	 		 	gradient.conf[kc].value = g
 		    end
        end
    end
end

function gradient.append_color_components()
    gradient.color_comp_count = gradient.color_comp_count + 1
    gradient.conf[16 + gradient.color_comp_count * 5] = { label = "颜色 " .. gradient.color_comp_count; class = "label"; x = 0; y = gradient.color_comp_count + 6; height = 1; width = 1 }
    for i = 1, 4 do
	    gradient.conf[i + 16 + gradient.color_comp_count * 5] = {
            name = gradient.colorkeys[i] .. "_color" .. gradient.color_comp_count;
			class = "color"; x = i; y = gradient.color_comp_count + 6; height = 1; width = 1 }
    end
end

function gradient.unappend_color_components()
    for i = 0, 4 do
	    gradient.conf[i + 16 + gradient.color_comp_count * 5] = nil
    end
    gradient.color_comp_count = gradient.color_comp_count - 1
end

function gradient.process(meta, styles, config, subtitles, selected_lines, active_line)
    gradient.save_config(config)
    gradient.last_run = os.time()
    local scfg = gradient.serialize_config(config)
    -- Get colors
    local colors_count = { primary = 0; secondary = 0; outline = 0; shadow = 0 }
    local colors = { primary = {}; secondary = {}; outline = {}; shadow = {} }
    for k = 1,4 do
        local key = gradient.colorkeys[k]
        if config[key .. "_mode"] ~= "忽略" then
            count, _ = string.headtail(config[key .. "_mode"])
            colors_count[key] = tonumber(count)
        end
        for j = 1,colors_count[key] do
            local htmlcolor = config[key .. "_color" .. j]
            local r, g, b = string.match(htmlcolor, "(%x%x)(%x%x)(%x%x)")
            colors[key][j] = ass_color(tonumber(r,16), tonumber(g,16), tonumber(b,16))
        end
    end

    if colors_count["primary"] + colors_count["secondary"]+ colors_count["outline"] + colors_count["shadow"] == 0 then
        aegisub.debug.out(0, "A operação falhou porque não configurou o contador do gradiente para as cores primária/secundária/borda/sombra.")
        return false
    end

    -- Mode
    local mode_digest = { ["平滑渐变（横向）"] = 1; ["平滑渐变（纵向）"] = 2; ["按字符渐变"] = 3; ["按音节渐变"] = 4 }
    config.mode = mode_digest[config.mode]

    -- karaoke tag function
    config.karatagfn = function(syl) return "" end
    if config.karamode ~= "不应用卡拉OK效果" then
       if config.karamode == "原字幕卡拉OK效果" then
	   	   config.karatagfn = function(syl) return string.format("{\\%s%d}", syl.tag, syl.kdur) end
       else
	   	   config.karatagfn = function(syl) return string.format("{%s%d}", config.karamode, syl.kdur) end
	   end
	end

    -- Get lines indexes
	local subs = {}
	local applyto_type, applyto_more = string.headtail(config.applyto)
	if applyto_type == "全部行" then
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and not subtitles[i].comment and not gradient.has_gradient(subtitles[i]) then
			   table.insert(subs,i)
  	        end
		end
	elseif applyto_type == "选中行" then
		subs = selected_lines
	elseif applyto_type == "样式" then
		local _, applytostyle = string.headtail(applyto_more)
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and not subtitles[i].comment and not gradient.has_gradient(subtitles[i])
				and subtitles[i].style == applytostyle then table.insert(subs,i) end
		end
	elseif applyto_type == "Personagem" then
		local _, applytoactor = string.headtail(applyto_more)
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and not subtitles[i].comment and not gradient.has_gradient(subtitles[i])
				and subtitles[i].actor == applytoactor then table.insert(subs,i) end
		end
	end

	-- process them
	local subtitles2 = {}
	local lasti = 0
	local count = 0
	local newlines = 0
	local configstored = false

	for _, i in pairs(subs) do
		count = count + 1
		aegisub.progress.set(count * 100 / #subs)
		if aegisub.progress.is_cancelled() then return false end
		for j = lasti + 1, i - 1 do
    		if not configstored then
                if subtitles[j].class == "clear" then
        		    local iline = { class = "info", section = "Script Info"; key = "制作色彩梯度"; value = scfg }
        		    table.insert(subtitles2, iline)
        		    configstored = true
    		    elseif subtitles[j].class == "info" and subtitles[j].key == "制作色彩梯度" then
   		    	    local iline = table.copy(subtitles[j])
    		        iline.value = scfg
    		        subtitles[j] = iline
        		    configstored = true
                end
    		end
			table.insert(subtitles2, subtitles[j])
		end

		local line = subtitles[i]
		karaskel.preproc_line(subtitles, meta, styles, line)
		local res = gradient.do_line(meta, styles, config, colors, line)
		for j = 1, #res do
			table.insert(subtitles2, res[j])
			newlines = newlines + 1
		end
		lasti = i
		aegisub.progress.task(count .. " / " .. #subs .. " linhas a serem processadas")
	end
	for j = lasti + 1, #subtitles do
		table.insert(subtitles2, subtitles[j])
	end
	-- clear subtitles and rebuild
	subtitles.deleterange(1, #subtitles)
	for j = 1, #subtitles2 do
		subtitles[0] = subtitles2[j]
	end
	return true
end

function gradient.do_line(meta, styles, config, colors, line)
    local results = {}
    local linetext = ""
    local nline = {}
    local mode = config.mode
    if #line.kara == 0 and mode == 4 then mode = 3 end
    local linewidth = line.width + 2*line.styleref.outline + line.styleref.shadow
    local lineheight = line.height + 2*line.styleref.outline + line.styleref.shadow
    local lineleft = line.left - line.styleref.outline
    local lineright = line.right + line.styleref.outline + line.styleref.shadow
    local linetop = line.top - line.styleref.outline
    local linebottom = line.bottom + line.styleref.outline + line.styleref.shadow
    math.randomseed(os.time()+line.start_time)
    local randomtag = math.random(273, 4095)

    -- new in 1.2: preserve \pos and \move
    local pos_mode, pos_tag = 0, string.format("\\pos(%d,%d)", line.x, line.y)
	local dx, dy, dy1, dy2, animtimes = 0, 0, 0, 0, ""
	local pos_s, _, pos_x, pos_y = string.find(line.text, "{[^}]*\\pos%(([^,%)]*),([^,%)]*)%).*}")
	local mov_s, _, mov_x1, mov_y1, mov_x2, mov_y2  = string.find(line.text, "{[^}]*\\move%(([^,%)]*),([^,%)]*),([^,%)]*),([^,%)]*)%).*}")
	local movt_s, _, movt_x1, movt_y1, movt_x2, movt_y2, movt_t1, movt_t2 = string.find(line.text, "{[^}]*\\move%(([^,%)]*),([^,%)]*),([^,%)]*),([^,%)]*),([^,%)]*),([^,%)]*)%).*}")
	local coordparse = function(h) local i = string.headtail(string.trim(tostring(h))); i = tonumber(i); if not i then i = 0 end; return i end

	if pos_s and (not mov_s or pos_s < mov_s) and (not movt_s or pos_s < movt_s) then
		pos_mode = 1
		pos_x, pos_y = coordparse(pos_x), coordparse(pos_y)
		pos_tag = string.format("\\pos(%d,%d)", pos_x, pos_y)
 	    dx, dy = pos_x - line.x, pos_y - line.y
	elseif mov_s and (not movt_s or mov_s < movt_s) then
		pos_mode = 2
		mov_x1, mov_y1, mov_x2, mov_y2 = coordparse(mov_x1), coordparse(mov_y1), coordparse(mov_x2), coordparse(mov_y2)
		pos_tag = string.format("\\move(%d,%d,%d,%d)", mov_x1, mov_y1, mov_x2, mov_y2)
 	    dx, dy = mov_x1 - line.x, mov_y1 - line.y
 	    dx2, dy2 = mov_x2 - line.x, mov_y2 - line.y
	elseif movt_s then
		pos_mode = 3
		movt_x1, movt_y1, movt_x2, movt_y2 = coordparse(movt_x1), coordparse(movt_y1), coordparse(movt_x2), coordparse(movt_y2)
		movt_t1, movt_t2 = coordparse(movt_t1), coordparse(movt_t2)
		pos_tag = string.format("\\move(%d,%d,%d,%d,%d,%d)", movt_x1, movt_y1, movt_x2, movt_y2, movt_t1, movt_t2)
 	    dx, dy = movt_x1 - line.x, movt_y1 - line.y
 	    dx2, dy2 = movt_x2 - line.x, movt_y2 - line.y
 	    animtimes = string.format("%d,%d,",movt_t1,movt_t2)
	end

	local clipper = function(x1, y1, x2, y2)
 		local outstr = string.format("\\clip(%d,%d,%d,%d)", x1+dx, y1+dy, x2+dx, y2+dy)
 		if pos_mode > 1 then
			outstr = outstr .. string.format("\\t(%s\\clip(%d,%d,%d,%d))", animtimes, x1+dx2, y1+dy2, x2+dx2, y2+dy2)
		end
		return outstr .. pos_tag
	end

    if mode < 3 then
        nline = table.copy(line)
        nline.comment = true
        nline.effect = string.format("gradiente @%x 0", randomtag)
        results = { [1] = nline }
        if #line.kara > 0 then
            for s, syl in ipairs(line.kara) do
                linetext = linetext .. config.karatagfn(syl) .. syl.text_stripped
            end
        else
            linetext = line.text_stripped
        end
    end

    if mode == 1 then
        local left, right = 0, config.stripx
        local count = 0
        local nlinewidth = linewidth-config.stripx
        repeat
            nline = table.copy(line)
            nlinetext = string.format("{%s%s}%s",
					  clipper(left+lineleft,linetop,right+lineleft,linebottom),
					  gradient.color_interpolator(left, nlinewidth, colors), linetext)
            nline.text = nlinetext
            count = count + 1
            nline.effect = string.format("gradiente @%x %00d", randomtag, count)
            table.insert(results, nline)
            left = right
            right = right + config.stripx
        until left >= linewidth and not aegisub.progress.is_cancelled()
    elseif mode == 2 then
        local top, bottom = 0, config.stripx
        local count = 0
        local nlineheight = lineheight-config.stripx
        repeat
            nline = table.copy(line)
            nlinetext = string.format("{%s%s}%s",
					  clipper(lineleft,linetop+top,lineright,linetop+bottom),
					  gradient.color_interpolator(top, nlineheight, colors), linetext)
            nline.text = nlinetext
            count = count + 1
            nline.effect = string.format("gradiente @%x %00d", randomtag, count)
            table.insert(results, nline)
            top = bottom
            bottom = bottom + config.stripx
        until top >= lineheight and not aegisub.progress.is_cancelled()
    elseif mode == 3 then
        if #line.kara > 0 and config.karamode ~= "不应用卡拉OK效果" then
            for s, syl in ipairs(line.kara) do
                local left, right, syltext = syl.left,0,""
                for char in unicode.chars(syl.text_stripped) do
                    width, height, descent, ext_lead = aegisub.text_extents(line.styleref, char)
                    right = left + width
                    local colortags = gradient.color_interpolator(gradient.calc_j(left, right, line.width), line.width, colors)
                    if colortags ~= "" then colortags = "{" .. colortags .. "}" end
                    syltext = syltext .. colortags .. char
                    left = right
                end
                linetext = linetext .. config.karatagfn(syl) .. syltext
            end
        else
            local left, right = 0,0
            for char in unicode.chars(line.text_stripped) do
                local width, height, descent, ext_lead = aegisub.text_extents(line.styleref, char)
                right = left + width
                local colortags = gradient.color_interpolator(gradient.calc_j(left, right, line.width), line.width, colors)
                if colortags ~= "" then colortags = "{" .. colortags .. "}" end
                linetext = linetext .. colortags .. char
                left = right
            end
        end
        if pos_mode > 0 then linetext = string.format("{%s}%s", pos_tag, linetext) end
    elseif mode == 4 then
        for s, syl in ipairs(line.kara) do
            local colortags = gradient.color_interpolator(gradient.calc_j(syl.left, syl.right, line.width), line.width, colors)
            if colortags ~= "" then colortags = "{" .. colortags .. "}" end
            local syltext = config.karatagfn(syl) .. colortags .. syl.text_stripped
            linetext = linetext .. syltext
        end
        if pos_mode > 0 then linetext = string.format("{%s}%s", pos_tag, linetext) end
    end

    if mode > 2 then
        nline = table.copy(line)
        nline.text = linetext
        results = { [1] = nline }
    end

    return results
end

function gradient.calc_j(left, right, width)
    if left + right < width then
        return left + ((right - left) * left / width)
    else
        return left + ((right - left) * right / width)
    end
end

function gradient.color_interpolator(j, maxj, colors)
    local colors_out = ""
    for c = 1,4 do
        local dcolors = colors[gradient.colorkeys[c]]
        local cc = #dcolors
        if cc > 1 then
            local nmaxj = maxj/(cc-1)
            local k = clamp(math.floor(j/nmaxj), 0, cc-2)
            local nj = j - (k*nmaxj)
            colors_out = colors_out .. string.format("\\%dc%s",c,interpolate_color(nj/nmaxj, dcolors[k+1], dcolors[k+2]))
        end
    end
    return colors_out
end

function gradient.prepareconfig(styles, subtitles, selected)
    local applyto = 4
	gradient.conf[applyto].items = {}
	oldapplytovalue = gradient.conf[applyto].value
	gradient.conf[applyto].value = "全部行"
	table.insert(gradient.conf[applyto].items, gradient.conf[applyto].value)
	if #selected > 0 then
		applytoselected = string.format("选中行 (%d)", #selected)
		table.insert(gradient.conf[applyto].items, applytoselected)
		if oldapplytovalue == applytoselected then gradient.conf[applyto].value = applytoselected end
	end

	for i, style in ipairs(styles) do
        itemname = string.format("样式 = %s", style.name)
		table.insert(gradient.conf[applyto].items, itemname)
		if oldapplytovalue == itemname then gradient.conf[applyto].value = itemname end
	end

	local actors = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and not subtitles[i].comment and subtitles[i].actor ~= "" then
		    if not actors[subtitles[i].actor] then
		        actors[subtitles[i].actor] = true
		        itemname = string.format("Personagem = %s", subtitles[i].actor)
                table.insert(gradient.conf[applyto].items, itemname)
           		if oldapplytovalue == itemname then gradient.conf[applyto].value = itemname end
            end
        end
	end

	for i = 1, 4 do
		local j = 11 + i * 2
		local found, item = (gradient.conf[j].value == "忽略"), ""
		gradient.conf[j].items = { [1] = "忽略" }
		for k = 2, gradient.color_comp_count do
		    item = string.format("%d 颜色", k)
			gradient.conf[j].items[k] = item
			if gradient.conf[j].value == item then found = true end
		end
		if not found then gradient.conf[j].value = item end
	end
end

function gradient.macro_process(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	-- configuration
	if meta["gradientfactory"] ~= nil then
	   gradient.unserialize_config(meta["gradientfactory"])
	end

	-- filter selected_lines
	local subs = {}
    for _, i in ipairs(selected_lines) do
        if not subtitles[i].comment and not gradient.has_gradient(subtitles[i]) then
		   table.insert(subs,i)
	   end
    end
    selected_lines = subs

	-- display dialog
	local cfg_res, config
	repeat
    	gradient.prepareconfig(styles, subtitles, selected_lines)
    	local dlgbuttons = {"确定","+颜色","-颜色","取消"}
    	if gradient.color_comp_count <= 2 then dlgbuttons = {"确定","+颜色","取消"} end
        cfg_res, config = aegisub.dialog.display(gradient.conf, dlgbuttons)
        if cfg_res == "+颜色" then
           gradient.save_config(config)
           gradient.append_color_components()
        elseif cfg_res == "-颜色" then
           gradient.save_config(config)
           gradient.unappend_color_components()
        end
    until cfg_res ~= "+颜色" and cfg_res ~= "-颜色"

    if cfg_res == "确定" then
		result = gradient.process(meta, styles, config, subtitles, selected_lines, active_line)
		if result then
    		aegisub.set_undo_point("制作色彩梯度")
    		aegisub.progress.task("Terminado")
    	else
    		aegisub.progress.task("Erro");
    	end
	else
		aegisub.progress.task("Cancelado");
	end
end

function gradient.macro_undo(subtitles, selected_lines, active_line)
    local tag = string.match(subtitles[selected_lines[1]].effect, "@%x+")
    local pattern = "^gradiente " .. tag .. " (%d+)$"
	local subtitles2 = {}

	for i = 1, #subtitles do
	    local nline = table.copy(subtitles[i])
	    if subtitles[i].class == "dialogue" then
            local c = string.match(subtitles[i].effect, pattern)
            if c == "0" then
                nline.comment = false
                nline.effect = ""
                table.insert(subtitles2, nline)
            elseif c == nil then
                table.insert(subtitles2, nline)
            end
        else
            table.insert(subtitles2, nline)
        end
	end

	subtitles.deleterange(1, #subtitles)
	for j = 1, #subtitles2 do
		subtitles[0] = subtitles2[j]
	end

	aegisub.set_undo_point("移除本行色彩梯度")
end

function gradient.validate_undo(subtitles, selected_lines, active_line)
    if not (#selected_lines > 0) then return false end
    return gradient.has_gradient(subtitles[selected_lines[1]])
end

function gradient.has_gradient(line)
    return (nil ~= string.match(line.effect, "^gradiente @%x+ %d+$"))
end

-- register macros
aegisub.register_macro("制作色彩梯度", "制作色彩梯度", gradient.macro_process)
aegisub.register_macro("移除本行色彩梯度", "移除本行色彩梯度", gradient.macro_undo, gradient.validate_undo)
