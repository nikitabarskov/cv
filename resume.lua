-- Map the CV Markdown structure to the LaTeX macros in styles.tex.
-- The Markdown stays plain; this filter only changes the presentation.
--
--   # Name           + paragraph  -> \resumename{Name} \resumecontacts{...}
--   ### Company      + paragraph  -> \entryheading{Company}{Location}
--   #### Role        + paragraph  -> \entrysubheading{Role}{Dates}

local NAME_LEVEL = 1

local ENTRY_MACROS = {
  [3] = "\\entryheading",
  [4] = "\\entrysubheading",
}

local function to_latex(inlines)
  local document = pandoc.Pandoc({ pandoc.Plain(inlines) })
  return (pandoc.write(document, "latex"):gsub("%s+$", ""))
end

local function raw_latex(text)
  return pandoc.RawBlock("latex", text)
end

local function is_paragraph(block)
  return block ~= nil and block.t == "Para"
end

local NO_BREAK_SPACE = "\u{00A0}"

-- Inline code marks contact details in the Markdown. Print it in the body font
-- and keep it on one line, for example the phone number.
function Code(element)
  return pandoc.Str((element.text:gsub(" ", NO_BREAK_SPACE)))
end

function Blocks(blocks)
  local result = pandoc.Blocks({})
  local index = 1
  while index <= #blocks do
    local block = blocks[index]
    local next_block = blocks[index + 1]
    if block.t == "Header" and block.level == NAME_LEVEL then
      result:insert(raw_latex("\\resumename{" .. to_latex(block.content) .. "}"))
      if is_paragraph(next_block) then
        result:insert(raw_latex("\\resumecontacts{" .. to_latex(next_block.content) .. "}"))
        index = index + 1
      end
    elseif block.t == "Header" and ENTRY_MACROS[block.level] and is_paragraph(next_block) then
      result:insert(raw_latex(string.format(
        "%s{%s}{%s}",
        ENTRY_MACROS[block.level],
        to_latex(block.content),
        to_latex(next_block.content)
      )))
      index = index + 1
    else
      result:insert(block)
    end
    index = index + 1
  end
  return result
end
