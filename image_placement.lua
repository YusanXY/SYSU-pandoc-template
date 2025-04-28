-- image_placement.lua
-- Pandoc Lua filter to allow setting LaTeX figure placement options
-- via Markdown image attributes.
-- Usage in Markdown: ![Caption](image.png){placement=H width=80% #fig:myid}
-- Requires LaTeX packages in template: graphicx, float (if using [H]), caption (recommended)

-- Function to check if a list of inlines is empty or only contains whitespace
local function is_caption_empty(caption_inlines)
    if not caption_inlines or #caption_inlines == 0 then
      return true
    end
    for _, inline in ipairs(caption_inlines) do
      if inline.t ~= 'Space' and inline.t ~= 'SoftBreak' then
        -- Found non-whitespace content
        return false
      end
    end
    -- Only whitespace found
    return true
  end
  
  -- Function to create the raw LaTeX figure code
  local function create_raw_figure(img_attrs, img_caption_inlines, img_target_url, placement_opt)
    -- 1. Prepare \includegraphics options (width, height)
    local graphicx_opts = {}
    if img_attrs.width and img_attrs.width ~= "" then
      table.insert(graphicx_opts, "width=" .. img_attrs.width)
    end
    if img_attrs.height and img_attrs.height ~= "" then
      table.insert(graphicx_opts, "height=" .. img_attrs.height)
    end
    local graphicx_opts_str = ""
    if #graphicx_opts > 0 then
      graphicx_opts_str = "[" .. table.concat(graphicx_opts, ",") .. "]"
    end
  
    -- 2. Prepare caption LaTeX
    -- Use pandoc.write to convert the list of inline elements to a LaTeX string
    local caption_latex = pandoc.write(pandoc.Inlines(img_caption_inlines), 'latex')
    local caption_str = "\\caption{" .. caption_latex .. "}\n"
  
    -- 3. Prepare label LaTeX (if identifier attribute exists)
    local label_str = ""
    if img_attrs.identifier and img_attrs.identifier ~= "" then
      -- Pandoc figure labels often have 'fig:' prefix automatically, but let's be safe
      local label = img_attrs.identifier
      if not label:startsWith('fig:') then
          -- If you want to enforce the 'fig:' prefix, uncomment the next line
          -- label = 'fig:' .. label
      end
      label_str = "\\label{" .. label .. "}\n" -- Place label after caption
    end
  
    -- 4. Assemble the full figure environment LaTeX string
    local figure_latex = table.concat({
      "\\begin{figure}[", placement_opt, "]\n",
      "\\centering\n",
      "\\includegraphics", graphicx_opts_str, "{", img_target_url, "}\n",
      caption_str,
      label_str, -- Label comes after caption
      "\\end{figure}"
    }, "")
  
    -- Return as a RawBlock element for Pandoc to insert directly
    return pandoc.RawBlock('latex', figure_latex)
  end
  
  
  -- Filter function: Process Paragraph elements
  function Para (para)
    -- Check if the paragraph consists *only* of a single Image element
    -- Pandoc typically wraps such paragraphs with captions into figures.
    if #para.content == 1 and para.content[1].t == "Image" then
      local img = para.content[1]
      local attrs = img.attributes
      local caption_inlines = img.caption -- This is a list of inline elements
  
      -- Check if:
      -- 1. The 'placement' attribute exists
      -- 2. The caption is not empty (visually)
      if attrs.placement and attrs.placement ~= "" and not is_caption_empty(caption_inlines) then
        -- If both conditions met, generate the custom LaTeX figure
        return create_raw_figure(attrs, caption_inlines, img.target.url, attrs.placement)
      end
    end
  
    -- If conditions are not met, return nil so Pandoc handles the paragraph normally.
    return nil
  end
  