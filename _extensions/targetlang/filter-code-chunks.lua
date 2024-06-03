local str = pandoc.utils.stringify

local function lang_checker(target_lang)
  -- Check for the code blocks with different language other than `target_lang`
  -- and if it is something other than `target_lang`, then return `pandoc.Para`
  -- instead of CodeBlock. 
  return {
    CodeBlock = function(cb)
      if cb.classes:includes('cell-code') and (not cb.classes:includes(target_lang)) then
        return pandoc.Para("")
      else 
        return cb
      end
    end
  }
end


local function remove_div_with_para(target_lang)
  -- Now remove the Div whose first content is pandoc.Para
  return {
    Div = function(el)
      if el.classes:includes('cell') then
        local check_lang = el:walk(lang_checker(target_lang))
        if check_lang.content[1].t == "Para" then
          return pandoc.Null()
        else
          return el
        end
      end
    end
  }
end


function Pandoc(doc)
  local target_lang = doc.meta.target_lang and str(doc.meta.target_lang) or nil
  if target_lang then
    return doc:walk(remove_div_with_para(target_lang))
  end
  return doc
end
