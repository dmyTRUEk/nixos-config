-- latex autos

-- TODO: refactor

vim.cmd([[

"autocmd BufReadPost *.tex call SetupEverythingForLatex()

" for manual invocation
func! CompileLatexToPDFsimple()
    ! echo '\n\n\n\n\n' && pdflatex -halt-on-error -synctex=1 %:t
endf

" enable/disable vim to zathura sync
func! LatexAutoSyncDisable()
    let g:is_latex_auto_sync_enabled = 0
endf
func! LatexAutoSyncEnable()
    let g:is_latex_auto_sync_enabled = 1
endf

" enable/disable autocompile
func! LatexAutoCompileDisable()
    let g:is_latex_auto_compile_enabled = 0
endf
func! LatexAutoCompileEnable()
    let g:is_latex_auto_compile_enabled = 1
endf

" enable/disable autocompile and sync
func! LatexAutosDisable()
    call LatexAutoCompileDisable()
    call LatexAutoSyncDisable()
endf
func! LatexAutosEnable()
    call LatexAutoCompileEnable()
    call LatexAutoSyncEnable()
endf

func! SetupEverythingForLatex()
    setlocal spell spelllang=uk,en
    syntax spell toplevel

    nnoremap j gj
    nnoremap k gk
    nnoremap о gj
    nnoremap л gk
    inoremap <C-j> <C-o>gj
    inoremap <C-о> <C-o>gj
    inoremap <C-k> <C-o>gk
    inoremap <C-л> <C-o>gk

    nnoremap 0 g^
    nnoremap - g$

    let g:tex_flavor = 'latex'

    let g:vimtex_quickfix_mode = 0
    let g:vimtex_view_method = 'zathura'

    "let g:AutoPairs["'"] = ""
    "let g:AutoPairs["`"] = ""

    " for autocompile and sync:
    let g:is_latex_auto_sync_enabled = 1
    let g:is_latex_auto_compile_enabled = 1

    autocmd CursorMoved *.tex call LatexSyncFromVimToZathura_async()
    "autocmd CursorMovedI *.tex call LatexSyncFromVimToZathura_async()

    let g:is_latex_compiling_now = 0
    let g:compile_latex_to_pdf_exit_code_last = 1
    let g:compile_latex_to_pdf_exit_code_prev = 1

    " set hold delay
    "set updatetime=1500
    autocmd TextChanged *.tex call CompileLatexToPDF_async()
    autocmd InsertLeave *.tex call CompileLatexToPDF_async()
    "autocmd CursorHoldI *.tex call CompileLatexToPDF_async()
    "autocmd CursorMovedI *.tex call CompileLatexToPDF_async()
endf



func! LatexSyncFromVimToZathura_async()
    if g:compile_latex_to_pdf_exit_code_last == 0 && g:is_latex_auto_sync_enabled
        call jobstart("zathura --synctex-forward " . line('.').":".col('.').":".bufname('%') . " " . expand('%:t:r').".pdf")
    endif
endf

" it's "private", bc `on_exit` can call only public functions
func! PrivateCompileLatextoPDFasync_OnExit(j, c, e)
    let g:compile_latex_to_pdf_exit_code_prev = g:compile_latex_to_pdf_exit_code_last
    let g:compile_latex_to_pdf_exit_code_last = a:c
    echom 'pdflatex finished. exit code: ' . g:compile_latex_to_pdf_exit_code_last

    " this `if` needed for case when prev compile wasnt successful, and
    " therefore simply calling `LatexSyncFromVimToZathura_async()` will
    " open new window + reload old one
    if g:compile_latex_to_pdf_exit_code_prev == 0
        " synchronize latex (vim) and pdf (zathura) using new synctex file
        call LatexSyncFromVimToZathura_async()
    endif

    " unlock another possible instances of this function
    let g:is_latex_compiling_now = 0
endf

func! CompileLatexToPDF_async()
    if g:is_latex_auto_compile_enabled && g:is_latex_compiling_now == 0
        " lock another possible instances of this function
        let g:is_latex_compiling_now = 1

        " save file before compiling
        execute "w"

        " compile file
        call jobstart("pdflatex -halt-on-error -synctex=1 " . bufname("%"), {"on_exit": "PrivateCompileLatextoPDFasync_OnExit"})
    endif
endf

]])
