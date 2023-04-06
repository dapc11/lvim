let s:file_pattern = '^[A-Z?] .\|^diff --'
let s:file_commit_pattern = s:file_pattern . '\|^\%(\l\{3,\} \)\=[0-9a-f]\{4,\} '
let s:item_pattern = s:file_commit_pattern . '\|^@@'
let s:section_pattern = '^[A-Z][a-z][^:]*$'
let s:section_commit_pattern = s:section_pattern . '\|^commit '

function! s:StageReveal() abort
  exe 'normal! zv'
  let begin = line('.')
  if getline(begin) =~# '^@'
    let end = begin + 1
    while getline(end) =~# '^[ \+-]'
      let end += 1
    endwhile
  elseif getline(begin) =~# '^commit '
    let end = begin
    while end < line('$') && getline(end + 1) !~# '^commit '
      let end += 1
    endwhile
  elseif getline(begin) =~# s:section_pattern
    let end = begin
    while len(getline(end + 1))
      let end += 1
    endwhile
  endif
  if exists('end')
    while line('.') > line('w0') + &scrolloff && end > line('w$')
      execute "normal! \<C-E>"
    endwhile
  endif
endfunction

function! s:PreviousItem(count) abort
  normal! 0
  for i in range(a:count)
    if !search(s:item_pattern, 'Wb') && getline('.') !~# s:item_pattern
      call search('^commit ', 'Wb')
    endif
  endfor
  call s:StageReveal()
  return '.'
endfunction

function! s:NextItem(count) abort
  for i in range(a:count)
    if !search(s:item_pattern, 'W') && getline('.') !~# s:item_pattern
      call search('^commit ', 'W')
    endif
  endfor
  call s:StageReveal()
  return '.'
endfunction

function! s:Map(mode, lhs, rhs, ...) abort
  let maps = []
  let defer = a:0 && a:1 =~# '<unique>' || get(g:, 'fugitive_defer_to_existing_maps')
  let flags = substitute(a:0 ? a:1 : '', '<unique>', '', '') . (a:rhs =~# '<Plug>' ? '' : '<script>') . '<nowait>'
  for mode in split(a:mode, '\zs')
    if a:0 <= 1
      call add(maps, mode.'map <buffer>' . substitute(flags, '<unique>', '', '') . ' <Plug>fugitive:' . a:lhs . ' ' . a:rhs)
    endif
    let skip = 0
    let head = a:lhs
    let tail = ''
    let keys = get(g:, mode.'remap', {})
    if type(keys) == type([])
      continue
    endif
    while !empty(head)
      if has_key(keys, head)
        let head = keys[head]
        let skip = empty(head)
        break
      endif
      let tail = matchstr(head, '<[^<>]*>$\|.$') . tail
      let head = substitute(head, '<[^<>]*>$\|.$', '', '')
    endwhile
    if !skip && (!defer || empty(mapcheck(head.tail, mode)))
      call add(maps, mode.'map <buffer>' . flags . ' ' . head.tail . ' ' . a:rhs)
      if a:0 > 1 && a:2
        let b:undo_ftplugin = get(b:, 'undo_ftplugin', 'exe') .
              \ '|sil! exe "' . mode . 'unmap <buffer> ' . head.tail . '"'
      endif
    endif
  endfor
  exe join(maps, '|')
  return ''
endfunction

function! s:MapMotion(lhs, rhs) abort
  let maps = [
        \ s:Map('n', a:lhs, ":<C-U>" . a:rhs . "<CR>", "<silent>"),
        \ s:Map('o', a:lhs, ":<C-U>" . a:rhs . "<CR>", "<silent>"),
        \ s:Map('x', a:lhs, ":<C-U>exe 'normal! gv'<Bar>" . a:rhs . "<CR>", "<silent>")]
  call filter(maps, '!empty(v:val)')
  return join(maps, '|')
endfunction

call s:MapMotion('>', 'exe <SID>PreviousItem(v:count1)')
call s:MapMotion('<', 'exe <SID>NextItem(v:count1)')

call s:Map('n', "<C-r>", ":Git pull --rebase<CR>", "<silent>")
call s:Map('n', "<C-p>", ":Git push<CR>", "<silent>")
call s:Map('n', "<C-å>", ":Git push origin HEAD:refs/for/master<CR>", "<silent>")

autocmd BufWinEnter */.git/index let @n="="
autocmd BufWinEnter */.git/index nnoremap <buffer><Tab> @n
