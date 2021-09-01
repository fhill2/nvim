function! GetVisualSelection()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end

    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ['']
    endif
    if &selection ==# "exclusive"
        let column_end -= 1 "Needed to remove the last character to make it match the visual selction
    endif
    if visualmode() ==# "\<C-V>"
        for idx in range(len(lines))
            let lines[idx] = lines[idx][: column_end - 1]
            let lines[idx] = lines[idx][column_start - 1:]
        endfor
    else
        let lines[-1] = lines[-1][: column_end - 1]
        let lines[ 0] = lines[ 0][column_start - 1:]
    endif
   " echo lines
    " return lines
    "use this return if you want an array of text lines
    return join(lines, "\n") "use this return instead if you need a text block
endfunction


" function! Log(msg)
" " !echo msg >> /home/f1/.local/share/nvim/logs/nvim-vim.log
" call writefile([a:msg], "/home/f1/.local/share/nvim/logs/nvim-vim.log", "a")
" endfunction

function! Slisten() 

function! SockHandler(chan_id, data, event)
   let g:event = [a:chan_id, a:data, a:event]
 endfunction

let x = sockconnect('pipe', '/tmp/nv2server.sock', {'on_output': 'SockHandler'})
call jobsend(x, "blargh")
echo g:event 

endfunction

" call this from script:
" call Log('msg
"
"


" Log a message
function! Log(message)
  " Bail if not logging
 " if g:codi#log ==# '' | return | endif

  " Grab stack trace not including log function
  let stacktrace = expand('<sfile>')
  let stacktrace = stacktrace[0:strridx(stacktrace, '..') - 1]

  " Remove everything except the last function
  let i = strridx(stacktrace, '..')
  if i != -1
    let fname = stacktrace[i + 2:]
  else
    " Strip 'function '
    let fname = stacktrace[9:]
  endif

  " Create timestamp with microseconds
  let seconds_and_microseconds = reltimestr(reltime())
  let decimal_i = stridx(seconds_and_microseconds, '.')
  let seconds = seconds_and_microseconds[:decimal_i - 1]
  let microseconds = seconds_and_microseconds[decimal_i + 1:]
  let timestamp = strftime('%T.'.microseconds, seconds)

  " Write to log file
  call writefile(['['.timestamp.'] '.fname.': '.a:message],
        \ '/home/f1/logs/nvim.log', 'a')
endfunction





function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/logs/nvim-verbose.log

        set verbose=5
        echo "verbose set to 1 - writing to log file nvim-verbose.log"
    else
        set verbose=0
        set verbosefile=
    endif
endfunction



function! Fwinsaveview()
let b:winview = winsaveview()
endfunction

function! Fwinrestview()
call winrestview(b:winview)
endfunction



function! Fopen_popup(bufnr) abort
  let options = {
        \ 'pos': 'NW',
        \ 'line': 20,
        \ 'col': 20,
        \ 'maxwidth': 20,
        \ 'minwidth': 20,
        \ 'maxheight': 20,
        \ 'minheight': 15,
        \ 'title': 'asdasd',
        \ 'border': [1, 1, 1, 1],
        \ 'borderhighlight': ['FloatermBorder'],
        \ 'padding': [0,1,0,1],
        \ 'highlight': 'Floaterm',
        \ 'zindex': len(floaterm#buflist#gather()) + 1
        \ }
  let winid = popup_create(a:bufnr, options)
 " call s:init_win(winid, v:false)
" call floaterm#config#set(a:bufnr, 'winid', winid)
  return winid
endfunction





