syn clear markdownLink
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl,mkJdtLink keepend contained
syntax match mkJdtLink /jdt:\/\/.*/ containedin=markdownLink conceal
