--- @@ kr_hnc_1m_filter
--[[
（hangeul_hnc）
韓語遮屏只剩一個選項。開關（kr_1m）
--]]

local function kr_hnc_1m_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local kr_1m = context:get_option("kr_1m")
  local o_input = context.input  -- 原始未轉換輸入碼
  local special_key_v = string.match(o_input, '[v;]$')
  local special_key_qq = string.match(o_input, 'qq$')
  local special_key_slash = string.match(o_input, '//$')

  -- local find_prefix = env.engine.context.input
  -- local han_key = string.match(find_prefix, ';$')
  -- local input_in = env.engine.context.input  -- 原始未轉換輸入碼
  -- local han_key = string.match(input_in, ';')

  -- local prefix = env.engine.schema.config:get_string("easy_en/prefix")
  -- local input_n = string.len(input_in)
  -- local caret_pos = env.engine.context.caret_pos

  local cands = {}
  for cand in input:iter() do
    -- local kr_preedit = cand.preedit
    -- local special_key = string.match(kr_preedit, '[›]$')
    -- local han_key = string.match(kr_preedit, '；$')
    -- local special_key_v = string.match(env.engine.context.input, '[v;]$')
    -- local special_key_qq = string.match(env.engine.context.input, 'qq$')
    -- local special_key_slash = string.match(env.engine.context.input, '//$')
    if (kr_1m) and (not special_key_v) and (not special_key_qq) and (not special_key_slash) then
      table.insert(cands, cand)
      -- yield(cands[1])
  -- elseif (kr_1m) then
  --   local cands = {}
  --   for cand in input:iter() do
  --     table.insert(cands, cand)
  --   end
  --   yield(cands[1])
    else
      yield(cand)
    end
  end

  if (kr_1m) and cands[1]~=nil then
    if (not special_key_v) and (not special_key_qq) and (not special_key_slash) then
      yield(cands[1])
    end
  end

end


return kr_hnc_1m_filter